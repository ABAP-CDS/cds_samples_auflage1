@AbapCatalog.sqlViewName: 'zspfli_w_archive'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Scheduled flights with archive'
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST, #UNION]
define view zscheduled_flights_w_archive as select from spfli {
    carrid,
    connid,
    cityfrom,
    cityto
} union all select from zspfli_archive{
    carrid,
    connid,
    cityfrom,
    cityto
}
 