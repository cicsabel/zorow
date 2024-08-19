/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

AGENT_STC_GROUP="${instance-UKO_AGENT_STC_GROUP}"
AGENT_CLIENT_GROUP="${instance-UKO_AGENT_CLIENT_GROUP}"
SERVER_STC_GROUP="${instance-UKO_SERVER_STC_GROUP}"
SERVER_UNAUTHENTICATED_GROUP="${instance-UKO_UNAUTHENTICATED_GROUP}"
SUPERIOR_GROUP="${instance-UKO_TECHNICAL_SUPERIOR_GROUP}"

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
"ADDGROUP" SERVER_UNAUTHENTICATED_GROUP "SUPGROUP("SUPERIOR_GROUP")",
   " OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
