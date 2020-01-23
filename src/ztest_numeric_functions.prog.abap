*&---------------------------------------------------------------------*
*& Report ztest_numeric_functions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_numeric_functions.

CLASS test_numeric_functions DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS setup.

    METHODS execute FOR TESTING.

ENDCLASS.

CLASS test_numeric_functions IMPLEMENTATION.

  METHOD setup.
    DATA: base_values TYPE demo_expressions.

    base_values = VALUE #( id = '1' num1 = 4 num2 = 3 dec3 = '1.5' ).
    MODIFY demo_expressions FROM base_values.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD execute.
    DATA: expected TYPE znumeric_functions.

    expected = VALUE #( id = '1' absolut_value = 4
      next_ge_integer = 2 division_rounded_down = 1
      division_round_2_decimals = '1.33' last_le_integer = 1
      modulo = 1 rounded_0_decimals = 2 ).

    SELECT SINGLE * FROM znumeric_functions INTO @DATA(actual)
      WHERE id = '1'.

    cl_abap_unit_assert=>assert_equals( exp = expected
      act = actual ).

  ENDMETHOD.

ENDCLASS.
