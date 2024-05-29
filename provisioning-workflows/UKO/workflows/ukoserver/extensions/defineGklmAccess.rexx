/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

GKLM_GROUP="${instance-UKO_GKLM_CLIENT_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
/***********************************************************************/
/* Creating EJB Roles for GKLM access */
/***********************************************************************/

"PERMIT" SAFPREFIX".ekmf-rest-api.keys:read CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:write CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:delete CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:non_existing:generate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:pre_activation:activate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:pre_activation:update CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:pre_activation:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:active:deactivate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:active:install CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:active:uninstall CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:active:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:deactivated:destroy CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:deactivated:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:destroyed:remove CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:destroyed_compromised:remove CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:destroyed:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.templates:read CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.templates:write CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keystores:read CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".crypto-connect.operations:data:encrypt CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".crypto-connect.operations:data:decrypt CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"

/* roles that are not required for v4 API access anymore: */
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:generate CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:distribute CLASS(EJBROLE) ACCESS(READ) ID("GKLM_GROUP")"

"SETROPTS REFRESH RACLIST(EJBROLE)"

"PERMIT" SAFPREFIX "CLASS(APPL) ACCESS(READ) ID("GKLM_GROUP")"
"SETROPTS REFRESH RACLIST(APPL)" 
