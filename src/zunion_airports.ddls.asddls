@AbapCatalog.sqlViewName: 'zun_airport'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Airports from table sairport and zairport union select'
define view zunion_airports as select from sairport {
    id,
    name
} union select from zairport {
    id,
    name
} 
 