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
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating genera EJB Roles */
/***********************************************************************/

"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keystores:list OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:list OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.templates:list OWNER("SAF_OWNER") UACC(NONE)"

"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.vaults:list OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.vaults:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.*.vaults:delete OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.*.vaults:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.*.vaults:write OWNER("SAF_OWNER") UACC(NONE)"

"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.datasets:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.auditlog:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:cache-rebuild OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:logs-download OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.settings:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.integrity:write OWNER("SAF_OWNER") UACC(NONE)"

/* Analytics roles */
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-statistics OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-settings OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-schedules OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:list-analytics-runs OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:set-analytics-settings OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:create-analytics-schedule OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:update-analytics-schedule OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:delete-analytics-schedule OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:initiate-analytics-run OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-run OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:stop-analytics-run OWNER("SAF_OWNER") UACC(NONE)"

"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.user:passcode:create OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.user:passcode:delete OWNER("SAF_OWNER") UACC(NONE)" 

/* ACSP integration */
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.servers:list OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.servers:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.servers:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.servers:delete OWNER("SAF_OWNER") UACC(NONE)"

/***********************************************************************/
/* Key admin, who sets up the key hierarchy, and controls keystores    */
/* and templates, as well as performs special key state actions.       */
/***********************************************************************/

Say "Grant Permissions to Vault Administrator"
"PERMIT" SAFPREFIX".ekmf-rest-api.datasets:read CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:cache-rebuild CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:logs-download CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.settings:write CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.integrity:write CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"

"PERMIT" SAFPREFIX".ekmf-rest-api.vaults:list CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.vaults:write CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
/* allowing the key admin to see the vault they just created to be able to retrieve the vault ID */
"PERMIT" SAFPREFIX".ekmf-rest-api.*.vaults:read CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.*.vaults:write CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.*.vaults:delete CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"

"PERMIT" SAFPREFIX".ekmf-rest-api.keystores:list CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:list CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.templates:list CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"

"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"

Say "Grant Permissions to Key Administrator"
"PERMIT" SAFPREFIX".ekmf-rest-api.datasets:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.auditlog:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keystores:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"

"PERMIT" SAFPREFIX".ekmf-rest-api.templates:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.vaults:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"

/* analytics roles */
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-statistics CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-settings CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-schedules CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:list-analytics-runs CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
/* Those roles are only for the admin */
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:set-analytics-settings CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:create-analytics-schedule CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:update-analytics-schedule CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:delete-analytics-schedule CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:initiate-analytics-run CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-run CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:stop-analytics-run CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"

"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"

/* ACSP integration */
"PERMIT" SAFPREFIX".crypto-connect.servers:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".crypto-connect.servers:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".crypto-connect.servers:write CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".crypto-connect.servers:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"

Say "Grant Permissions to Key Custodian1"
"PERMIT" SAFPREFIX".ekmf-rest-api.datasets:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keystores:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.templates:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.vaults:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

/* analytics roles */
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-statistics CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-settings CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-schedules CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:list-analytics-runs CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

/* ACSP integration */
"PERMIT" SAFPREFIX".crypto-connect.servers:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".crypto-connect.servers:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

Say "Grant Permissions to Key Custodian2"
"PERMIT" SAFPREFIX".ekmf-rest-api.datasets:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keystores:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.templates:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.vaults:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"

/* analytics roles */
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-statistics CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-settings CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:get-analytics-schedules CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.meta:list-analytics-runs CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"

"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"

/* ACSP integration */
"PERMIT" SAFPREFIX".crypto-connect.servers:list CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".crypto-connect.servers:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"

Say "Grant Permissions to Auditor"
"PERMIT" SAFPREFIX".ekmf-rest-api.auditlog:read CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api.datasets:read CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keystores:list CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:list CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api.templates:list CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api.vaults:list CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"

"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"

/* Refresh */
"SETROPTS RACLIST(EJBROLE) REFRESH"
