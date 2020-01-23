@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'country'
@ObjectModel.dataCategory: #TEXT
@AbapCatalog.sqlViewName: 'zcountry_text_v'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@EndUserText.label: 'Country text view'
define view zcountry_texts as select from t005t {

    @Semantics.language: true
    key spras as language,
    key land1 as country,
    @Semantics.text: true
    landx as name    
} where spras = $session.system_language
 