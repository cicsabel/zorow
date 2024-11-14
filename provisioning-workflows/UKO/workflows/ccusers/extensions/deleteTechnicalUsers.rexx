/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SERVER_STC_USER="${instance-CC_SERVER_STC_USER}"
SERVER_STC_GROUP="${instance-CC_SERVER_STC_GROUP}"

SERVER_UNAUTHENTICATED_USER="${instance-CC_UNAUTHENTICATED_USER}"
SERVER_UNAUTHENTICATED_GROUP="${instance-CC_UNAUTHENTICATED_GROUP}"

#if($!{instance-CC_CREATE_TECHNICAL_USERIDS} == "true" ) 
"DELUSER" SERVER_STC_USER
"DELUSER" SERVER_UNAUTHENTICATED_USER

#end

#if($!{instance-CC_CREATE_TECHNICAL_USER_GROUPS} == "true" ) 
"DELGROUP" SERVER_STC_GROUP
"DELGROUP" SERVER_UNAUTHENTICATED_GROUP
#end



