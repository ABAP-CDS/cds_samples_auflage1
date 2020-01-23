@AbapCatalog.sqlViewName: 'zcal_functions'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Calendar functions'
define view zcalendar_functions
  with parameters date_from: abap.dats 
  as select from thoc {
  
  key thoc.ident,
  key thoc.datum,
  key thoc.ftgid,
  case dats_is_valid( thoc.datum ) when 1 then 'Feiertag gueltig' else 'Feierag ungueltig' end
    as is_valid,
  //Anzahl Tage zwischen Feiertag und Beginn Selektion
  dats_days_between(:date_from, thoc.datum ) as number_of_days
    
} where thoc.datum between :date_from and 
  dats_add_days(dats_add_months(:date_from, 11, 'FAIL' ), 30, 'FAIL')  
 