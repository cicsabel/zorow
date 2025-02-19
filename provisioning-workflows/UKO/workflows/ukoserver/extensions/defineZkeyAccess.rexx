/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

ZKEY_GROUP="${instance-UKO_ZKEY_CLIENT_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating EJB Roles for ZKEY access */
/***********************************************************************/

"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:export OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:write:exportControl OWNER("SAF_OWNER") UACC(NONE)" 
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:write:exportControl:allowedKeys:add OWNER("SAF_OWNER") UACC(NONE)" 
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.keys:write:exportControl:allowedKeys:remove OWNER("SAF_OWNER") UACC(NONE)" 
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.user:passcode:create OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.user:passcode:delete OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.certificates:import OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.certificates:import:untrusted OWNER("SAF_OWNER") UACC(NONE)"


"PERMIT" SAFPREFIX".ekmf-rest-api.keys:export CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:write:exportControl CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")" 
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:write:exportControl:allowedKeys:add CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")" 
"PERMIT" SAFPREFIX".ekmf-rest-api.keys:write:exportControl:allowedKeys:remove CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")" 
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:create CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.user:passcode:delete CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.certificates:import CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"
"PERMIT" SAFPREFIX".ekmf-rest-api.certificates:import:untrusted CLASS(EJBROLE) ACCESS(READ) ID("ZKEY_GROUP")"

"SETROPTS REFRESH RACLIST(EJBROLE)"

"PERMIT" SAFPREFIX "CLASS(APPL) ACCESS(READ) ID("ZKEY_GROUP")"
"SETROPTS REFRESH RACLIST(APPL)" 
