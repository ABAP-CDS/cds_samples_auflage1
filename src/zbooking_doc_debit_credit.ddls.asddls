@AbapCatalog.sqlViewName: 'zdoc_dc'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking document splitted debit and credit'
@OData.publish: true
define view zbooking_doc_debit_credit as select from ybkpf as h
 inner join ybseg as i on h.gjahr = i.gjahr and h.belnr = i.belnr and h.bukrs = i.bukrs {

    key h.gjahr as gjahr,
    key h.belnr as belnr,
    key h.bukrs as bukrs,
    key i.buzei as buzei,
    h.budat as budat,
    case i.shkzg when 'S' then i.dmbtr else 0 end as debit,
    case i.shkzg when 'H' then i.dmbtr else 0 end as credit

} 
 