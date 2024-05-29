/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

AGENT_STC_USER="${instance-UKO_AGENT_STC_USER}"
AGENT_STC_GROUP="${instance-UKO_AGENT_STC_GROUP}"

AGENT_CLIENT_USER="${instance-UKO_AGENT_CLIENT_USER}"
AGENT_CLIENT_GROUP="${instance-UKO_AGENT_CLIENT_GROUP}"

SERVER_STC_USER="${instance-UKO_SERVER_STC_USER}"
SERVER_STC_GROUP="${instance-UKO_SERVER_STC_GROUP}"

SERVER_UNAUTHENTICATED_USER="${instance-UKO_UNAUTHENTICATED_USER}"
SERVER_UNAUTHENTICATED_GROUP="${instance-UKO_UNAUTHENTICATED_GROUP}"

SUPERIOR_GROUP="${instance-UKO_TECHNICAL_SUPERIOR_GROUP}"

#if($!{instance-UKO_CREATE_TECHNICAL_USER_GROUPS} == "true" ) 
/***********************************************************************/
/* Creating required groups                                        */
/***********************************************************************/
Say "Creating required groups"
Say "Creating Agent started task group" AGENT_STC_GROUP
"ADDGROUP" AGENT_STC_GROUP "SUPGROUP("SUPERIOR_GROUP") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating Client group for authentication with agent" AGENT_CLIENT_GROUP
"ADDGROUP" AGENT_CLIENT_GROUP "SUPGROUP("SUPERIOR_GROUP") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating Liberty started task group" SERVER_STC_GROUP
"ADDGROUP" SERVER_STC_GROUP "SUPGROUP("SUPERIOR_GROUP") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating unauthenticated group" SERVER_UNAUTHENTICATED_GROUP
"ADDGROUP" SERVER_UNAUTHENTICATED_GROUP "SUPGROUP("SUPERIOR_GROUP") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
#end

#if($!{instance-UKO_CREATE_TECHNICAL_USERIDS} == "true" ) 
/***********************************************************************/
/* Creating all required user ids                                      */
/***********************************************************************/
Say "Creating Agent started task user ID" AGENT_STC_USER
"ADDUSER" AGENT_STC_USER "NOPASSWORD",
   " DFLTGRP("AGENT_STC_GROUP") NAME('UKO agent')",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"AGENT_STC_USER"'))"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

Say "Creating Client user for authentication with agent" AGENT_CLIENT_USER
"ADDUSER "AGENT_CLIENT_USER" NOPASSWORD",
   " DFLTGRP("AGENT_CLIENT_GROUP") NAME('UKO Client')"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

Say "Creating Liberty started task user ID" SERVER_STC_USER
"ADDUSER "SERVER_STC_USER" NOPASSWORD",
   " DFLTGRP("SERVER_STC_GROUP") NAME('UKO Liberty SERVER')",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"SERVER_STC_USER"'))"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

/* unauthenticated user for Liberty server (WSGUEST by default)" */
Say "Creating unauthenticated user ID" SERVER_UNAUTHENTICATED_USER
"ADDUSER "SERVER_UNAUTHENTICATED_USER" RESTRICTED NOOIDCARD NOPASSWORD",
   " DFLTGRP("SERVER_UNAUTHENTICATED_GROUP") NAME('WAS DEFAULT USER')",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"SERVER_UNAUTHENTICATED_USER"')) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

#end 


