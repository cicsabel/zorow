//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//STEP1       EXEC  PGM=IKJEFT1A,DYNAMNBR=20
//SYSTSPRT    DD    SYSOUT=A
//SYSTSIN     DD    *
 ALLOCATE FILE(DD1) DATASET('${instance-ZOS_PROCLIB}') SHR
 DELETE '${instance-ZOS_PROCLIB}(${instance-CC_SERVER_STC_NAME})' FILE(DD1)
 FREE FILE(DD1)
#if(${instance-CC_STC_JOB_CARD} && $!{instance-CC_STC_JOB_CARD} != "")
#if(${instance-CC_ZOS_STCJOBS} && $!{instance-CC_ZOS_STCJOBS} != "")
 ALLOCATE FILE(DD2) DATASET('${instance-CC_ZOS_STCJOBS}') SHR
 DELETE '${instance-CC_ZOS_STCJOBS}(${instance-CC_SERVER_STC_NAME})' FILE(DD2)
 FREE FILE(DD2)
#end
#end
/*