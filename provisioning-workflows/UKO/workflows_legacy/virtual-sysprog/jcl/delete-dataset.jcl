//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//DELETE    EXEC PGM=IDCAMS,REGION=1M
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE ${instance-MTLS_HLQ}.${instance-MTLS_USER}.MTLS
 IF MAXCC EQ 8 THEN DO
   SET MAXCC = 0
   END
/*