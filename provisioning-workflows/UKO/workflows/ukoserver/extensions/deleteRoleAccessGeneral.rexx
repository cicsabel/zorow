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
/* deleting access from the different user roles                         */
/***********************************************************************/

Say "Delete Permissions from Vault Administrator"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.datasets:read CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.meta:cache-rebuild CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.meta:logs-download CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.settings:write CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.integrity:write CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.vaults:list CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.vaults:write CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.*.vaults:read CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.*.vaults:write CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.*.vaults:delete CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.keystores:list CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keys:list CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.templates:list CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) DELETE ID("||VAULT_ADMIN||")"

Say "Delete Permissions from Key Administrator"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.datasets:read CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.auditlog:read CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keystores:list CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keys:list CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.templates:list CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.vaults:list CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) DELETE ID("||KEY_ADMIN||")"

Say "Delete Permissions from Key Custodian1"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.datasets:read CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN1||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keystores:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN1||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keys:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN1||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.templates:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN1||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.vaults:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN1||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN1||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN1||")"

Say "Delete Permissions from Key Custodian2"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.datasets:read CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN2||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keystores:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN2||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keys:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN2||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.templates:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN2||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.vaults:list CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN2||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN2||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) DELETE ID("||KEY_CUSTODIAN2||")"

Say "Delete Permissions from Auditor"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.auditlog:read CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.datasets:read CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keystores:list CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.keys:list CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.templates:list CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.vaults:list CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"

"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"
"PERMIT "||SAFPREFIX||".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) DELETE ID("||UKO_AUDITOR||")"

/* Refresh */
"SETROPTS RACLIST(EJBROLE) REFRESH"
