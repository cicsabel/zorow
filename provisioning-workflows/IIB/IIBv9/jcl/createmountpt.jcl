//******************************************************************
//* Copyright Contributors to the zOS-Workflow Project.            *
//* PDX-License-Identifier: Apache-2.0                             *
//******************************************************************
//S1     EXEC USSBATCH,SU=Y
//STDOUT  DD SYSOUT=*
//STDERR  DD SYSOUT=*
//SYSIN   DD *
 mkdir /plex/var/mqsi/brokers/${instance-IIB_BROKER_NAME_LC}
/*
//MOUNT    EXEC PGM=IKJEFT1B
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
MOUNT FILESYSTEM('SYSTEM.HFS.PLEX.VAR.MQSI.${instance-IIB_BROKER_NAME}') +
TYPE(ZFS) MOUNTPOINT('/plex/var/mqsi/brokers/${instance-IIB_BROKER_NAME_LC}') +
MODE(RDWR)
/*
//
