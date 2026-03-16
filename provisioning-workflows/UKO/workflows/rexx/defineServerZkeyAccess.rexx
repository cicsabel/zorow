/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

ZKEY_GROUP="${instance-CLIENT_ACCESS_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"
VAULT_ID="${instance-UKO_VAULT_ID}"

/***********************************************************************/
/* Creating EJB Roles for ZKEY access */
/***********************************************************************/

"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:pre_activation:activate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:generate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:export OWNER("SAF_OWNER") UACC(NONE)" 
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:write:tags OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.templates:read OWNER("SAF_OWNER") UACC(NONE)"

"PERMIT" SAFPREFIX".ekmf-rest-api.keys:read CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:write CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:pre_activation:activate CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:generate CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:export CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:write:tags CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.templates:read CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"

/* only for EKMF Web*/
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:active:install OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:non_existing:import OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:non_existing:generate OWNER("SAF_OWNER") UACC(NONE)"

"PERMIT" SAFPREFIX".ekmf-rest-api.keys:active:install CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:non_existing:import CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:non_existing:generate CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"


/* to be verified */
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.user:passcode:create OWNER("SAF_OWNER") UACC(NONE)"
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"


"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.certificates:import OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.certificates:import:untrusted OWNER("SAF_OWNER") UACC(NONE)"

"PERMIT" SAFPREFIX".ekmf-rest-api.certificates:import CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.certificates:import:untrusted CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"


Say "Refreshing EJBROLE"
"SETROPTS REFRESH RACLIST(EJBROLE)"

/* Don't forget access to the APPL class */
Say "Granting Access to "SAFPREFIX" in the APPL class to "ZKEY_GROUP
"PERMIT" SAFPREFIX "CLASS(APPL) ACCESS(READ) ID("ZKEY_GROUP")"
Say "Refreshing APPL"
"SETROPTS REFRESH RACLIST(APPL)" 

/* current list for UKO, more vault specific roles will be added in the future */
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:install OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:import OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:generate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:activate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:export OWNER("SAF_OWNER") UACC(NONE)"

"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:import CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:activate CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:non_existing:generate CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:active:install CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:export CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"

/* new to UKO */
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:activate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:generate OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:export OWNER("SAF_OWNER") UACC(NONE)" 
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:tags OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read OWNER("SAF_OWNER") UACC(NONE)"

"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:read CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:pre_activation:activate CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:generate CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:export CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".keys:write:tags CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api."VAULT_ID".templates:read CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"


"SETROPTS REFRESH RACLIST(EJBROLE)"

