@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE
@AbapCatalog.sqlViewName: 'zcredit_cube_v'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Credit cube'
define view zcredit_cube as select from zcredit_basic {
    *
} 
 