/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

VAULT_ID="${instance-UKO_VAULT_ID}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

Say "Deleting roles for the vauld ID: "||VAULT_ID||" "
/* "RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".integrity:write" */
/* "RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".settings:write" */
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:active:deactivate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:active:install"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:active:mark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:active:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:compromised:destroy"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:compromised:install"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:compromised:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:compromised:unmark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:deactivated:destroy"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:deactivated:install"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:deactivated:mark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:deactivated:reactivate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:deactivated:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:destroyed:mark_compromised"
/* "RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:distribute" */
/* "RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:generate" */
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:non_existing:generate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:non_existing:import"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:pre_activation:activate"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:pre_activation:destroy"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:pre_activation:mark_compromised"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:pre_activation:uninstall"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:write:dates"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keys:write:tags"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keystores:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keystores:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".keystores:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".templates:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".templates:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".templates:write"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".vaults:delete"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".vaults:read"
"RDELETE EJBROLE "||SAFPREFIX||".ekmf-rest-api."||VAULT_ID||".vaults:write"

/* Refresh */
"SETROPTS RACLIST(EJBROLE) REFRESH"
