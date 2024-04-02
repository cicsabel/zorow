/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

/***********************************************************************/
/* deleting access from the different user roles                         */
/***********************************************************************/

SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

/***********************************************************************/
/* Creating EJB Roles for key management */
/***********************************************************************/

"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.auditlog:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.certificates:import"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.certificates:import:untrusted"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.datasets:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.integrity:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:active:change_expiration"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:active:deactivate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:active:install"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:active:mark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:active:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:active:update"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:compromised:destroy"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:compromised:install"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:compromised:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:compromised:unmark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:compromised:update"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:deactivated:destroy"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:deactivated:install"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:deactivated:mark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:deactivated:reactivate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:deactivated:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:destroyed_compromised:remove"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:destroyed:mark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:destroyed:remove"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:distribute"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:export"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:generate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:non_existing:generate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:non_existing:import"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:pre_activation:activate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:pre_activation:change_expiration"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:pre_activation:destroy"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:pre_activation:mark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:pre_activation:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:pre_activation:update"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:write:dates"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:write:exportControl"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:write:exportControl:allowedKeys:add"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:write:exportControl:allowedKeys:remove"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keys:write:tags"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keystores:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keystores:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.keystores:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.logs:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.meta:cache-rebuild"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.meta:logs-download"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.settings:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.templates:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.templates:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.templates:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.user:passcode:create"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.user:passcode:delete" 
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.vaults:read" 
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.vaults:write" 
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api.vaults:delete" 

/* Refresh */
"SETROPTS RACLIST(EJBROLE) REFRESH"
