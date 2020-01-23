@AbapCatalog.sqlViewName: 'znum_func'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Numerical CDS functions'
define view znumeric_functions as select from demo_expressions {
    key id,
    //Absolutbetrag
    abs( num1 ) as absolut_value,
    //kleinster ganzzahliger Wert <= dec1
    ceil( dec3 ) as next_ge_integer,
    //Ganzzahliger Anteil nach der Division
    div( num1, num2 ) as division_rounded_down,
    //Division gerundet auf 2 Nachkommastellen
    division( num1, num2, 2 ) as division_round_2_decimals,
    //Groesster ganzzahliger Wert >= dec1
    floor( dec3 ) as last_le_integer,
    //Rest der Division
    mod( num1, num2 )as modulo,
    //Rundung auf 0 Dezimalen
    round( dec3, 0 ) as rounded_0_decimals
} 
 