/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

KEY_PREFIX="${instance-KEY_PREFIX}"
SERVER_STC_USER="${instance-SERVER_STC_USER}"

#if($!{instance-CREATE_TECHNICAL_USERIDS} == "true" ) 
Say "Remove access to recovery key"
"PERMIT ${instance-UKO_RECOVERY_KEY}  CLASS(CSFKEYS) DELETE ID("SERVER_STC_USER")"
/* "PERMIT ${instance-UKO_RECOVERY_KEY}  CLASS(CSFKEYS) DELETE ID("KEY_ADMIN_GROUP")" */
#end 

Say "Remove access to" KEY_PREFIX".** from" SERVER_STC_USER
"PERMIT" KEY_PREFIX".**   CLASS(CSFKEYS) DELETE ID("SERVER_STC_USER")"

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"
