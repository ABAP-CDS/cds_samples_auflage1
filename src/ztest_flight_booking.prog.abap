*&---------------------------------------------------------------------*
*& Report ZTEST_FLIGHT_BOOKING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTEST_FLIGHT_BOOKING.

CLASS test_flight_booking DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA: environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS class_setup.

    METHODS setup.

    METHODS should_use_conv_rate_of_2 FOR TESTING.

    CLASS-METHODS class_teardown.

ENDCLASS.

CLASS test_flight_booking IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( 'zflight_booking' ).
  ENDMETHOD.

  METHOD setup.
    DATA: flights TYPE STANDARD TABLE OF sflight,
          bookings TYPE STANDARD TABLE OF sbook.

    flights = VALUE #(
      ( mandt = sy-mandt carrid = 'LH' connid = '200' fldate = '20200201' price = 500 currency = 'EUR' )
    ).
    bookings = VALUE #(
      ( mandt = sy-mandt carrid = 'LH' connid = '200' fldate = '20200201' bookid = 1
        forcuram = 400 forcurkey = 'USD' )
    ).

    DATA(test_data_flights) = cl_cds_test_data=>create( flights ).
    environment->get_double( 'sflight' )->insert( test_data_flights ).
    DATA(test_data_bookings) = cl_cds_test_data=>create( bookings ).
    environment->get_double( 'sbook' )->insert( test_data_bookings ).

    DATA(stub_currency_amount) =
     cl_cds_test_data=>create_currency_conv_data( 1000 )->for_parameters(
        amount = 500 source_currency = 'EUR' target_currency = 'USD'
        exchange_rate_date = sy-datum ).
    environment->get_double( cl_cds_test_environment=>currency_conversion
      )->insert( stub_currency_amount ).

  ENDMETHOD.

  METHOD should_use_conv_rate_of_2.
    DATA: exp_booking TYPE STANDARD TABLE OF zflight_booking.

    exp_booking = VALUE #( ( carrid = 'LH' connid = '200' fldate = '20200201'
      bookid = 1 flight_price = 1000 paid = 400 currency = 'USD' ) ).

    SELECT * FROM zflight_booking( booking_no = 1 )
      WHERE carrid = 'LH' AND connid = '200'
      INTO TABLE @DATA(act_booking).

    cl_abap_unit_assert=>assert_equals( exp = exp_booking
      act = act_booking ).

  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

ENDCLASS.
