@AbapCatalog.sqlViewName: 'zspfli_assoc_o'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Association flight-plan with last flight'
define view zflight_plan_association_o as select from spfli
    association to sflight on spfli.carrid = sflight.carrid and spfli.connid = sflight.connid {

    key spfli.carrid,
    key spfli.connid,
    max( sflight[left outer].fldate ) as last_flight_date

} group by spfli.carrid, spfli.connid 
 