/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

GKLM_GROUP="${instance-UKO_GKLM_CLIENT_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
VAULT_ID="${instance-UKO_VAULT_ID}"

/***********************************************************************/
/* Creating EJB Roles for GKLM access */
/***********************************************************************/

"PERMIT" SAFPREFIX".ekmf-rest-api.templates:read CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"

"PERMIT" SAFPREFIX".ekmf-rest-api.keys:read CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")" 
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:write CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:delete CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")" 

/* create keys */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:generate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:activate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:install CLASS(EJBROLE)  ACCESS(READ) ID("GKLM_GROUP")"

/* uninstall required to change key label */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:uninstall CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"

/* key deactivation, deletion, destruction */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:deactivate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:uninstall CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:destroy CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:delete CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"

/* crypto connect */
Say "Defining crypto connect roles, as they might not have been defined yet"
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.operations:data:encrypt UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.operations:data:decrypt UACC(NONE)"

Say "Granting access to crypto connect roles"
"PERMIT" SAFPREFIX".crypto-connect.operations:data:encrypt CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".crypto-connect.operations:data:decrypt CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"

Say "Refreshing EJBROLE class"
"SETROPTS REFRESH RACLIST(EJBROLE)"

Say "Grant access to APPL" SAFPREFIX "to" GKLM_GROUP
"PERMIT" SAFPREFIX "CLASS(APPL) ACCESS(READ) ID("GKLM_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"

exit 0

/* SAF permissions for future use, once GKLM migrated to use V4 APIs */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:delete CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
/* to be able to reactivate after rotation */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:reactivate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"

