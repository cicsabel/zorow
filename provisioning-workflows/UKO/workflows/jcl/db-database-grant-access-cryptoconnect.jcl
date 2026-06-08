//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//*******************************************************
//* GRANT Crypto Connect access to UKO database views
//* This allows Crypto Connect to access UKO-managed keys
//*******************************************************
//CCSQL  EXEC PGM=IKJEFT01,REGION=0M               
//         EXPORT SYMLIST=*
//         SET CCUSER='${instance-SERVER_STC_USER}'
//STEPLIB  DD DISP=SHR,DSN=${instance-DB_HLQ}.SDSNLOAD               
//SYSTSPRT DD SYSOUT=*,DCB=BLKSIZE=131                         
//SYSPRINT DD SYSOUT=*                                         
//SYSUDUMP DD SYSOUT=*                                         
//SYSTSIN  DD *                                                
 DSN SYSTEM(${instance-DB_JCC_SSID})                                              
 RUN PROGRAM(${instance-DB_PROGRAM}) PLAN(${instance-DB_PLAN}) LIB('${instance-DB_RUNLIB}') 
 END                                                           
//SYSIN     DD    *,SYMBOLS=(JCLONLY)
#if(${instance-UKO_ADMIN_DB} && ${instance-UKO_ADMIN_DB} != "")
SET CURRENT SQLID = '${instance-UKO_ADMIN_DB}';   
#else
  #if(${instance-DB_CURRENT_SQLID} && ${instance-DB_CURRENT_SQLID} != "")
SET CURRENT SQLID = '${instance-DB_CURRENT_SQLID}';   
  #else
SET CURRENT SQLID = '${_step-stepOwnerUpper}';   
  #end
#end
SET CURRENT SCHEMA = '${instance-DB_CURRENT_SCHEMA}' ;

-- Crypto Connect UKO Integration Grants
-- These grants allow Crypto Connect to access UKO-managed keys and templates

GRANT SELECT ON EKMF_WEB_CERTIFICATES TO &CCUSER;
GRANT SELECT ON EKMF_WEB_KEY_MATERIALS TO &CCUSER;
GRANT SELECT ON EKMF_WEB_KEY_TEMPLATES TO &CCUSER;
GRANT SELECT ON EKMF_WEB_KEYS TO &CCUSER;
GRANT SELECT ON EKMF_WEB_KEY_ALL_TAGS TO &CCUSER;

/*