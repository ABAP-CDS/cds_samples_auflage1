@AbapCatalog.sqlViewName: 'zstring_func'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'build in functions for strings'
define view zstring_functions as select from scustom {
    key id,
    //2 Zeichenketten zusammenfuegen
    concat( form, name ) as salutation_without_space,
    //2 Zeichenketten zusammenfuegen getrennt durch
    //Leerzeichen
    concat_with_space( form, name, 1 ) as salutation_with_space,
    //Position erstes Vorkommen der Teilzeichenkette
    instr( telephone, '/' ) as position_separator,
    //Die ersten 3 Zeichen der Telefonnummer von links gesehen
    left( telephone, 3 ) as first_3_chars,
    //Laenge der Telefonnummer
    length( telephone ) as length_telephone_no,
    //Umwandlung von Gross in Kleinbuchstaben
    lower( name ) as name_lower,
    //Postfach rechtsbuendig anordnen und mit fuehrenden Nullen
    //auffuellen
    lpad( postbox, 10, '0' ) as postbox_leading_zeros,
    //Fuehrende Nullen entfernen
    ltrim( postbox, '0' ) as postbox_wo_leading_zeros,
    //Ersetzen Strasse durch Str. Gross0 und Kleinschreibung
    //wird beachtet
    replace( street, 'Strasse', 'Str.' ) as street,
    //Die letzten 5 Ziffern der Telefonnummer
    right( telephone, 5 ) as last_5_chars,
    //Postfach mit Nullen rechts auffuellen
    rpad( postbox, 10, '0' ) as postbox_trailing_zeros,
    //Nullen am Ende des Postfaches entfernen
    rtrim( postbox, '0' ) as trimed_post_box,
    //Zeichenkette von Position 2 bis 4
    substring( telephone, 2, 2 ) as telephone_no_from_2_to_3,
    //Umwandlung in Grossbuchstaben
    upper( name ) as name_upper
} 
 