*&---------------------------------------------------------------------*
*& Report ZSFLIGHT_COPY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZWANG17.
DATA itab type TABLE OF Sflight.

select * from SFLIGHT into table itab .

insert ZZSFLIGHT from table itab accepting duplicate keys.
