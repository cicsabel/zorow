//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//REXXUSS  EXEC PGM=IKJEFT01  
// EXPORT SYMLIST=*
// SET ZFSFILE='${instance-UKO_SERVER_STC_NAME}-deleteRoleAccess.rexx'
//SYSTSPRT DD SYSOUT=*        
//STDERR   DD SYSOUT=*        
//SYSIN    DD DUMMY           
//STDOUT   DD SYSOUT=*        
//SYSTSIN  DD *,SYMBOLS=(JCLONLY)               
BPXBATSL sh ${instance-SECURITY_ADMIN_HOME}/&ZFSFILE 
/*