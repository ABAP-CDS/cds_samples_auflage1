@AbapCatalog.sqlViewName: 'ypfli_assoc'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight plan and carrier association'
define view zflight_plan_association as select from spfli
    association to scarr on scarr.carrid = spfli.carrid {
    
    key carrid,
    key connid,
    countryfr,
    cityfrom,
    countryto,
    cityto,
    scarr.carrname
    
} 
 