/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

KEY_PREFIX="${instance-KEY_PREFIX}"
SERVER_STC_USER="${instance-SERVER_STC_USER}"

Say "Remove access to" KEY_PREFIX".** from" SERVER_STC_USER
"PERMIT" KEY_PREFIX".**   CLASS(CSFKEYS) DELETE ID("SERVER_STC_USER")"

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"

exit