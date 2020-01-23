@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'currency_code'
@ObjectModel.dataCategory: #TEXT
@AbapCatalog.sqlViewName: 'zcur_texts_v'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Texts for currency-codes'
define view zcurrency_texts as select from tcurt {
    
    @Semantics.language: true
    key spras as language,
    @Semantics.currencyCode: true
    key waers as currency_code,
    @Semantics.text: true
    ltext as long_text,
    ktext as short_text
} 
 