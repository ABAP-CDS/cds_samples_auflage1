@AbapCatalog.sqlViewName: 'zflight_occ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Occupancy of the flight'
define view zflight_occupancy as select from sflight
    association [1..1] to sbook on $projection.carrid = sbook.carrid
    and $projection.connid = sbook.connid and $projection.fldate = sbook.fldate
{
    key sflight.carrid,
    key sflight.connid,
    key sflight.fldate,
    sbook.cancelled as cancelled,
    sum( case sbook.class when 'Y' then 1 else 0 end ) as seatsocc,
    sum( case sbook.class when 'C' then 1 else 0 end ) as seatsocc_b
}group by sflight.carrid, sflight.connid, sflight.fldate, sbook.cancelled
 