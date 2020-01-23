*&---------------------------------------------------------------------*
*& Report zbooking_doc_debit_credit
*&---------------------------------------------------------------------*
*& create booking documents and split credit and debit
*& afterwards.
*&---------------------------------------------------------------------*
REPORT zbooking_doc_debit_credit.

TYPES: _documents TYPE STANDARD TABLE OF zbooking_doc_debit_credit.

INITIALIZATION.
  PERFORM create_documents.
  COMMIT WORK AND WAIT.

START-OF-SELECTION.
  DATA: documents TYPE _documents.

  PERFORM read_documents_classical CHANGING documents.

  WRITE: 'Belegnr.', 'Soll', 'Haben'. NEW-LINE.
  LOOP AT documents REFERENCE INTO DATA(doc).
    WRITE: doc->*-belnr, doc->*-debit, doc->*-credit. NEW-LINE.
  ENDLOOP.

FORM create_documents.
  DATA: header TYPE STANDARD TABLE OF ybkpf,
        items  TYPE STANDARD TABLE OF ybseg.

  header = VALUE #(
    ( gjahr = '2019' belnr = '51' bukrs = 'A1' budat = '20190904' )
    ( gjahr = '2019' belnr = '52' bukrs = 'A1' budat = '20191004' )
    ( gjahr = '2019' belnr = '53' bukrs = 'A1' budat = '19700101' )
  ).
  items = VALUE #(
    ( gjahr = '2019' belnr = '51' bukrs = 'A1' buzei = 1 dmbtr = 10000 shkzg = 'S' )
    ( gjahr = '2019' belnr = '51' bukrs = 'A1' buzei = 2 dmbtr = 5000 shkzg = 'H' )
    ( gjahr = '2019' belnr = '52' bukrs = 'A1' buzei = 1 dmbtr = 20000 shkzg = 'S' )
    ( gjahr = '2019' belnr = '52' bukrs = 'A1' buzei = 2 dmbtr = 20000 shkzg = 'H' )
    ( gjahr = '2019' belnr = '53' bukrs = 'A1' buzei = 2 dmbtr = 20000 shkzg = 'H' )
  ).

  DELETE FROM: ybkpf, ybseg.
  INSERT ybkpf FROM TABLE header.
  INSERT ybseg FROM TABLE items.

ENDFORM.

FORM read_documents_cds CHANGING documents TYPE _documents.

  SELECT * FROM zbooking_doc_debit_credit INTO TABLE @documents
    WHERE budat BETWEEN '20190901' AND '20190930'.

ENDFORM.

FORM read_documents_classical CHANGING documents TYPE _documents.
  DATA: document_headers TYPE STANDARD TABLE OF ybkpf,
        document_item    TYPE ybseg,
        document         TYPE zbooking_doc_debit_credit.

  CLEAR documents.

  SELECT * FROM ybkpf INTO TABLE document_headers
    WHERE budat BETWEEN '20190901' AND '20190930'.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  SELECT * FROM ybseg INTO document_item
      FOR ALL ENTRIES IN document_headers
      WHERE gjahr = document_headers-gjahr AND belnr = document_headers-belnr
      AND bukrs = document_headers-bukrs.

    READ TABLE document_headers REFERENCE INTO DATA(header)
        WITH KEY gjahr = document_item-gjahr belnr = document_item-belnr
        bukrs = document_item-bukrs.
    " should be always sucessfull
    ASSERT sy-subrc = 0.

    CLEAR document.
    document-gjahr = document_item-gjahr.
    document-belnr = document_item-belnr.
    document-bukrs = document_item-bukrs.
    document-buzei = document_item-buzei.
    document-budat = header->*-budat.
    IF document_item-shkzg = 'S'.
      document-debit = document_item-dmbtr.
    ELSE.
      document-credit = document_item-dmbtr.
    ENDIF.
    INSERT document INTO TABLE documents.

  ENDSELECT.
ENDFORM.
