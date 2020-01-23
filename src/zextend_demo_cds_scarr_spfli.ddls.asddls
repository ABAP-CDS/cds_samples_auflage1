@AbapCatalog.sqlViewAppendName: 'zextcarr_plan'
@EndUserText.label: 'View extensions for demo_cds_original_view'
extend view demo_cds_original_view with zextend_demo_cds_scarr_spfli {
       spfli.fltime 
}
 