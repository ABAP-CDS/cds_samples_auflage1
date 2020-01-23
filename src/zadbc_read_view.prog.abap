*&---------------------------------------------------------------------*
*& Report zadbc_read_view
*&---------------------------------------------------------------------*
REPORT zadbc_read_view.

START-OF-SELECTION.
  TYPES: BEGIN OF _flight_booking,
           carrier        TYPE sbook-carrid,
           connection     TYPE sbook-connid,
           flight_date    TYPE sbook-fldate,
           booking_number TYPE sbook-bookid,
         END OF _flight_booking.
  DATA: flight_bookings TYPE STANDARD TABLE OF _flight_booking,
        columns         TYPE adbc_column_tab.

  columns = VALUE #(
      ( 'CARRIER' )
      ( 'CONNECTION' )
      ( 'FLIGHT_DATE' )
      ( 'BOOKING_NUMBER' )
  ).

  DATA(result_set) = NEW cl_sql_statement( )->execute_query(
      `SELECT carrid AS carrier connid AS connection ` &&
      `FROM SAPSR3.SBOOK ` &&
      `WHERE mandt = ` && `'` && sy-mandt && `' AND ` &&
      `carrid = 'LH'`).

  result_set->set_param_table( itab_ref = REF #( flight_bookings )
  corresponding_fields = columns ).
  IF result_set->next_package( ) > 0.
    cl_demo_output=>display( flight_bookings ).
  ENDIF.
