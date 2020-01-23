*&---------------------------------------------------------------------*
*& Report ztest_char_functions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_char_functions.

CLASS test_char_functions DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS setup.

    METHODS execute_all FOR TESTING.

ENDCLASS.

CLASS test_char_functions IMPLEMENTATION.

  METHOD setup.
    DATA: customer TYPE scustom.

    customer = VALUE #( id = 1 form = 'Frau' name = 'Lisa Mueller'
      postbox = '03040' street = 'Goethe Strasse' telephone = '0071333/555' ).
    MODIFY scustom FROM customer.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD execute_all.
    DATA: expected TYPE zstring_functions.

    expected = VALUE #( id = 1 salutation_without_space = 'FrauLisa Mueller'
      salutation_with_space = 'Frau Lisa Mueller' position_separator = 8
      first_3_chars = '007' length_telephone_no = 11 name_lower = 'lisa mueller'
      postbox_leading_zeros = '0000003040' postbox_wo_leading_zeros = '3040'
      street = 'Goethe Str.' last_5_chars = '3/555'
      postbox_trailing_zeros = '0304000000' trimed_post_box = '0304'
      telephone_no_from_2_to_3 = '07' name_upper = 'LISA MUELLER' ).

    SELECT SINGLE * FROM zstring_functions INTO @DATA(actual)
      WHERE id = 1.

    cl_abap_unit_assert=>assert_equals( exp = expected act = actual ).
  ENDMETHOD.

ENDCLASS.
