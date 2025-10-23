//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//DELETE    EXEC PGM=IDCAMS,REGION=1M
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE ${instance-EXPORT_HLQ}.${instance-GENERIC_CLIENT_USER}
 IF MAXCC EQ 8 THEN DO
   SET MAXCC = 0
   END
 DELETE ${instance-EXPORT_HLQ}.${instance-GENERIC_CLIENT_USER}.SERVERCA
 IF MAXCC EQ 8 THEN DO
   SET MAXCC = 0
   END
/*