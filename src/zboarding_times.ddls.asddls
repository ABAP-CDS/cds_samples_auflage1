@AbapCatalog.sqlViewName: 'zboard_times'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Boarding times'
define view zboarding_times
  with parameters boarding_time : abap.dec(15, 0)
  as select from zdeparture_time {
    key carrid,
    key connid,
    key fldate,
    tstmp_add_seconds(timestamp_depature, -1 * :boarding_time, 'FAIL' )
      as timestamp_boarding
} 
 