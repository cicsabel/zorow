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

SUPERIOR_GROUP="${instance-CC_TECHNICAL_SUPERIOR_GROUP}"

SAF_OWNER="${instance-SAF_OWNER}"

#if($!{instance-CC_CREATE_TECHNICAL_USER_GROUPS} == "true" ) 
/***********************************************************************/
/* Creating required groups                                        */
/***********************************************************************/
Say "Creating required groups"
Say "Creating Liberty started task group" SERVER_STC_GROUP
"ADDGROUP" SERVER_STC_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating unauthenticated group" SERVER_UNAUTHENTICATED_GROUP
"ADDGROUP" SERVER_UNAUTHENTICATED_GROUP "SUPGROUP("SUPERIOR_GROUP") ",
   " OWNER("SAF_OWNER") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
#end

#if($!{instance-CC_CREATE_TECHNICAL_USERIDS} == "true" ) 
/***********************************************************************/
/* Creating all required user ids                                      */
/***********************************************************************/

Say "Creating Liberty started task user ID" SERVER_STC_USER
"ADDUSER" SERVER_STC_USER "NOPASSWORD",
   " DFLTGRP("SERVER_STC_GROUP") NAME('CC Liberty SERVER')",
   " OWNER("SAF_OWNER") OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"SERVER_STC_USER"'))"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

/* unauthenticated user for Liberty server (WSGUEST by default)" */
Say "Creating unauthenticated user ID" SERVER_UNAUTHENTICATED_USER
"ADDUSER" SERVER_UNAUTHENTICATED_USER "RESTRICTED NOOIDCARD NOPASSWORD",
   " DFLTGRP("SERVER_UNAUTHENTICATED_GROUP") NAME('WAS DEFAULT USER')",
   " OWNER("SAF_OWNER") OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"SERVER_UNAUTHENTICATED_USER"')) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
#end 


