@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #CUBE
@AbapCatalog.sqlViewName: 'zflight_cubev'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight cube'
define view zflight_cube as select from sflight {
    key carrid,
    key connid,
    key fldate,
    @DefaultAggregation: #SUM
    seatsmax as seats_maximum,
    @DefaultAggregation: #SUM
    seatsocc as seats_occupied
} 
 