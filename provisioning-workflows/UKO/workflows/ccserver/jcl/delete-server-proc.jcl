//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//STEP1       EXEC  PGM=IKJEFT1A,DYNAMNBR=20
//SYSTSPRT    DD    SYSOUT=A
//SYSTSIN     DD    *
 ALLOCATE FILE(DD1) DATASET('${instance-ZOS_PROCLIB}') SHR
 DELETE '${instance-ZOS_PROCLIB}(${instance-SERVER_STC_NAME})' FILE(DD1)
 FREE FILE(DD1)
#if(${instance-ZOS_STC_JOB_CARD} && $!{instance-ZOS_STC_JOB_CARD} != "")
#if(${instance-ZOS_STCJOBS} && $!{instance-ZOS_STCJOBS} != "")
 ALLOCATE FILE(DD2) DATASET('${instance-ZOS_STCJOBS}') SHR
 DELETE '${instance-ZOS_STCJOBS}(${instance-SERVER_STC_NAME})' FILE(DD2)
 FREE FILE(DD2)
#end
#end
/*