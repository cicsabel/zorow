/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

VAULT_ADMIN="${instance-UKO_VAULT_ADMIN_GROUP}"
KEY_ADMIN="${instance-UKO_KEY_ADMIN_GROUP}"
KEY_CUSTODIAN1="${instance-UKO_KEY_CUSTODIAN1_GROUP}"
KEY_CUSTODIAN2="${instance-UKO_KEY_CUSTODIAN2_GROUP}"
UKO_AUDITOR="${instance-UKO_AUDITOR_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

/***********************************************************************/
/* Setup the APPL class profile                                        */
/***********************************************************************/
Say "Define access to the server specific APPLID "||SAFPREFIX||" to RACF"
Say "All users that will access APPL "||SAFPREFIX||" are required to have READ access to this resource."

Say "Grant access to APPL "||SAFPREFIX||" to "||VAULT_ADMIN||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) ACCESS(READ) ID("||VAULT_ADMIN||")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Grant access to APPL "||SAFPREFIX||" to "||KEY_ADMIN||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) ACCESS(READ) ID("||KEY_ADMIN||")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Grant access to APPL "||SAFPREFIX||" to "||KEY_CUSTODIAN1||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) ACCESS(READ) ID("||KEY_CUSTODIAN1||")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Grant access to APPL "||SAFPREFIX||" to "||KEY_CUSTODIAN2||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) ACCESS(READ) ID("||KEY_CUSTODIAN2||")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Grant access to APPL "||SAFPREFIX||" to "||UKO_AUDITOR||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) ACCESS(READ) ID("||UKO_AUDITOR||")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"
