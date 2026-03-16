/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CERT_CLIENT_USER="${instance-CERT_CLIENT_USER}"
CLIENT_ACCESS_GROUP="${instance-CLIENT_ACCESS_GROUP}"

SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Creating all required user ids                                      */
/***********************************************************************/

Say "Creating certificate client user ID" CERT_CLIENT_USER
"ADDUSER" CERT_CLIENT_USER "NOPASSWORD",
   " DFLTGRP("CLIENT_ACCESS_GROUP") NAME('CERT CLIENT')",
   " OWNER("SAF_OWNER") OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"CERT_CLIENT_USER"'))"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
