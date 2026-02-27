/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

WLP_ANGEL_NAME="${instance-WLP_ANGEL_NAME}"

/***********************************************************************/
/* Delete the STARTED task for the angel process                       */
/***********************************************************************/
Say "Deleting STARTED task for the angel process"
"RDELETE STARTED" WLP_ANGEL_NAME".*"

Say "Refreshing STARTED"
"SETROPTS RACLIST(STARTED) REFRESH"

/***********************************************************************/
/***********************************************************************/
#end
