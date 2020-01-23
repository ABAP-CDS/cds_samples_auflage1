*&---------------------------------------------------------------------*
*& Report ztest_flight_plan_association
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_flight_plan_association.

CLASS association_with_joins DEFINITION FOR TESTING
    DURATION SHORT RISK LEVEL HARMLESS.

    PRIVATE SECTION.

        METHODS setup.

        METHODS should_be_inner_join FOR TESTING.

        METHODS should_be_left_outer_join FOR TESTING.

        METHODS with_open_sql FOR TESTING.

ENDCLASS.

CLASS association_with_joins IMPLEMENTATION.

    METHOD setup.
        DATA: plan TYPE STANDARD TABLE OF spfli,
              carrier TYPE STANDARD TABLE OF scarr,
              flights TYPE STANDARD TABLE OF sflight.

        DELETE FROM sflight WHERE carrid = 'EK' AND connid = '500'.
        flights = VALUE #(
            ( carrid = 'EK' connid = '500' fldate = '20190910' seatsmax = 500 seatsocc = 500 )
            ( carrid = 'EK' connid = '500' fldate = '20190920' seatsmax = 500 seatsocc = 400 )
        ).
        INSERT sflight FROM TABLE flights.

        DELETE FROM: spfli WHERE carrid IN ('EK', 'LH').
        plan = VALUE #(
        ( carrid = 'EK' connid = '500' countryfr = 'DE' cityfrom = 'Munich'
          countryto = 'UAE' cityto = 'Dubai' )
        ( carrid = 'EK' connid = '600' countryfr = 'DE' cityfrom = 'Frankfurt'
          countryto = 'UAE' cityto = 'Dubai' )
        ).
        INSERT spfli FROM TABLE plan.

        carrier = VALUE #(
            ( carrid = 'EK' carrname = 'Emirates' )
            ( carrid = 'LH' carrname = 'Lufthansa' )
        ).
        MODIFY scarr FROM TABLE carrier.

        COMMIT WORK AND WAIT.

    ENDMETHOD.

    METHOD should_be_inner_join.
        DATA: act_result TYPE STANDARD TABLE OF zflight_plan_association.

        SELECT * FROM zflight_plan_association INTO TABLE @act_result
            WHERE carrid IN ('EK', 'LH').

        DATA(carrier_lh_found) = xsdbool( line_exists( act_result[ carrid = 'LH' ] ) ).
        cl_abap_unit_assert=>assert_false( act = carrier_lh_found ).

    ENDMETHOD.

    METHOD should_be_left_outer_join.
      DATA: exp_result TYPE STANDARD TABLE OF zflight_plan_association_o,
            act_result LIKE exp_result.

      exp_result = VALUE #(
        ( carrid = 'EK' connid = '500' last_flight_date = '20190920' )
        ( carrid = 'EK' connid = '600' )
      ).

      SELECT * FROM zflight_plan_association_o INTO TABLE @act_result
        WHERE carrid = 'EK'
        ORDER BY PRIMARY KEY.

      cl_abap_unit_assert=>assert_equals( exp = exp_result
        act = act_result ).

    ENDMETHOD.

    METHOD with_open_sql.
      DATA: exp_result TYPE STANDARD TABLE OF zflight_plan_association_o,
            act_result LIKE exp_result.

      exp_result = VALUE #(
        ( carrid = 'EK' connid = '500' last_flight_date = '20190920' )
        ( carrid = 'EK' connid = '600' )
      ).

      SELECT p~carrid, p~connid, max( f~fldate ) AS last_flight_date
        FROM spfli AS p LEFT OUTER JOIN sflight AS f
        ON f~carrid = p~carrid AND f~connid = p~connid
        INTO CORRESPONDING FIELDS OF TABLE @act_result
        WHERE p~carrid = 'EK'
        GROUP BY p~carrid, p~connid.

      SORT act_result BY carrid connid.

      cl_abap_unit_assert=>assert_equals( exp = exp_result
        act = act_result ).


    ENDMETHOD.

ENDCLASS.
