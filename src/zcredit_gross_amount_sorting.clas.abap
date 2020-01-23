CLASS zcredit_gross_amount_sorting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_sort_transform.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcredit_gross_amount_sorting IMPLEMENTATION.

  METHOD if_sadl_exit_sort_transform~map_element.

    IF iv_entity <> 'ZCREDIT_PAY_OFF'.
      RAISE EXCEPTION TYPE zcx_credit_calculator
        EXPORTING
          textid = zcx_credit_calculator=>entity_not_supported.
    ENDIF.

    IF iv_element = 'GROSS'.
      et_sort_elements = VALUE #(
        ( name = 'GROSS' ) ( name = 'POSTING_DATE' )
      ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
