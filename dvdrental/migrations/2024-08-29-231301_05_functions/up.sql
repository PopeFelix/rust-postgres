CREATE FUNCTION public._group_concat(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$;


ALTER FUNCTION public._group_concat(text, text) OWNER TO postgres;

--
-- Name: get_customer_balance(integer, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_customer_balance(p_customer_id integer, p_effective_date timestamp without time zone) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
       --#OK, WE NEED TO CALCULATE THE CURRENT BALANCE GIVEN A CUSTOMER_ID AND A DATE
       --#THAT WE WANT THE BALANCE TO BE EFFECTIVE FOR. THE BALANCE IS:
       --#   1) RENTAL FEES FOR ALL PREVIOUS RENTALS
       --#   2) ONE DOLLAR FOR EVERY DAY THE PREVIOUS RENTALS ARE OVERDUE
       --#   3) IF A FILM IS MORE THAN RENTAL_DURATION * 2 OVERDUE, CHARGE THE REPLACEMENT_COST
       --#   4) SUBTRACT ALL PAYMENTS MADE BEFORE THE DATE SPECIFIED
DECLARE
    v_rentfees DECIMAL(5,2); --#FEES PAID TO RENT THE VIDEOS INITIALLY
    v_overfees INTEGER;      --#LATE FEES FOR PRIOR RENTALS
    v_payments DECIMAL(5,2); --#SUM OF PAYMENTS MADE PREVIOUSLY
BEGIN
    SELECT COALESCE(SUM(films.rental_rate),0) INTO v_rentfees
    FROM films, inventory, rentals
    WHERE films.film_id = inventory.film_id
      AND inventory.inventory_id = rentals.inventory_id
      AND rentals.rental_date <= p_effective_date
      AND rentals.customer_id = p_customer_id;

    SELECT COALESCE(SUM(IF((rentals.return_date - rentals.rental_date) > (films.rental_duration * '1 day'::interval),
        ((rentals.return_date - rentals.rental_date) - (films.rental_duration * '1 day'::interval)),0)),0) INTO v_overfees
    FROM rentals, inventory, films
    WHERE films.film_id = inventory.film_id
      AND inventory.inventory_id = rentals.inventory_id
      AND rentals.rental_date <= p_effective_date
      AND rentals.customer_id = p_customer_id;

    SELECT COALESCE(SUM(payments.amount),0) INTO v_payments
    FROM payments
    WHERE payments.payment_date <= p_effective_date
    AND payments.customer_id = p_customer_id;

    RETURN v_rentfees + v_overfees - v_payments;
END
$$;


ALTER FUNCTION public.get_customer_balance(p_customer_id integer, p_effective_date timestamp without time zone) OWNER TO postgres;

--
-- Name: inventory_held_by_customers(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.inventory_held_by_customers(p_inventory_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_customer_id INTEGER;
BEGIN

  SELECT customer_id INTO v_customer_id
  FROM rentals
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;

  RETURN v_customer_id;
END $$;


ALTER FUNCTION public.inventory_held_by_customers(p_inventory_id integer) OWNER TO postgres;

--
-- Name: inventory_in_stock(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.inventory_in_stock(p_inventory_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_rentals INTEGER;
    v_out     INTEGER;
BEGIN
    -- AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rentals TABLE
    -- FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT count(*) INTO v_rentals
    FROM rentals
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rentals USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rentals.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END $$;


ALTER FUNCTION public.inventory_in_stock(p_inventory_id integer) OWNER TO postgres;

--
-- Name: film_in_stock(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.film_in_stock(p_film_id integer, p_store_id integer, OUT p_film_count integer) RETURNS SETOF integer
    LANGUAGE sql
    AS $_$
     SELECT inventory_id
     FROM inventory
     WHERE film_id = $1
     AND store_id = $2
     AND inventory_in_stock(inventory_id);
$_$;


ALTER FUNCTION public.film_in_stock(p_film_id integer, p_store_id integer, OUT p_film_count integer) OWNER TO postgres;

--
-- Name: film_not_in_stock(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.film_not_in_stock(p_film_id integer, p_store_id integer, OUT p_film_count integer) RETURNS SETOF integer
    LANGUAGE sql
    AS $_$
    SELECT inventory_id
    FROM inventory
    WHERE film_id = $1
    AND store_id = $2
    AND NOT inventory_in_stock(inventory_id);
$_$;


ALTER FUNCTION public.film_not_in_stock(p_film_id integer, p_store_id integer, OUT p_film_count integer) OWNER TO postgres;


--
-- Name: last_day(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_day(timestamp without time zone) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT CASE
    WHEN EXTRACT(MONTH FROM $1) = 12 THEN
      (((EXTRACT(YEAR FROM $1) + 1) operator(pg_catalog.||) '-01-01')::date - INTERVAL '1 day')::date
    ELSE
      ((EXTRACT(YEAR FROM $1) operator(pg_catalog.||) '-' operator(pg_catalog.||) (EXTRACT(MONTH FROM $1) + 1) operator(pg_catalog.||) '-01')::date - INTERVAL '1 day')::date
    END
$_$;


ALTER FUNCTION public.last_day(timestamp without time zone) OWNER TO postgres;

--
-- Name: last_updated(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;


ALTER FUNCTION public.last_updated() OWNER TO postgres;

--
-- Name: rewards_report(integer, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rewards_report(min_monthly_purchases integer, min_dollar_amount_purchased numeric) RETURNS SETOF public.customers
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
DECLARE
    last_month_start DATE;
    last_month_end DATE;
rr RECORD;
tmpSQL TEXT;
BEGIN

    /* Some sanity checks... */
    IF min_monthly_purchases = 0 THEN
        RAISE EXCEPTION 'Minimum monthly purchases parameter must be > 0';
    END IF;
    IF min_dollar_amount_purchased = 0.00 THEN
        RAISE EXCEPTION 'Minimum monthly dollar amount purchased parameter must be > $0.00';
    END IF;

    last_month_start := CURRENT_DATE - '3 month'::interval;
    last_month_start := to_date((extract(YEAR FROM last_month_start) || '-' || extract(MONTH FROM last_month_start) || '-01'),'YYYY-MM-DD');
    last_month_end := LAST_DAY(last_month_start);

    /*
    Create a temporary storage area for Customer IDs.
    */
    CREATE TEMPORARY TABLE tmpCustomer (customer_id INTEGER NOT NULL PRIMARY KEY);

    /*
    Find all customers meeting the monthly purchase requirements
    */

    tmpSQL := 'INSERT INTO tmpCustomer (customer_id)
        SELECT p.customer_id
        FROM payments AS p
        WHERE DATE(p.payment_date) BETWEEN '||quote_literal(last_month_start) ||' AND '|| quote_literal(last_month_end) || '
        GROUP BY customer_id
        HAVING SUM(p.amount) > '|| min_dollar_amount_purchased || '
        AND COUNT(customer_id) > ' ||min_monthly_purchases ;

    EXECUTE tmpSQL;

    /*
    Output ALL customers information of matching rewardees.
    Customize output as needed.
    */
    FOR rr IN EXECUTE 'SELECT c.* FROM tmpCustomer AS t INNER JOIN customers AS c ON t.customer_id = c.customer_id' LOOP
        RETURN NEXT rr;
    END LOOP;

    /* Clean up */
    tmpSQL := 'DROP TABLE tmpCustomer';
    EXECUTE tmpSQL;

RETURN;
END
$_$;


ALTER FUNCTION public.rewards_report(min_monthly_purchases integer, min_dollar_amount_purchased numeric) OWNER TO postgres;

--
-- Name: group_concat(text); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE public.group_concat(text) (
    SFUNC = public._group_concat,
    STYPE = text
);


ALTER AGGREGATE public.group_concat(text) OWNER TO postgres;


-- Your SQL goes here
