REUSE ALV GRID DISPLAY PROGRAM

REPORT z343_reuse_alv_grid_display.

TYPE-POOLS: slis.

TABLES: bkpf.

SELECT-OPTIONS:
  s_bukrs FOR bkpf-bukrs,
  s_budat FOR bkpf-budat,
  s_blart FOR bkpf-blart.

TYPES: BEGIN OF ty_bkpf,
         bukrs      TYPE bkpf-bukrs,
         belnr      TYPE bkpf-belnr,
         gjahr      TYPE bkpf-gjahr,
         blart      TYPE bkpf-blart,
         budat      TYPE bkpf-budat,
         bldat      TYPE bkpf-bldat,
         waers      TYPE bkpf-waers,
         buzei      TYPE bseg-buzei,
         hkont      TYPE bseg-hkont,
         shkzg      TYPE bseg-shkzg,
         dmbtr      TYPE bseg-dmbtr,
       END OF ty_bkpf.

TYPES: BEGIN OF ty_summary,
         bukrs      TYPE bkpf-bukrs,
         belnr      TYPE bkpf-belnr,
         gjahr      TYPE bkpf-gjahr,
         blart      TYPE bkpf-blart,
         waers      TYPE bkpf-waers,
         debit_amt  TYPE bseg-dmbtr,
         credit_amt TYPE bseg-dmbtr,
         difference TYPE bseg-dmbtr,
       END OF ty_summary.

DATA:
  lt_bkpf    TYPE STANDARD TABLE OF ty_bkpf,
  ls_bkpf    TYPE ty_bkpf,
  lt_summary TYPE STANDARD TABLE OF ty_summary,
  ls_summary TYPE ty_summary,
  lt_fcat    TYPE slis_t_fieldcat_alv,
  ls_fcat    TYPE slis_fieldcat_alv.

FIELD-SYMBOLS:
  <fs_summary> TYPE ty_summary.

START-OF-SELECTION.

* Fetch accounting document line items
  SELECT h~bukrs,
         h~belnr,
         h~gjahr,
         h~blart,
         h~budat,
         h~bldat,
         h~waers,
         i~buzei,
         i~hkont,
         i~shkzg,
         i~dmbtr
    FROM bkpf AS h
    INNER JOIN bseg AS i
      ON i~bukrs = h~bukrs
     AND i~belnr = h~belnr
     AND i~gjahr = h~gjahr
    WHERE h~bukrs IN @s_bukrs
      AND h~budat IN @s_budat
      AND h~blart IN @s_blart
    INTO CORRESPONDING FIELDS OF TABLE @lt_bkpf.

  IF lt_bkpf IS INITIAL.
    MESSAGE 'No accounting documents found'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

* Create one summary row per accounting document
  CLEAR lt_summary.

  LOOP AT lt_bkpf INTO ls_bkpf.

    UNASSIGN <fs_summary>.

    READ TABLE lt_summary ASSIGNING <fs_summary>
      WITH KEY bukrs = ls_bkpf-bukrs
               belnr = ls_bkpf-belnr
               gjahr = ls_bkpf-gjahr.

    IF sy-subrc <> 0.

      CLEAR ls_summary.

      ls_summary-bukrs = ls_bkpf-bukrs.
      ls_summary-belnr = ls_bkpf-belnr.
      ls_summary-gjahr = ls_bkpf-gjahr.
      ls_summary-blart = ls_bkpf-blart.
      ls_summary-waers = ls_bkpf-waers.

      APPEND ls_summary TO lt_summary.

      READ TABLE lt_summary ASSIGNING <fs_summary>
        WITH KEY bukrs = ls_bkpf-bukrs
                 belnr = ls_bkpf-belnr
                 gjahr = ls_bkpf-gjahr.
    ENDIF.

    IF <fs_summary> IS ASSIGNED.

      CASE ls_bkpf-shkzg.

        WHEN 'S'.
          <fs_summary>-debit_amt =
            <fs_summary>-debit_amt + ls_bkpf-dmbtr.

        WHEN 'H'.
          <fs_summary>-credit_amt =
            <fs_summary>-credit_amt + ls_bkpf-dmbtr.

      ENDCASE.

      <fs_summary>-difference =
        <fs_summary>-debit_amt -
        <fs_summary>-credit_amt.

    ENDIF.

  ENDLOOP.

* Build ALV field catalog
  CLEAR lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'BUKRS'.
  ls_fcat-seltext_m = 'Company Code'.
  APPEND ls_fcat TO lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'BELNR'.
  ls_fcat-seltext_m = 'Document Number'.
  APPEND ls_fcat TO lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GJAHR'.
  ls_fcat-seltext_m = 'Fiscal Year'.
  APPEND ls_fcat TO lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'BLART'.
  ls_fcat-seltext_m = 'Document Type'.
  APPEND ls_fcat TO lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'WAERS'.
  ls_fcat-seltext_m = 'Currency'.
  APPEND ls_fcat TO lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'DEBIT_AMT'.
  ls_fcat-seltext_m = 'Total Debit'.
  ls_fcat-do_sum = 'X'.
  APPEND ls_fcat TO lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'CREDIT_AMT'.
  ls_fcat-seltext_m = 'Total Credit'.
  ls_fcat-do_sum = 'X'.
  APPEND ls_fcat TO lt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'DIFFERENCE'.
  ls_fcat-seltext_m = 'Debit-Credit Difference'.
  APPEND ls_fcat TO lt_fcat.

* Display summarized ALV
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_summary
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying ALV report'
      TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
