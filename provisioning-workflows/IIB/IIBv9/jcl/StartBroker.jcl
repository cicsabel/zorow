//******************************************************************
//* Copyright Contributors to the zOS-Workflow Project.            *
//* PDX-License-Identifier: Apache-2.0                             *
//******************************************************************
//******************************************************************
//*                                                                *
//* Start the IIB Broker                                           *
//*                                                                *
//* Must be run on a jobclass with the COMMAND=EXECUTE attribute.  *
//*                                                                *
//******************************************************************
//STARTIIB EXEC PGM=IEFBR14
//SYSPRINT DD SYSOUT=*
//   COMMAND 'S ${instance-IIB_BROKER_NAME}'
