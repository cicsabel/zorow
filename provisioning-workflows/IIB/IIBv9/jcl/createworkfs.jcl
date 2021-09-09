//******************************************************************
//* Copyright Contributors to the zOS-Workflow Project.            *
//* PDX-License-Identifier: Apache-2.0                             *
//******************************************************************
//DEFINE EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
 DELETE SYSTEM.HFS.PLEX.VAR.MQSI.${instance-IIB_BROKER_NAME}
 SET MAXCC=0
 DEFINE CLUSTER (NAME(SYSTEM.HFS.PLEX.VAR.MQSI.${instance-IIB_BROKER_NAME}) -
 LINEAR CYL(7500 1500) DATACLASS (DCEXTADR) SHAREOPTIONS(3))
/*
//* -------------------------------------------------------
//S1     EXEC OMVSBAT,SU=Y
//STDOUT  DD SYSOUT=*
//STDERR  DD SYSOUT=*
//SYSIN   DD *
 zfsadm format -aggregate SYSTEM.HFS.PLEX.VAR.MQSI.${instance-IIB_BROKER_NAME} \
 -owner ${instance-IIB_STCUSER} \
 -group ${instance-IIB_STCGROUP} \
 -perms o755
/*
