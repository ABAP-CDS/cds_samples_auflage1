*&---------------------------------------------------------------------*
*& Report ztest_credit_pay_off
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_credit_pay_off.

CLASS test_view_zcredit_pay_off DEFINITION
    FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS setup.

    METHODS should_ret_tribute_2_years FOR TESTING.

ENDCLASS.

CLASS test_view_zcredit_pay_off IMPLEMENTATION.

  METHOD setup.
    DATA: credit  TYPE zcredit,
          borrower TYPE zborrower,
          payment TYPE zpaym_credit.

    DELETE FROM: zborrower, zcredit, zpaym_credit.

    borrower = VALUE #( borrower_no = '0000000010' name = 'Hans Maier' street = 'Blochstr.9'
      city_code = '89251' city = 'Senden' country = 'DE' ).
    INSERT zborrower FROM borrower.
    credit = VALUE #( credit_no = 1 tribute = 5 start_year = '2018' borrower = '0000000010' ).
    INSERT zcredit FROM credit.
    credit = VALUE #( credit_no = 2 tribute = 5 start_year = '2018' borrower = '0000000010' ).
    INSERT zcredit FROM credit.

    payment = VALUE #( document_no = '1' credit_no = 1
        posting_date = '20200301' amount = 1000 currency = 'EUR' ).
    INSERT zpaym_credit FROM payment.
    payment = VALUE #( document_no = '3' credit_no = 1
        posting_date = '20200401' amount = 1000 currency = 'EUR' ).
    INSERT zpaym_credit FROM payment.
    payment = VALUE #( document_no = '2' credit_no = 1
        posting_date = '20200501' amount = 2000 currency = 'EUR' ).
    INSERT zpaym_credit FROM payment.
    payment = VALUE #( document_no = '5' credit_no = 1
        posting_date = '20181223' amount = 2000 currency = 'EUR' ).
    INSERT zpaym_credit FROM payment.
    payment = VALUE #( document_no = '6' credit_no = 2
        posting_date = '20181223' amount = 2000 currency = 'EUR' ).
    INSERT zpaym_credit FROM payment.

    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD should_ret_tribute_2_years.
    DATA: exp_payment TYPE zcredit_pay_off.

    exp_payment = VALUE #(
      document_no = '1' credit_no = 1 tribute = 5 start_year = '2018'
      posting_date = '20200301' gross = 1000 net = '907.03'
      currency = 'EUR' ).

    SELECT * UP TO 1 ROWS FROM zcredit_pay_off INTO @DATA(act_payment)
      WHERE credit_no = 1.
    ENDSELECT.

    cl_abap_unit_assert=>assert_equals( exp = exp_payment
      act = act_payment ).

  ENDMETHOD.

ENDCLASS.
