*&---------------------------------------------------------------------*
*& Report ZGET_MDG_STAGING_API_NON_SOV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZWANG3.
DATA:   lo_model     TYPE REF TO if_usmd_model_ext,
        ls_sel       TYPE usmd_s_sel,
        lt_sel       TYPE usmd_ts_sel,
        lt_objlist   TYPE usmd_t_crequest_entity,
        ls_objlist   TYPE usmd_s_crequest_entity,
        lv_structure TYPE REF TO data,
        " lt_data TYPE USMD_TS_DATA_ENTITY,
        lt_message TYPE USMD_T_MESSAGE.


FIELD-SYMBOLS : <lt_data> TYPE ANY TABLE,
                <lt_data_all> TYPE ANY TABLE.

CALL METHOD cl_usmd_model_ext=>get_instance
  EXPORTING
    i_usmd_model = '0G'
  IMPORTING
    eo_instance  = lo_model.

CLEAR: ls_sel, lt_sel.
ls_sel-fieldname = 'COAREA'.
ls_sel-option = 'EQ'.
ls_sel-sign = 'I'.
ls_sel-low = '0001'.
INSERT ls_sel INTO TABLE lt_sel.

ls_sel-fieldname = 'PCTR'.
ls_sel-option = 'EQ'.
ls_sel-sign = 'I'.
ls_sel-low = 'MDG-S10'.
INSERT ls_sel INTO TABLE lt_sel.

*ls_sel-fieldname = 'USMD_EDTN_NUMBER'.
*ls_sel-option = 'EQ'.
*ls_sel-sign = 'I'.
*ls_sel-low = '999999'.
*INSERT ls_sel INTO TABLE lt_sel.

CALL METHOD lo_model->create_data_reference
  EXPORTING
   i_fieldname = 'PCTR'
   "i_struct    =  lo_model->GC_STRUCT_KEY_ATTR
   i_struct    =  lo_model->GC_STRUCT_KEY_TXT_LANGU
  IMPORTING
   er_data     = lv_structure.

ASSIGN lv_structure->* TO <lt_data>.

CALL METHOD lo_model->read_char_value
  EXPORTING
   i_fieldname = 'PCTR'
   it_sel      = lt_sel
   " IF_EDITION_LOGIC = abap_true
   i_readmode  = '1'
  IMPORTING
   et_data     = <lt_data>.

Loop at <lt_data> ASSIGNING FIELD-SYMBOL(<ls_data>).
  ASSIGN COMPONENT 'LANGU' OF STRUCTURE <ls_data> to FIELD-SYMBOL(<lv_langu>).
  IF <lv_langu> is ASSIGNED and <lv_langu> = sy-langu.
   ASSIGN COMPONENT 'TXTMI' OF STRUCTURE <ls_data> to FIELD-SYMBOL(<lv_txtmi>).
   WRITE : <lv_langu> , ':' , <lv_txtmi>.
  ENDIF.
ENDLOOP.
