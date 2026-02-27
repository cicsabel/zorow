/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

SERVER_STC_USER="${instance-SERVER_STC_USER}"
SERVER_STC_GROUP="${instance-SERVER_STC_GROUP}"

SERVER_UNAUTHENTICATED_USER="${instance-WLP_UNAUTHENTICATED_USER}"
SERVER_UNAUTHENTICATED_GROUP="${instance-WLP_UNAUTHENTICATED_GROUP}"

SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating all required user ids                                      */
/***********************************************************************/

Say "Creating Liberty started task user ID" SERVER_STC_USER
"ADDUSER "SERVER_STC_USER" NOPASSWORD",
   " DFLTGRP("SERVER_STC_GROUP") NAME('Liberty SERVER')",
   " OWNER("SAF_OWNER") OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"SERVER_STC_USER"'))"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

/* unauthenticated user for Liberty server (WSGUEST by default)" */
Say "Creating unauthenticated user ID" SERVER_UNAUTHENTICATED_USER
"ADDUSER "SERVER_UNAUTHENTICATED_USER" RESTRICTED NOOIDCARD NOPASSWORD",
   " DFLTGRP("SERVER_UNAUTHENTICATED_GROUP") NAME('WAS DEFAULT USER')",
   " OWNER("SAF_OWNER") OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"SERVER_UNAUTHENTICATED_USER"')) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end



