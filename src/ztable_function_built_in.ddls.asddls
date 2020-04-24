@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Table function with built-in types'
define table function ztable_function_built_in returns {
    client: abap.clnt;
    char_4: abap.char(4);
    currency_key: abap.cuky;
    currency_value: abap.curr(10);
    date: abap.dats;
    dec_n: abap.dec(31, 4);
    float: abap.fltp;
    int1: abap.int1;
    int2: abap.int2;
    int4: abap.int4;
    int8: abap.int8;
    language: abap.lang;
    long_char: abap.lchr(256);
    long_raw: abap.lraw(256);
    numc: abap.numc(10);
    quantity: abap.quan(10, 4);
    raw: abap.raw(2);
    rawstring: abap.rawstring;
    short_string: abap.sstring(1333);
    string: abap.string;
    time: abap.tims;
    unit: abap.unit;
} implemented by method zcl_first_table_function=>build_in