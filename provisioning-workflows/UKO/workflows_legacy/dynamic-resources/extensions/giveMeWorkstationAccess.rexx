/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

/***********************************************************************/
/* Creating the required user IDs and groups                           */
/***********************************************************************/


DB_CURRENT_SCHEMA="${instance-DB_CURRENT_SCHEMA}"
WORKFLOW_OWNER="${_step-stepOwnerUpper}"
AGENT_CLIENT_GROUP="${instance-UKO_AGENT_CLIENT_GROUP}"

Say "Connecting" WORKFLOW_OWNER "to" DB_CURRENT_SCHEMA
"CONNECT " WORKFLOW_OWNER "GROUP("DB_CURRENT_SCHEMA")",
   " OWNER(CCCAGRP) AUTH(USE) UACC(NONE)"
if RC <> 0 then do
   Say "Connection failed, exiting"
   exit RC
end

Say "Connecting" WORKFLOW_OWNER "to" AGENT_CLIENT_GROUP
"CONNECT " WORKFLOW_OWNER "GROUP("AGENT_CLIENT_GROUP")",
   " OWNER(CCCAGRP) AUTH(USE) UACC(NONE)"
if RC <> 0 then do
   Say "Connection failed, exiting"
   exit RC
end
