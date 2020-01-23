CLASS zamdp_table_function DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_passengers FOR TABLE FUNCTION zflight_passenger_names.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zamdp_table_function IMPLEMENTATION.

    METHOD get_passengers BY DATABASE FUNCTION FOR HDB
        LANGUAGE SQLSCRIPT
        OPTIONS READ-ONLY
        USING sbook.

        RETURN SELECT concat (passform, ' ', passname ) as passenger from sbook
            where mandt = :clnt AND carrid = :carrier AND connid = :connection_id
            AND fldate = :flight_date AND cancelled = :abap_false;

    ENDMETHOD.

ENDCLASS.
