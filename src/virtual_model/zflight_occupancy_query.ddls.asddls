@Analytics.query: true
@VDM.viewType: #CONSUMPTION
@AbapCatalog.sqlViewName: 'zflight_occv'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Occupancy rate of the flights'
define view zflight_occupancy_query as select from zflight_cube {
    @AnalyticsDetails.query.sortDirection: #DESC
    @AnalyticsDetails.query.axis: #ROWS
    key carrid,    
    key connid,
    @AnalyticsDetails.query.axis: #COLUMNS
    @Consumption.filter: {
        selectionType: #RANGE,
        multipleSelections: true,
        mandatory: true
    }
    key fldate,    
    @EndUserText.label: 'free seats'
    @DefaultAggregation: #FORMULA    
    seats_maximum - seats_occupied as free_seats,
    @EndUserText.label: 'available seats'
    @AnalyticsDetails.query.formula: 'seats_maximum - seats_occupied'
    0 as available_seats,
    seats_maximum,
    seats_occupied
} 
 