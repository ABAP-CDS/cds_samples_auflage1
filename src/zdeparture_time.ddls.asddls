@AbapCatalog.sqlViewName: 'zdep_time'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Departure time for flights'
define view zdeparture_time
  as select from spfli
    inner join   sflight  on sflight.carrid = spfli.carrid
    inner join   sairport on  sairport.id    = spfli.airpfrom
                          and sflight.connid = spfli.connid{
    key sflight.carrid,
    key sflight.connid,
    key sflight.fldate,
    dats_tims_to_tstmp( sflight.fldate, spfli.deptime, sairport.time_zone,
                        $session.client, 'FAIL' ) as timestamp_depature
} 
 