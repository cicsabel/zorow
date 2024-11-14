/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CC_GROUP="${instance-CRYPTO_CONNECT_USER_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating common EJB Roles */
/***********************************************************************/

Say "Defining the role class"
"RDEFINE EJBROLE" SAFPREFIX".*.* ",
   " OWNER("SAF_OWNER") UACC(NONE)"

Say "Defining EJB roles for authentication"
"RDEFINE EJBROLE" SAFPREFIX".ekmf-rest-api.authenticated ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".com.ibm.ws.security.oauth20.* ",
   " OWNER("SAF_OWNER") UACC(NONE)"

Say "Grant access to the EJB roles for authentication to every user"
"PERMIT" SAFPREFIX".ekmf-rest-api.authenticated CLASS(EJBROLE) ACCESS(READ) ID(*)"
"PERMIT" SAFPREFIX".com.ibm.ws.security.oauth20.* CLASS(EJBROLE) ACCESS(READ) ID(*)"

Say "Refreshing EJBROLE"
"SETROPTS RACLIST(EJBROLE) REFRESH"

/***********************************************************************/
/* Creating Crypto Connect EJB Roles */
/***********************************************************************/

Say "Defining crypto connect roles, as they might not have been defined yet"
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.operations:data:encrypt ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".crypto-connect.operations:data:decrypt ",
   " OWNER("SAF_OWNER") UACC(NONE)"

Say "Granting access to crypto connect roles"
"PERMIT" SAFPREFIX".crypto-connect.operations:data:encrypt",
   " CLASS(EJBROLE) ACCESS(READ) ID("CC_GROUP")"
"PERMIT" SAFPREFIX".crypto-connect.operations:data:decrypt",
   " CLASS(EJBROLE) ACCESS(READ) ID("CC_GROUP")"

Say "Refreshing EJBROLE class"
"SETROPTS REFRESH RACLIST(EJBROLE)"

Say "Grant access to APPL" SAFPREFIX "to" CC_GROUP
"PERMIT" SAFPREFIX "CLASS(APPL) ACCESS(READ) ID("CC_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"

