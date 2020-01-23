@Analytics.dataExtraction.enabled: true
@Analytics.dataExtraction.delta.byElement.name: 'posting_date'
@Analytics.dataCategory: #FACT
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'zcredit_paym_d'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Delta extractor for credit payments'
define view zcredit_payments_delta_extract as select from zpaym_credit {
    key document_no,
    credit_no,    
    posting_date,
    amount,
    currency        
} 
 