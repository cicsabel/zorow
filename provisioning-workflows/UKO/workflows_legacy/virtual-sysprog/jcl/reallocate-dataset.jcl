//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//* remove the previous file in case it exists
//DELETEDS    EXEC PGM=IDCAMS,REGION=1M
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE ${instance-MTLS_HLQ}.${instance-MTLS_USER}.MTLS
 IF MAXCC EQ 8 THEN DO
   SET MAXCC = 0
   END
/*
//* allocate the dataset
//ALLOCDS EXEC PGM=IEFBR14
//MTLSDS  DD DSN=${instance-MTLS_HLQ}.${instance-MTLS_USER}.MTLS,
//            DISP=(NEW,CATLG),
//            UNIT=SYSALLDA,
//            DCB=(RECFM=VB,DSORG=PS,LRECL=84),
//            SPACE=(TRK,(1,5),RLSE)
/*