/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

Say "Deleting general roles"

"RDELETE EJBROLE "||SAFPREFIX||".*.*"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.authenticated"
"RDELETE EJBROLE "||SAFPREFIX||".com.ibm.ws.security.oauth20.*"

"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keystores:list"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:list"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.templates:list"

"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.vaults:list"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.vaults:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.*.vaults:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.*.vaults:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.*.vaults:write"

"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.datasets:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.auditlog:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.meta:cache-rebuild"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.meta:logs-download"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.settings:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.integrity:write"

"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.user:passcode:create"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.user:passcode:delete" 

/* Refresh */
"SETROPTS RACLIST(EJBROLE) REFRESH"
