*&---------------------------------------------------------------------*
*& Report ztest_union_airports
*&---------------------------------------------------------------------*
REPORT ztest_union_airports.

CLASS test_union_airports DEFINITION FOR TESTING DURATION SHORT
    RISK LEVEL DANGEROUS.

  PRIVATE SECTION.

    METHODS setup.

    METHODS should_return_all FOR TESTING.

ENDCLASS.

CLASS test_union_airports IMPLEMENTATION.

  METHOD setup.
    DATA: sairports TYPE STANDARD TABLE OF sairport,
          zairports TYPE STANDARD TABLE OF zairport.

    DELETE FROM: sairport, zairport.

    sairports = VALUE #(
      ( id = 'MUC' name = 'Munich' )
      ( id = 'FRA' name = 'Frankfurt' )
    ).
    zairports = VALUE #(
      ( id = 'MUC' name = 'Munich' )
      ( id = 'DXB' name = 'Dubai' )
    ).

    INSERT sairport FROM TABLE sairports.
    INSERT zairport FROM TABLE zairports.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD should_return_all.
    DATA: exp_airports TYPE STANDARD TABLE OF zunion_airports,
          act_airports LIKE exp_airports.

    exp_airports = VALUE #(
      ( id = 'DXB' name = 'Dubai' )
      ( id = 'FRA' name = 'Frankfurt' )
      ( id = 'MUC' name = 'Munich' )
    ).

    SELECT * FROM zunion_airports INTO TABLE @act_airports
      ORDER BY id.

    cl_abap_unit_assert=>assert_equals( exp = exp_airports
      act = act_airports ).

  ENDMETHOD.

ENDCLASS.

CLASS test_union_airports_double DEFINITION FOR TESTING
  DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA: environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS class_setup.

    METHODS setup.

    METHODS should_return_all FOR TESTING.

    CLASS-METHODS class_teardown.

ENDCLASS.

CLASS test_union_airports_double IMPLEMENTATION.

  METHOD class_setup.

    environment = cl_cds_test_environment=>create( EXPORTING
      i_for_entity = 'ZUNION_AIRPORTS' ).

  ENDMETHOD.

  METHOD setup.
    DATA: sairports TYPE STANDARD TABLE OF sairport,
          zairports TYPE STANDARD TABLE OF zairport.

    environment->clear_doubles( ).

    sairports = VALUE #(
      ( mandt = sy-mandt id = 'MUC' name = 'Munich' )
      ( mandt = sy-mandt id = 'FRA' name = 'Frankfurt' )
    ).
    zairports = VALUE #(
      ( mandt = sy-mandt id = 'MUC' name = 'Munich' )
      ( mandt = sy-mandt id = 'DXB' name = 'Dubai' )
    ).

    DATA(test_data_sairport) = cl_cds_test_data=>create( sairports ).
    environment->get_double( 'SAIRPORT' )->insert(  test_data_sairport ).

    DATA(test_data_zairport) = cl_cds_test_data=>create( zairports ).
    environment->get_double( 'ZAIRPORT' )->insert(  test_data_zairport ).

  ENDMETHOD.

  METHOD should_return_all.
    DATA: exp_airports TYPE STANDARD TABLE OF zunion_airports,
          act_airports LIKE exp_airports.

    exp_airports = VALUE #(
      ( id = 'DXB' name = 'Dubai' )
      ( id = 'FRA' name = 'Frankfurt' )
      ( id = 'MUC' name = 'Munich' )
    ).

    SELECT * FROM zunion_airports INTO TABLE @act_airports
      ORDER BY id.

    cl_abap_unit_assert=>assert_equals( exp = exp_airports
      act = act_airports ).

  ENDMETHOD.

  METHOD class_teardown.

    environment->destroy( ).

  ENDMETHOD.

ENDCLASS.
