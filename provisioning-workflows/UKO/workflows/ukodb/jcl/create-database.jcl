//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//* Create the databases and transfer ownership
//UKODB   EXEC PGM=IKJEFT01,REGION=0M               
//         EXPORT SYMLIST=*
//         SET DBSQLID=${instance-DB_CURRENT_SQLID}
//STEPLIB  DD DISP=SHR,DSN=${instance-DB2_HLQ}.SDSNLOAD               
//SYSTSPRT DD SYSOUT=*,DCB=BLKSIZE=131                         
//SYSPRINT DD SYSOUT=*                                         
//SYSUDUMP DD SYSOUT=*                                         
//SYSTSIN  DD *                                                
 DSN SYSTEM(${instance-DB2_JCC_SSID})                                              
 RUN PROGRAM(${instance-DB_PROGRAM}) PLAN(${instance-DB_PLAN}) LIB('${instance-DB2_RUNLIB}') 
 END                                                           
//SYSIN     DD    *,SYMBOLS=(JCLONLY)
SET CURRENT SQLID = '${instance-UKO_ADMIN_DB}';   

CREATE DATABASE ${instance-DB_NAME_UKO} 
 BUFFERPOOL ${instance-DB_BUFFERPOOL_DEFAULT} 
 INDEXBP    ${instance-DB_BUFFERPOOL_INDEX} 
STOGROUP ${instance-DB_STOGROUP};               
TRANSFER OWNERSHIP OF DATABASE ${instance-DB_NAME_UKO} 
 TO USER &DBSQLID REVOKE PRIVILEGES;                                    

COMMIT;                                                

CREATE DATABASE ${instance-DB_NAME_DATASET_ENCRYPTION_STATUS} 
 BUFFERPOOL ${instance-DB_BUFFERPOOL_DEFAULT} 
 INDEXBP    ${instance-DB_BUFFERPOOL_INDEX} 
STOGROUP ${instance-DB_STOGROUP};                       
TRANSFER OWNERSHIP OF DATABASE ${instance-DB_NAME_DATASET_ENCRYPTION_STATUS}  
 TO USER &DBSQLID REVOKE PRIVILEGES;                                    

COMMIT;                                                

SET CURRENT SQLID = '&DBSQLID';  


/*