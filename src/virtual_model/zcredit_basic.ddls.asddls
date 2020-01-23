@Analytics.dataExtraction.enabled: true
@Analytics.dataCategory: #DIMENSION
@ObjectModel.representativeKey: 'credit_no'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'zcredit_basic_v'
@EndUserText.label: 'Basic view for credit'
define view zcredit_basic as select from zcredit 
 left outer join zborrower on zborrower.borrower_no = zcredit.borrower
 association[0..1] to zcountry_texts as _country_texts on _country_texts.country = zborrower.country{  
  
  key credit_no as credit_no,  
  borrower,
  name,
  street,
  city_code,
  city,
  @ObjectModel.text.association: '_country_texts'
  country,
  _country_texts 
        
} 
 