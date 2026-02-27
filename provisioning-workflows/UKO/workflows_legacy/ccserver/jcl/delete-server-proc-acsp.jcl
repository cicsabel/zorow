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
 ALLOCATE FILE(DD1) DATASET('${instance-ZOS_PARMLIB}') SHR
 DELETE '${instance-ZOS_PARMLIB}(${instance-SERVER_STC_NAME})' FILE(DD1)
 FREE FILE(DD1)
/*