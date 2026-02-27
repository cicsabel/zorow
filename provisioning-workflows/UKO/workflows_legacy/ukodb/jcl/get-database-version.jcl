//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//UKODB   EXEC PGM=IKJEFT01,REGION=0M               
// EXPORT SYMLIST=*
// SET ZFSFILE='zosmf-${_workflow-workflowKey}.version'
//STEPLIB  DD DISP=SHR,DSN=${instance-DB_HLQ}.SDSNLOAD               
//SYSTSPRT DD SYSOUT=*,DCB=BLKSIZE=131                         
//SYSPRINT DD PATHOPTS=(ORDWR,OCREAT),
//   PATHMODE=(SIRWXU,SIRWXG,SIRWXO),
//   PATH='${instance-TEMP_DIR}/&ZFSFILE'
//SYSUDUMP DD SYSOUT=*                                         
//SYSTSIN  DD *                                                
 DSN SYSTEM(${instance-DB_JCC_SSID})                                              
 RUN PROGRAM(${instance-DB_PROGRAM}) PLAN(${instance-DB_PLAN}) LIB('${instance-DB_RUNLIB}') 
 END                                                           
//SYSIN     DD    *,SYMBOLS=(JCLONLY)
#if(${instance-DB_CURRENT_SQLID} && ${instance-DB_CURRENT_SQLID} != "")
SET CURRENT SQLID = '${instance-DB_CURRENT_SQLID}';   
#else
SET CURRENT SQLID = '${_step-stepOwnerUpper}';   
#end
SET CURRENT SCHEMA = '${instance-DB_CURRENT_SCHEMA}' ;
SELECT VERSION
FROM EKMF_META
WHERE VERSION=(SELECT max(VERSION) FROM EKMF_META);

/*