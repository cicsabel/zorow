//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//*******************************************************
//* GRANT access to the database
//*******************************************************
//CCSQL  EXEC PGM=IKJEFT01,REGION=0M               
//         EXPORT SYMLIST=*
//         SET WEBUSER='${instance-CC_SERVER_STC_USER}'
//STEPLIB  DD DISP=SHR,DSN=${instance-DB_HLQ}.SDSNLOAD               
//SYSTSPRT DD SYSOUT=*,DCB=BLKSIZE=131                         
//SYSPRINT DD SYSOUT=*                                         
//SYSUDUMP DD SYSOUT=*                                         
//SYSTSIN  DD *                                                
 DSN SYSTEM(${instance-DB_JCC_SSID})                                              
 RUN PROGRAM(${instance-DB_PROGRAM}) PLAN(${instance-DB_PLAN}) LIB('${instance-DB_RUNLIB}') 
 END                                                           
//SYSIN     DD    *,SYMBOLS=(JCLONLY)
#if(${instance-CC_ADMIN_DB} && ${instance-CC_ADMIN_DB} != "")
SET CURRENT SQLID = '${instance-CC_ADMIN_DB}';   
#else
  #if(${instance-DB_CURRENT_SQLID} && ${instance-DB_CURRENT_SQLID} != "")
SET CURRENT SQLID = '${instance-DB_CURRENT_SQLID}';   
  #else
SET CURRENT SQLID = '${_step-stepOwnerUpper}';   
  #end
#end
SET CURRENT SCHEMA = '${instance-DB_CURRENT_SCHEMA}' ;


GRANT SELECT ON MSDKE_KEYS TO &WEBUSER;


/*
