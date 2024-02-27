//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//*******************************************************
//* delete SQL
//*******************************************************
//DELSQL  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE  '${instance-DB_TEMP_HLQ}.${instance-DB_CURRENT_SCHEMA}.SQL'
  SET MAXCC = 00
//*
//*******************************************************
//* delete database
//*******************************************************
//UKOSQL  EXEC PGM=IKJEFT01,REGION=0M               
//STEPLIB  DD DISP=SHR,DSN=${instance-DB_HLQ}.SDSNLOAD               
//SYSTSPRT DD SYSOUT=*,DCB=BLKSIZE=131                         
//SYSPRINT DD SYSOUT=*                                         
//SYSUDUMP DD SYSOUT=*                                         
//SYSTSIN  DD *                                                
 DSN SYSTEM(${instance-DB_JCC_SSID})                                              
 RUN PROGRAM(${instance-DB_PROGRAM}) PLAN(${instance-DB_PLAN}) LIB('${instance-DB_RUNLIB}') 
 END                                                           
//SYSIN     DD    *                                            
#if(${instance-UKO_ADMIN_DB} && ${instance-UKO_ADMIN_DB} != "")
SET CURRENT SQLID = '${instance-UKO_ADMIN_DB}';   
#else
SET CURRENT SQLID = '${_step-stepOwner}';   
#end

SET CURRENT SCHEMA = '${instance-DB_CURRENT_SCHEMA}' ;

DROP DATABASE ${instance-DB_NAME_UKO} ;

DROP DATABASE ${instance-DB_NAME_DATASET_ENCRYPTION_STATUS} ;

COMMIT;                                                

/*