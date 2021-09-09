//******************************************************************
//* Copyright Contributors to the zOS-Workflow Project.            *
//* PDX-License-Identifier: Apache-2.0                             *
//******************************************************************
//MOUNT    EXEC PGM=IKJEFT01
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
UNMOUNT FILESYSTEM('SYSTEM.HFS.PLEX.VAR.MQSI.${instance-IIB_BROKER_NAME}') +
IMMEDIATE
/*
//S1     EXEC USSBATCH,SU=Y
//SYSIN   DD *
 rmdir /plex/var/mqsi/brokers/${instance-IIB_BROKER_NAME_LC}
/*
//IDCAMS  EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 DELETE SYSTEM.HFS.PLEX.VAR.MQSI.${instance-IIB_BROKER_NAME}
/*
