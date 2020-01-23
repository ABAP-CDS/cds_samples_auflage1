@AbapCatalog.sqlViewName: 'zfl_time_zone'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight-plan with timezones'
define view zflight_plan_timezones as select from spfli 
association to sairport as airport_depature on airport_depature.id = spfli.airpfrom 
association to sairport as airport_arrival on airport_arrival.id = spfli.airpto
{
    key spfli.carrid,
    key spfli.connid,
    
    spfli.airpfrom as airport_depature,
    spfli.airpto as airport_arrival,
    airport_depature[left outer].time_zone as time_zone_depature,
    airport_arrival[left outer].time_zone as time_zone_arrival
} 
 