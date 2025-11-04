/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SERVER_STC_GROUP="${instance-SERVER_STC_GROUP}"

#if(${instance-WLP_UNAUTHENTICATED_GROUP} && ${instance-WLP_UNAUTHENTICATED_GROUP} != "")
SERVER_UNAUTHENTICATED_GROUP="${instance-WLP_UNAUTHENTICATED_GROUP}"
#end

CLIENT_GROUP="${instance-GENERIC_CLIENT_GROUP}"

SUPERIOR_GROUP="${instance-TECHNICAL_SUPERIOR_GROUP}"

SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating required groups                                        */
/***********************************************************************/
Say "Creating required groups"
Say "Creating Server started task group" SERVER_STC_GROUP
"ADDGROUP" SERVER_STC_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

#if(${instance-WLP_UNAUTHENTICATED_GROUP} && ${instance-WLP_UNAUTHENTICATED_GROUP} != "")
Say "Creating unauthenticated group" SERVER_UNAUTHENTICATED_GROUP
"ADDGROUP" SERVER_UNAUTHENTICATED_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
#end

Say "Creating client group" CLIENT_GROUP
"ADDGROUP" CLIENT_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end