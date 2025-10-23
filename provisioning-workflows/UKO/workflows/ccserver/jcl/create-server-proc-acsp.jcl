//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//COPY1 EXEC PGM=IEBGENER,MEMLIMIT=0M
//SYSUT2 DD DISP=SHR,
//          DSN=${instance-ZOS_PROCLIB}(${instance-SERVER_STC_NAME})
//SYSPRINT DD SYSOUT=*
//SYSIN  DD *
//SYSUT1 DD DATA,DLM='@@'
//${instance-SERVER_STC_NAME} PROC ARGS=,
//   JAVACLS='com.ibm.acsp.server.main.Server',
//   VERSION='17',
//   LOGLVL='+D',
//   REGSIZE='0M',
//   LEPARM=''
//*** start ACSP server using JZOS
//JAVAJVM  EXEC PGM=JVMLDM&VERSION,REGION=&REGSIZE,
//   PARM='&LEPARM/&LOGLVL &JAVACLS &ARGS'
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//CEEDUMP  DD SYSOUT=*
//ABNLIGNR DD DUMMY
//*
//STDENV  DD DISP=SHR,DSN=${instance-ZOS_PARMLIB}(${instance-SERVER_STC_NAME})
@@
/*