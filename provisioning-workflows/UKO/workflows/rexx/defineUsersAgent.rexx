/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

AGENT_STC_USER="${instance-AGENT_STC_USER}"
AGENT_STC_GROUP="${instance-AGENT_STC_GROUP}"

AGENT_CLIENT_USER="${instance-UKO_AGENT_CLIENT_USER}"
AGENT_CLIENT_GROUP="${instance-UKO_AGENT_CLIENT_GROUP}"

SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating all required user ids                                      */
/***********************************************************************/
Say "Creating Agent started task user ID" AGENT_STC_USER
"ADDUSER" AGENT_STC_USER "NOPASSWORD",
   " DFLTGRP("AGENT_STC_GROUP") NAME('UKO agent')",
   " OWNER("SAF_OWNER") OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"AGENT_STC_USER"'))"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

Say "Creating Client user for authentication with agent" AGENT_CLIENT_USER
"ADDUSER "AGENT_CLIENT_USER" NOPASSWORD OWNER("SAF_OWNER")",
   " DFLTGRP("AGENT_CLIENT_GROUP") NAME('UKO Client')"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end