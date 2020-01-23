@AbapCatalog.sqlViewAppendName: 'zext_splfi_airpr'
@EndUserText.label: 'View extension for demo_cds_original_view with airport'
extend view demo_cds_original_view with zextend_spfli_with_airport
  association to zairport on zairport.id = spfli.airpfrom{
    zairport[left outer].fees,
    zairport[left outer].currency
} 
 