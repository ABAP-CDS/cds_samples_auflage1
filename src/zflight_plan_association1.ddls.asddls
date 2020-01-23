@AbapCatalog.sqlViewName: 'ypfli_assoc1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight plan and carrier association'
define view zflight_plan_association1 as select from spfli
    association to scarr on scarr.carrid = $projection.carrier {
    
    key carrid as carrier,
    key connid,
    countryfr,
    cityfrom,
    countryto,
    cityto,
    scarr.carrname
    
}  
 