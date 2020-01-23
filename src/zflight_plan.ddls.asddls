@AbapCatalog.sqlViewName: 'zflight_planv'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight plan'
define view zflight_plan as select from spfli {
    *
} 
 