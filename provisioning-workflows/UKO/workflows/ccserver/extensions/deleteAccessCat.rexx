/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CAT_GROUP="${instance-GENERIC_CLIENT_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating Crypto Connect EJB Roles */
/***********************************************************************/


Say "Removing access from CAT roles"
"PERMIT" SAFPREFIX".cat-api.algorithms:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.crypto_usages:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.jobs:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.job_instances:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.key_instances:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.keys_in_the_system:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.key_lifecycle_events:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.keystores:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.key_usage_events:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.keys_used_by_applications:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.plexes:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.systems:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.units_of_work:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"
"PERMIT" SAFPREFIX".cat-api.users:read ",
   " CLASS(EJBROLE) DELETE ID("CAT_GROUP")"

Say "Deleting CAT access roles"
"RDELETE EJBROLE" SAFPREFIX".cat-api.algorithms:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.crypto_usages:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.jobs:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.job_instances:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.key_instances:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.keys_in_the_system:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.key_lifecycle_events:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.keystores:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.key_usage_events:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.keys_used_by_applications:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.plexes:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.systems:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.units_of_work:read "
"RDELETE EJBROLE" SAFPREFIX".cat-api.users:read "

Say "Refreshing EJBROLE class"
"SETROPTS REFRESH RACLIST(EJBROLE)"

Say "Grant access to APPL" SAFPREFIX "to" CAT_GROUP
"PERMIT" SAFPREFIX "CLASS(APPL) DELETE ID("CAT_GROUP")"
if RC <> 0 then do
   Say "Permit failed, exiting"
   exit RC
end

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"

