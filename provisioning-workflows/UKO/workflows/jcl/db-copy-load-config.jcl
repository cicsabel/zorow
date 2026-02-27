//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//DELETE    EXEC PGM=IDCAMS,REGION=1M
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE ${instance-DB_TEMP_HLQ}.${instance-DB_CURRENT_SCHEMA}.LOADCONF
 IF MAXCC EQ 8 THEN DO
   SET MAXCC = 0
   END
/*
//ALLOCDDL EXEC PGM=IEFBR14
//DDLWORK  DD DSN=${instance-DB_TEMP_HLQ}.${instance-DB_CURRENT_SCHEMA}.LOADCONF,
//            DISP=(NEW,CATLG),
//            UNIT=SYSALLDA,
//            DCB=(RECFM=FB,DSORG=PS,LRECL=80),
//            SPACE=(TRK,(1,1),RLSE)
/*
//COPYPARM EXEC PGM=IKJEFT01
// EXPORT SYMLIST=*
// SET ZFSFILE='zosmf-${_workflow-workflowKey}-load'
//IN DD PATH='${instance-TEMP_DIR}/&ZFSFILE'
//OUT DD DISP=SHR,DSN=${instance-DB_TEMP_HLQ}.${instance-DB_CURRENT_SCHEMA}.LOADCONF
//SYSTSPRT DD SYSOUT=*
//SYSTSIN DD *
OCOPY INDD(IN) OUTDD(OUT) TEXT
/*