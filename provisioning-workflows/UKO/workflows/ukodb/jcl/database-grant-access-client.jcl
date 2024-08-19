//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//*******************************************************
//* GRANT access to the database
//*******************************************************
//EKMFSQL  EXEC PGM=IKJEFT01,REGION=0M               
//         EXPORT SYMLIST=*
//         SET CLUSER='${instance-UKO_AGENT_CLIENT_GROUP}'
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

GRANT SELECT ON V1KMGELT TO &CLUSER;
GRANT SELECT ON V2KMGELT TO &CLUSER;
GRANT SELECT ON VKMGGRPG TO &CLUSER;
GRANT SELECT ON VKMGGRPM TO &CLUSER;
GRANT SELECT ON VTSSPARAM TO &CLUSER;
GRANT SELECT ON XCERTS TO &CLUSER;
GRANT SELECT ON XCONFIG TO &CLUSER;
GRANT SELECT ON XLOCKS TO &CLUSER;
GRANT SELECT ON XPOLICIES TO &CLUSER;
GRANT SELECT ON XPOSTBOX TO &CLUSER;
GRANT SELECT ON XREPORTER TO &CLUSER;
GRANT SELECT ON XTEMPLATESPURE TO &CLUSER;
GRANT SELECT ON XUKDS7 TO &CLUSER;


/*
