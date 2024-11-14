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
VAULT_ID="${instance-UKO_VAULT_ID}"
/***********************************************************************/
/* Creating EJB Roles specific for the vault key management */
/***********************************************************************/

Say "Defing roles for the vauld ID:" VAULT_ID
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:deactivate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:install OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:mark_compromised OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:uninstall OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:destroy OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:install OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:uninstall OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:unmark_compromised OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:destroy OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:install OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:mark_compromised OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:reactivate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:uninstall OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:destroyed:mark_compromised OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:generate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:import OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:activate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:destroy OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:mark_compromised OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:uninstall OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:dates OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:tags OWNER("SAF_OWNER") UACC(NONE)"

"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:delete OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:delete OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:delete OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:delete OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:write OWNER("SAF_OWNER") UACC(NONE)"

/* roles that have been removed in the transition from v2 to v4, replaced with keys:write */
/* "RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:distribute OWNER("SAF_OWNER") UACC(NONE)" */
/* "RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:generate OWNER("SAF_OWNER") UACC(NONE)" */


/***********************************************************************/
/* Key admin, who sets up the key hierarchy, and controls keystores    */
/* and templates, as well as performs special key state actions.       */
/***********************************************************************/

Say "Grant Permissions to Vault Administrator" VAULT_ADMIN
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:read CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:write CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:delete CLASS(EJBROLE) ACCESS(READ) ID("VAULT_ADMIN")"


Say "Grant Permissions to Key Administrator" KEY_ADMIN
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:install CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:reactivate CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:write CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:write CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:write CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_ADMIN")"

Say "Grant Permissions to Key Custodian1" KEY_CUSTODIAN1
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:deactivate CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:destroy CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:unmark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:destroy CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:destroyed:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:destroy CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
/* "PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:distribute CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")" */

"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

/* only custodian 1 is allowed to generate keys */
/* "PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:generate CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")" */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:generate CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

/* only custodian 1 is allowed to change dates and tags, after a key is created */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:dates CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:tags CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN1")"

Say "Grant Permissions to Key Custodian2" KEY_CUSTODIAN2
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:deactivate CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:destroy CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:unmark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:destroy CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:destroy CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:uninstall CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:destroyed:mark_compromised CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
/* "PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:distribute CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")" */

"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
/* "PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:dates CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")" */
/* "PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:tags CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")" */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:delete CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"

"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:read CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"

/* only custodian 2 is allowed to install or activate keys */
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:install CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:compromised:install CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:deactivated:install CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:activate CLASS(EJBROLE) ACCESS(READ) ID("KEY_CUSTODIAN2")"

Say "Grant Permissions to Auditor" UKO_AUDITOR
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keystores:read CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".vaults:read CLASS(EJBROLE) ACCESS(READ) ID("UKO_AUDITOR")"

/* Refresh */
"SETROPTS RACLIST(EJBROLE) REFRESH"




