*&---------------------------------------------------------------------*
*& Report ztest_boarding_time
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_boarding_time.

CLASS test_boarding_time DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA: environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS class_setup.

    METHODS setup.

    METHODS boarding_one_hour FOR TESTING.

    CLASS-METHODS class_teardown.

ENDCLASS.

CLASS test_boarding_time IMPLEMENTATION.

  METHOD class_setup.

    environment = cl_cds_test_environment=>create( 'zboarding_times' ).

  ENDMETHOD.

  METHOD setup.
    DATA: departure_times TYPE STANDARD TABLE OF zdep_time.

    environment->clear_doubles( ).

    departure_times = VALUE #( ( mandt = sy-mandt carrid = 'LH'
      connid = '300' fldate = '20200202' timestamp_depature = 20200202110000 ) ).

    DATA(stub_departure) = cl_cds_test_data=>create( departure_times ).
    environment->get_double( 'zdep_time' )->insert( stub_departure ).


  ENDMETHOD.

  METHOD boarding_one_hour.
    DATA: expected TYPE zboarding_times.

    expected = VALUE #( carrid = 'LH' connid = '300' fldate = '20200202'
      timestamp_boarding = 20200202100000 ).

    SELECT SINGLE * FROM zboarding_times( boarding_time = 3600 )
      "WHERE carrid = 'LH' AND connid = '300' AND fldate = '20200202'
      INTO @DATA(actual).

    cl_abap_unit_assert=>assert_equals( exp = expected act = actual ).

  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

ENDCLASS.
