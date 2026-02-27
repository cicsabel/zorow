/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

/***********************************************************************/
/* Creating the required user IDs and groups                           */
/***********************************************************************/


Say "Resuming ${instance-RESUME_USER} user id "
"ALU ${instance-RESUME_USER} RESUME"
