
//DELETE    EXEC PGM=IDCAMS,REGION=1M
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE ${instance-DB_TEMP_HLQ}.${instance-DB_CURRENT_SCHEMA}.LIST01
 IF MAXCC EQ 8 THEN DO
   SET MAXCC = 0
   END
/*
//PEXTRACT EXEC PGM=IKJEFT01 
//SYSTSPRT DD SYSOUT=* 
//SYSOUT  DD SYSOUT=* 
//SYSPROC DD DISP=SHR,DSN=${instance-UKO_AGENT_EXECLIB} 
//STEPLIB DD DISP=SHR,DSN=${instance-UKO_AGENT_RUNLIB}
//        DD DISP=SHR,DSN=${instance-REXX_HLQ}.SEAGALT
//EXTRACT DD DISP=(,CATLG),
// DSN=${instance-DB_TEMP_HLQ}.${instance-DB_CURRENT_SCHEMA}.LIST01, 
// UNIT=SYSALLDA, 
// DCB=(RECFM=VB,LRECL=9999,BLKSIZE=23200), 
// SPACE=(CYL,(5,5),RLSE) 
//FILTER DD * 
ALL ** 
//SYSTSIN DD * 
%KMGPEUTL + 
IGGTRACE(OFF) + 
VTOCTEST(ON)