/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CAT_GROUP="${instance-CLIENT_ACCESS_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating Crypto Connect EJB Roles */
/***********************************************************************/


Say "Defining CAT access roles"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.algorithms:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.crypto_usages:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.jobs:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.job_instances:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.key_instances:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.keys_in_the_system:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.key_lifecycle_events:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.keystores:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.key_usage_events:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.keys_used_by_applications:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.plexes:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.systems:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.units_of_work:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE EJBROLE" SAFPREFIX".cat-api.users:read ",
   " OWNER("SAF_OWNER") UACC(NONE)"

Say "Granting access to CAT roles"
"PERMIT" SAFPREFIX".cat-api.algorithms:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.crypto_usages:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.jobs:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.job_instances:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.key_instances:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.keys_in_the_system:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.key_lifecycle_events:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.keystores:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.key_usage_events:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.keys_used_by_applications:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.plexes:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.systems:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.units_of_work:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.users:read ",
   " CLASS(EJBROLE) ACCESS(READ) ID("CAT_GROUP")"

Say "Refreshing EJBROLE class"
"SETROPTS REFRESH RACLIST(EJBROLE)"

Say "Grant access to APPL" SAFPREFIX "to" CAT_GROUP
"PERMIT" SAFPREFIX "CLASS(APPL) ACCESS(READ) ID("CAT_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"

