/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

/***********************************************************************/
/* Creating the required user IDs and groups                           */
/***********************************************************************/


DB_CURRENT_SCHEMA="${instance-WHAT_INSTANCE}DB"
WORKFLOW_OWNER="${_step-stepOwnerUpper}"

Say "Connecting" WORKFLOW_OWNER "to" DB_CURRENT_SCHEMA
"CONNECT " WORKFLOW_OWNER "GROUP("DB_CURRENT_SCHEMA")",
   " OWNER(CCCAGRP) AUTH(USE) UACC(NONE)"
"SETROPTS RACLIST(GROUP) REFRESH"