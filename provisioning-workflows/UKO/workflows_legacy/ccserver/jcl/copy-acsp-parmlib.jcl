//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//COPYPARM EXEC PGM=IKJEFT01
//IN DD PATH='${instance-TEMP_DIR}/${instance-SERVER_STC_NAME}-ACSPPARM'
//OUT DD DISP=SHR,DSN=${instance-ZOS_PARMLIB}(${instance-SERVER_STC_NAME})
//SYSTSPRT DD SYSOUT=*
//SYSTSIN DD *
OCOPY INDD(IN) OUTDD(OUT) TEXT
/*