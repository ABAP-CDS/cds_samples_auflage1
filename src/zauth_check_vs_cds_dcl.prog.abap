*&---------------------------------------------------------------------*
*& Report zauth_check_vs_cds_dcl
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zauth_check_vs_cds_dcl.

TYPES: _flight_plan TYPE STANDARD TABLE OF zflight_plan_association.
START-OF-SELECTION.
  DATA: from_filter_with_auth_check TYPE _flight_plan,
        from_cds_view_with_ac TYPE _flight_plan.

  PERFORM: authority_check CHANGING from_filter_with_auth_check,
    cds_dcl CHANGING from_cds_view_with_ac.
  ASSERT from_filter_with_auth_check = from_cds_view_with_ac.

FORM authority_check CHANGING flight_plan TYPE _flight_plan.

  CLEAR flight_plan.
  AUTHORITY-CHECK OBJECT 'ZAIRLINE'
    ID 'ACTVT' FIELD '02'.
  IF sy-subrc = 12.
    RETURN.
  ENDIF.

  SELECT p~carrid, p~connid, p~countryfr, p~cityfrom,
   p~countryto, p~cityto, a~carrname
   FROM spfli AS p LEFT OUTER JOIN scarr AS a ON a~carrid = p~carrid
   INTO CORRESPONDING FIELDS OF TABLE @flight_plan.

  LOOP AT flight_plan REFERENCE INTO DATA(a_flight_plan).
    AUTHORITY-CHECK OBJECT 'ZAIRLINE'
        ID 'ACTVT' FIELD '02'
        ID 'CARRID' FIELD a_flight_plan->*-carrid.
    IF sy-subrc <> 0.
      DELETE flight_plan INDEX sy-tabix.
    ENDIF.
  ENDLOOP.

ENDFORM.

FORM cds_dcl CHANGING flight_plan TYPE _flight_plan.

  SELECT * FROM zflight_plan_association INTO TABLE @flight_plan.

ENDFORM.
