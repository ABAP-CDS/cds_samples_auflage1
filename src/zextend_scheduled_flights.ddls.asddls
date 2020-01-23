@AbapCatalog.sqlViewAppendName: 'zext_sch_flights'
@EndUserText.label: 'Extension for scheduled flights'
extend view zscheduled_flights_w_archive with zextend_scheduled_flights{
    airpfrom,
    airpto
} union all{
    airpfrom,
    airpto
} 
 