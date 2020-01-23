@AbapCatalog.sqlViewName: 'zflight_plan_pv'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight plan with prices'
define view zflight_plan_with_prices as select from zflight_plan 
 inner join sflight on sflight.carrid = zflight_plan.carrid
 and sflight.connid = zflight_plan.connid {
    key zflight_plan.carrid,
    key zflight_plan.connid,
    key sflight.fldate,
    zflight_plan.cityfrom,
    zflight_plan.countryfr,
    zflight_plan.cityto,
    zflight_plan.countryto,
    zflight_plan.fltime,
    zflight_plan.fltype,
    sflight.price
} 
 