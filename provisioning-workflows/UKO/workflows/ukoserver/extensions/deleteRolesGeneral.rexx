/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

Say "Deleting general roles"

"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.keystores:list"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:list"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.templates:list"

"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.vaults:list"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.vaults:write"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.*.vaults:delete"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.*.vaults:read"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.*.vaults:write"

"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.datasets:read"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.auditlog:read"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:cache-rebuild"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:logs-download"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.settings:write"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.integrity:write"

/* Analytics roles */
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-statistics"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-settings"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-schedules"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:list-analytics-runs"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:set-analytics-settings"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:create-analytics-schedule"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:update-analytics-schedule"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:delete-analytics-schedule"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:initiate-analytics-run"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:get-analytics-run"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.meta:stop-analytics-run"

"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.user:passcode:create"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.user:passcode:delete" 

/* ACSP integration */
"RDELETE EJBROLE" SAFPREFIX".crypto-connect.servers:list"
"RDELETE EJBROLE" SAFPREFIX".crypto-connect.servers:read"
"RDELETE EJBROLE" SAFPREFIX".crypto-connect.servers:write"
"RDELETE EJBROLE" SAFPREFIX".crypto-connect.servers:delete"

/* Refresh */
"SETROPTS RACLIST(EJBROLE) REFRESH"
