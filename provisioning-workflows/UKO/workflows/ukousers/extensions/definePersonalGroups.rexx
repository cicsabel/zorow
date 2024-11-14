/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

VAULT_ADMIN_GROUP="${instance-UKO_VAULT_ADMIN_GROUP}"
KEY_ADMIN_GROUP="${instance-UKO_KEY_ADMIN_GROUP}"
KEY_CUSTODIAN1_GROUP="${instance-UKO_KEY_CUSTODIAN1_GROUP}"
KEY_CUSTODIAN2_GROUP="${instance-UKO_KEY_CUSTODIAN2_GROUP}"
UKO_AUDITOR_GROUP="${instance-UKO_AUDITOR_GROUP}"

SUPERIOR_GROUP="${instance-UKO_PERSONAL_SUPERIOR_GROUP}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating required groups                                        */
/***********************************************************************/
Say "Creating required groups"
Say "Creating vault administrator group" VAULT_ADMIN_GROUP
"ADDGROUP" VAULT_ADMIN_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating key administrator group" KEY_ADMIN_GROUP
"ADDGROUP" KEY_ADMIN_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating key custodian1 group" KEY_CUSTODIAN1_GROUP
"ADDGROUP" KEY_CUSTODIAN1_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating key custodian2 group" KEY_CUSTODIAN2_GROUP
"ADDGROUP" KEY_CUSTODIAN2_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating auditor group" UKO_AUDITOR_GROUP
"ADDGROUP" UKO_AUDITOR_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
