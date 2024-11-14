/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SERVER_STC_USER="${instance-UKO_SERVER_STC_USER}"
KEY_PREFIX="${instance-UKO_KEY_PREFIX}"
RECOVERY_KEY="${instance-UKO_RECOVERY_KEY}"

SAF_OWNER="${instance-SAF_OWNER}"

Say "Defining key prefix profile" KEY_PREFIX".** in case this has not been done"
"RDEF CSFKEYS" KEY_PREFIX".** OWNER("SAF_OWNER") UACC(NONE) ICSF(SYMCPACFWRAP(YES),SYMCPACFRET(YES))"
Say "Granting access to" SERVER_STC_USER "on" KEY_PREFIX
"PERMIT" KEY_PREFIX".**  CLASS(CSFKEYS) ACCESS(CONTROL) ID("SERVER_STC_USER")"
/* "PERMIT" KEY_PREFIX".**  CLASS(CSFKEYS) ACCESS(CONTROL) ID("KEY_ADMIN_GROUP")" */

Say "Defining the recovery key label" RECOVERY_KEY""
"RDEF CSFKEYS" RECOVERY_KEY" OWNER("SAF_OWNER") UACC(NONE)"
Say "Granting access to" RECOVERY_KEY" for" SERVER_STC_USER
"PERMIT" RECOVERY_KEY"  CLASS(CSFKEYS) ACCESS(CONTROL) ID("SERVER_STC_USER")"
/* "PERMIT" RECOVERY_KEY"  CLASS(CSFKEYS) ACCESS(CONTROL) ID("KEY_ADMIN_GROUP")" */

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"
