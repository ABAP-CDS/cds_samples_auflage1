CLASS zcredit_net_calculator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS get_years
      IMPORTING
                payment     TYPE zcredit_pay_offv
      RETURNING VALUE(years_since_start) TYPE i.

ENDCLASS.



CLASS ZCREDIT_NET_CALCULATOR IMPLEMENTATION.


  METHOD get_years.

    years_since_start = payment-posting_date+0(4) - payment-start_year.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: payments TYPE STANDARD TABLE OF zcredit_pay_offv.
    FIELD-SYMBOLS: <payment> TYPE zcredit_pay_offv.

    MOVE-CORRESPONDING it_original_data TO payments.
    LOOP AT payments ASSIGNING <payment>.
      <payment>-net = <payment>-gross /
      ipow( base = ( 1 + <payment>-tribute / 100 ) exp = get_years( <payment> ) ).
    ENDLOOP.
    MOVE-CORRESPONDING payments TO ct_calculated_data.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    LOG-POINT ID ZCREDIT FIELDS iv_entity it_requested_calc_elements.
    IF iv_entity <> 'ZCREDIT_PAY_OFF'.
      RAISE EXCEPTION TYPE zcx_credit_calculator
        EXPORTING
          textid = zcx_credit_calculator=>entity_not_supported.
    ENDIF.

    IF line_exists( it_requested_calc_elements[ table_line = 'NET' ] ).
      INSERT: conv sadl_entity_element( 'TRIBUTE' ) INTO TABLE et_requested_orig_elements,
           conv sadl_entity_element( 'GROSS' ) INTO TABLE et_requested_orig_elements,
           conv sadl_entity_element( 'POSTING_DATE' ) INTO TABLE et_requested_orig_elements,
           conv sadl_entity_element( 'START_YEAR' ) INTO TABLE et_requested_orig_elements.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
