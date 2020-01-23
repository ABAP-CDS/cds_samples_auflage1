*&---------------------------------------------------------------------*
*& Report ztest_flight_plan_timezones
*&---------------------------------------------------------------------*
REPORT ztest_flight_plan_timezones.

CLASS prepare_and_verify DEFINITION FOR TESTING
    DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS setup.

    "! depature-timezone should be gmt
    "! arrival-timezone should be cet (europe)
    METHODS should_be_gmt_cet FOR TESTING.

ENDCLASS.

CLASS prepare_and_verify IMPLEMENTATION.

  METHOD setup.
    DATA: plan     TYPE spfli,
          airports TYPE STANDARD TABLE OF sairport.

    plan = VALUE #( carrid = 'LH' connid = '450' airpfrom = 'LON'
                    airpto = 'MUC' ).
    MODIFY spfli FROM plan.

    airports = VALUE #(
     ( id = 'LON' name = 'London' time_zone = 'GMT' )
     ( id = 'MUC' name = 'Munich' time_zone = 'CET' )
    ).
    MODIFY sairport FROM TABLE airports.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD should_be_gmt_cet.
    DATA: exp_plan_timezones TYPE zflight_plan_timezones,
          act_plan_timezones TYPE zflight_plan_timezones.

    exp_plan_timezones = VALUE #( carrid = 'LH' connid = '450'
        airport_depature = 'LON' airport_arrival = 'MUC'
        time_zone_depature = 'GMT' time_zone_arrival = 'CET' ).

    SELECT SINGLE * FROM zflight_plan_timezones INTO @act_plan_timezones
      WHERE carrid = 'LH' AND connid = '450'.

    cl_abap_unit_assert=>assert_equals( exp = exp_plan_timezones
        act = act_plan_timezones ).

  ENDMETHOD.


ENDCLASS.
