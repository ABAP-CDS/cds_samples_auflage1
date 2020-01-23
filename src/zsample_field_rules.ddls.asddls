@AbapCatalog.sqlViewName: 'zs_field_rules'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'field rules (arithmetic expressions, case and cast)'
define view zsample_field_rules as select from sflight {
    key carrid,
    key connid,
    key fldate,
    seatsmax - seatsocc as free_seats,
    case planetype when 'A340' then 4 else 2 end as engines,
    cast( price as abap.fltp ) as price_float  
} 
 