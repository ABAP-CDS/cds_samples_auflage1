@AbapCatalog.sqlViewName: 'zfl_bookingv'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight booking with currency conversion'
define view zflight_booking with parameters booking_no: s_book_id,
  @Environment.systemField: #SYSTEM_DATE
  today: abap.dats
  as select from sbook 
  inner join sflight on sflight.carrid = sbook.carrid
  and sflight.connid = sbook.connid
  and sflight.fldate = sbook.fldate {
    
    key sbook.carrid,
    key sbook.connid,
    key sbook.fldate,
    sbook.bookid,
    currency_conversion( amount => sflight.price,
      source_currency => sflight.currency,
      target_currency => sbook.forcurkey, 
      exchange_rate_date => :today ) as flight_price,
    forcuram as paid,
    forcurkey as currency  
    
} where sbook.bookid = :booking_no 
 