@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'flight passenger names'
@ClientHandling.type: #CLIENT_DEPENDENT
define table function zflight_passenger_names with parameters
  @Environment.systemField: #CLIENT 
  clnt  :abap.clnt,
  carrier :s_carr_id,
  connection_id :s_conn_id,
  flight_date :s_date
returns {
    client :s_mandt;
    passenger :zpass_form_and_name;
} implemented by method zamdp_table_function=>get_passengers