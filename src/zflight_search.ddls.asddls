@AbapCatalog.sqlViewName: 'zfl_search'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS view with parameters'
@OData.publish: true
define view zflight_search with parameters 
city_from: s_from_cit, city_to: s_to_city, flight_date: s_date
as select from spfli inner join sflight on sflight.carrid = spfli.carrid
and  sflight.connid = spfli.connid and sflight.fldate = :flight_date
  {
    key spfli.carrid,
    key spfli.connid,
    sflight.fldate,
    cityfrom,
    cityto,
    distance,
    distid
} where cityfrom = :city_from and cityto = :city_to 
 