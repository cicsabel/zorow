//******************************************************************
//* Copyright Contributors to the zOS-Workflow Project.            *
//* PDX-License-Identifier: Apache-2.0                             *
//******************************************************************
//******************************************************************
//*                                                                *
//* Stop the IIB Broker                                            *
//*                                                                *
//* Must be run on a jobclass with the COMMAND=EXECUTE attribute.  *
//*                                                                *
//******************************************************************
//STOPIIB EXEC PGM=IEFBR14
//SYSPRINT DD SYSOUT=*
//   COMMAND 'P ${instance-IIB_BROKER_NAME}'
