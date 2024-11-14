/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

SERVER_STC_USER="${instance-CC_SERVER_STC_USER}"
KEY_PREFIX="${instance-CC_KEY_PREFIX}"

SAF_OWNER="${instance-SAF_OWNER}"

Say "Defining key prefix profile" KEY_PREFIX".** in case this has not been done"
"RDEF CSFKEYS" KEY_PREFIX".** OWNER("SAF_OWNER") UACC(NONE) ICSF(SYMCPACFWRAP(YES),SYMCPACFRET(YES))"
Say "Granting access to" SERVER_STC_USER "on" KEY_PREFIX
"PERMIT" KEY_PREFIX".**  CLASS(CSFKEYS) ACCESS(CONTROL) ID(" SERVER_STC_USER ")"

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"

exit