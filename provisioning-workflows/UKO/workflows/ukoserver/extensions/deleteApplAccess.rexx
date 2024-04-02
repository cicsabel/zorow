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
Say "All users that will access UKO are required to have READ access to this resource."

Say "Delete access to UKO from "||VAULT_ADMIN||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) DELETE ID("||VAULT_ADMIN||")"
Say "Delete access to UKO from "||KEY_ADMIN||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) DELETE ID("||KEY_ADMIN||")"
Say "Delete access to UKO from "||KEY_CUSTODIAN1||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) DELETE ID("||KEY_CUSTODIAN1||")"
Say "Delete access to UKO from "||KEY_CUSTODIAN2||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) DELETE ID("||KEY_CUSTODIAN2||")"
Say "Delete access to UKO from "||UKO_AUDITOR||" "
"PERMIT "||SAFPREFIX||" CLASS(APPL) DELETE ID("||UKO_AUDITOR||")"

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"
