*&---------------------------------------------------------------------*
*& Report ztest_union_flight_schedule
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_union_flight_schedule.

CLASS test_union_flight_schedule DEFINITION
  FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS setup.

    METHODS should_read_splfi_and_archive FOR TESTING.

ENDCLASS.

CLASS test_union_flight_schedule IMPLEMENTATION.

  METHOD setup.

    DATA(schedule) = VALUE spfli( carrid = 'BA' connid = 510 cityfrom = 'London' airpfrom = 'LON' airpto = 'MUC' ).
    DATA(schedule_archive) = VALUE zspfli_archive( carrid = 'BA' connid = 520 cityfrom = 'London' airpfrom = 'LON' airpto = 'FRA' ).

    MODIFY spfli FROM schedule.
    MODIFY zspfli_archive FROM schedule_archive.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD should_read_splfi_and_archive.
    DATA: exp_result TYPE STANDARD TABLE OF zscheduled_flights_w_archive.

    exp_result = VALUE #(
      ( carrid = 'BA' connid = 510 cityfrom = 'London' airpfrom = 'LON' airpto = 'MUC' )
      ( carrid = 'BA' connid = 520 cityfrom = 'London' airpfrom = 'LON' airpto = 'FRA' )
    ).

    SELECT * FROM zscheduled_flights_w_archive INTO TABLE @DATA(act_result)
      WHERE carrid = 'BA' and connid IN (510, 520)
      ORDER BY connid.

    cl_abap_unit_assert=>assert_equals( exp = exp_result act = act_result ).

  ENDMETHOD.

ENDCLASS.
