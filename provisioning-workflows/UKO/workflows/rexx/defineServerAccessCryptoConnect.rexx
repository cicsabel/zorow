/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CC_GROUP="${instance-CLIENT_ACCESS_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"

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

