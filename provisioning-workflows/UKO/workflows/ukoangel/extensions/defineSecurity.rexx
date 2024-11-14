/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/
/***********************************************************************/
/* Define dynamic security profiles for the angel process              */
/***********************************************************************/

WLP_ANGEL_NAME="${instance-WLP_ANGEL_NAME}"
ANGEL_STC_USER="${instance-ANGEL_STC_USER}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Setup the STARTED task for the angel process                        */
/***********************************************************************/
Say "Defining STARTED task for the angel process"
"RDEF STARTED" WLP_ANGEL_NAME".* OWNER("SAF_OWNER") UACC(NONE)",
   " STDATA(USER("ANGEL_STC_USER")"

Say "Refreshing STARTED"
"SETROPTS RACLIST(STARTED) REFRESH"

