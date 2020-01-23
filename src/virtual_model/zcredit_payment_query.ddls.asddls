@Analytics.query: true
@VDM.viewType: #CONSUMPTION
@AbapCatalog.sqlViewName: 'zcredit_pay_qu'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Credit payment query'
define view zcredit_payment_query as select from zcredit_payments_cube {
    key document_no,
    @Consumption.filter: {
      selectionType: #RANGE,
      multipleSelections: true,      
      defaultValue: '2'
    }
    @AnalyticsDetails.query.axis: #COLUMNS
    credit_no,
    @AnalyticsDetails.query.axis: #COLUMNS
    _credit.country,
    @AnalyticsDetails.query.axis: #COLUMNS
    _credit.borrower,
    @AnalyticsDetails.query.axis: #COLUMNS
    _credit.name,    
    amount,    
    @AnalyticsDetails.query.axis: #ROWS
    posting_date,        
    currency    
}
 