/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

GENERIC_CLIENT_USER="${instance-GENERIC_CLIENT_USER}"
GENERIC_CLIENT_GROUP="${instance-GENERIC_CLIENT_GROUP}"

SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating all required user ids                                      */
/***********************************************************************/

Say "Creating generic client user ID" GENERIC_CLIENT_USER
"ADDUSER" GENERIC_CLIENT_USER "NOPASSWORD",
   " DFLTGRP("GENERIC_CLIENT_GROUP") NAME('GENERIC CLIENT')",
   " OWNER("SAF_OWNER") OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"GENERIC_CLIENT_USER"'))"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
