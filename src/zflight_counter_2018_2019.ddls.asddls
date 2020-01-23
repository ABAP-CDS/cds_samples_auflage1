@AbapCatalog.sqlViewName: 'zfl_count_18_19'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: false
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight counts 2018, 2019'
define view zflight_counter_2018_2019 as select from 
 spfli association to sflight on sflight.carrid = spfli.carrid
 and sflight.connid = spfli.connid {
    
    key spfli.carrid,
    key spfli.connid,
    avg( sflight[left outer where fldate between '20180101' and '20181231'].price ) as average_price_2018,
    avg( sflight[left outer where fldate between '20190101' and '20191231'].price ) as average_price_2019
    
} group by spfli.carrid, spfli.connid 
 