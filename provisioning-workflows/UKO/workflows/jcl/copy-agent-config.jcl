//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//COPYPARM EXEC PGM=IKJEFT01
//IN DD PATH='${instance-TEMP_DIR}/${instance-AGENT_STC_NAME}-KMGPARM'
//OUT DD DISP=SHR,DSN=${instance-ZOS_PARMLIB}(${instance-AGENT_STC_NAME})
//SYSTSPRT DD SYSOUT=*
//SYSTSIN DD *
OCOPY INDD(IN) OUTDD(OUT) TEXT
/*