*&---------------------------------------------------------------------*
*& Report ztest_extended_view
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_extended_view.

CLASS test_extended_view DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL DANGEROUS.

  PRIVATE SECTION.

    METHODS setup.

    METHODS should_join_spfli_zairport FOR TESTING.

    METHODS teardown.

ENDCLASS.

CLASS test_extended_view IMPLEMENTATION.

    METHOD setup.

      DATA(schedule) = VALUE spfli( carrid = 'BA' connid = 500 airpfrom = 'LON' ).
      MODIFY spfli FROM schedule.
      schedule = VALUE spfli( carrid = 'BA' connid = 510 airpfrom = 'MUC' ).
      MODIFY spfli FROM schedule.

      DATA(airport) = VALUE zairport( id = 'MUC' name = 'Munich' fees = 500 currency = 'EUR' ).
      MODIFY zairport FROM airport.
      COMMIT WORK AND WAIT.

      DATA(airline) = VALUE scarr( carrid = 'BA' carrname = 'British Airways' ).
      MODIFY scarr FROM airline.

    ENDMETHOD.

    METHOD should_join_spfli_zairport.
      DATA: exp_result TYPE demo_cds_original_view.

      exp_result = VALUE #( carrier = 'British Airways'
        flight = 510 fees = 500 currency = 'EUR' ).

      SELECT * FROM demo_cds_original_view INTO TABLE @DATA(act_result)
        WHERE carrier = 'British Airways'.

      cl_abap_unit_assert=>assert_table_contains( line = exp_result table = act_result ).

    ENDMETHOD.

    METHOD teardown.

      DELETE FROM scarr WHERE carrid = 'BA'.
      COMMIT WORK AND WAIT.

    ENDMETHOD.
ENDCLASS.
