/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CLIENT_GROUP="${instance-GENERIC_CLIENT_GROUP}"

SUPERIOR_GROUP="${instance-PERSONAL_SUPERIOR_GROUP}"

SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating required groups                                        */
/***********************************************************************/

Say "Creating client group" CLIENT_GROUP
"ADDGROUP" CLIENT_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end