@AbapCatalog.sqlViewName: 'zs_agg_func'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sample for aggregate function'
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST, #GROUP_BY]
@Metadata.allowExtensions
define view ZSAMPLE_aggregat_functions as select from sflight {
    key carrid,
    key connid,
    sum( paymentsum ) as paymentsum,
    max( price ) as max_price,
    min( price ) as min_price,
    avg( price ) as average_price,
    count(*) as count_flights
} group by carrid, connid 
 