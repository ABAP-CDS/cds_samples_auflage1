@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
@AbapCatalog.sqlViewName: 'zcredit_pay_cube'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cube for credit payments'
define view zcredit_payments_cube as select from zpaym_credit 
as payments association[1..1] to zcredit_basic as _credit 
on $projection.credit_no = _credit.credit_no{
        
    key payments.document_no,
    @ObjectModel.foreignKey.association: '_credit'
    payments.credit_no,
    payments.posting_date,
    @Semantics.amount.currencyCode: 'currency'
    @DefaultAggregation: #SUM  
    payments.amount,
    payments.currency,
    _credit    
} 
 