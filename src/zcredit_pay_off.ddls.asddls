@AbapCatalog.sqlViewName: 'zcredit_pay_offv'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Pay off for credits'
@OData.publish: true
define view zcredit_pay_off as select from zpaym_credit
  association to zcredit on zcredit.credit_no = zpaym_credit.credit_no {
    
    key zpaym_credit.document_no,
    zpaym_credit.credit_no,
    zcredit.tribute,
    zcredit.start_year,
    @ObjectModel.filter.transformedBy: 'ABAP:ZCREDIT_POSTING_DATE_FILTER'
    cast( zpaym_credit.posting_date as char8) as abap_posting_date,
    zpaym_credit.posting_date,
    @ObjectModel.sort.transformedBy: 'ABAP:ZCREDIT_GROSS_AMOUNT_SORTING'
    zpaym_credit.amount as gross,
    @ObjectModel.readOnly: true
    @ObjectModel.virtualElement: true
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCREDIT_NET_CALCULATOR'
    cast( 0 as abap.curr(10,2) ) as net,
    zpaym_credit.currency  
} 
 