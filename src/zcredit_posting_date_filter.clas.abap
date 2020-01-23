CLASS zcredit_posting_date_filter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_filter_transform.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcredit_posting_date_filter IMPLEMENTATION.

  METHOD if_sadl_exit_filter_transform~map_atom.
    DATA: condition_manager   TYPE REF TO if_sadl_simple_cond_factory,
          posting_date_filter TYPE REF TO if_sadl_simple_cond_element,
          posting_date_from   TYPE d,
          posting_date_until  TYPE d.

    IF iv_element <> 'ABAP_POSTING_DATE'.
      RAISE EXCEPTION TYPE zcx_credit_calculator
        EXPORTING
          textid = zcx_credit_calculator=>filter_element_wrong.
    ENDIF.

    condition_manager = cl_sadl_cond_prov_factory_pub=>create_simple_cond_factory( ).
    posting_date_filter = condition_manager->element( 'POSTING_DATE' ).

    IF strlen( iv_value ) = 4.
      posting_date_from = iv_value && '0101'.
      posting_date_until = iv_value && '1231'.
    ELSE.
      posting_date_from = iv_value.
      posting_date_until = iv_value.
    ENDIF.

    CASE iv_operator.
      WHEN if_sadl_exit_filter_transform~co_operator-equals.
        ro_condition = posting_date_filter->between(
          iv_low = posting_date_from iv_high = posting_date_until ).
      WHEN if_sadl_exit_filter_transform~co_operator-less_than.
        ro_condition = posting_date_filter->less_than( posting_date_from ).
      WHEN if_sadl_exit_filter_transform~co_operator-greater_than.
        ro_condition = posting_date_filter->greater_than( posting_date_until ).
      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_sadl_exit_filter_not_supp.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.
