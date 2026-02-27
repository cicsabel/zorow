/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SERVER_STC_USER="${instance-SERVER_STC_USER}"
SERVER_STC_GROUP="${instance-SERVER_STC_GROUP}"

SERVER_UNAUTHENTICATED_USER="${instance-WLP_UNAUTHENTICATED_USER}"
SERVER_UNAUTHENTICATED_GROUP="${instance-WLP_UNAUTHENTICATED_GROUP}"

CLIENT_USER="${instance-GENERIC_CLIENT_USER}"
CLIENT_GROUP="${instance-GENERIC_CLIENT_GROUP}"


#if($!{instance-CREATE_TECHNICAL_USERIDS} == "true" ) 
"DELUSER" SERVER_STC_USER
"DELUSER" SERVER_UNAUTHENTICATED_USER
"DELUSER" CLIENT_USER

#end

#if($!{instance-CREATE_TECHNICAL_USER_GROUPS} == "true" ) 
"DELGROUP" SERVER_STC_GROUP
"DELGROUP" SERVER_UNAUTHENTICATED_GROUP
"DELGROUP" CLIENT_GROUP
#end



