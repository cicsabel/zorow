/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

CAT_AGENT_USER="${instance-CAT_AGENT_USER}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* FACILITY class setup                                                */
/***********************************************************************/

/* the user id executing the CAt Agent must have READ access  */
/* to KMG.CAT.TRUSTED.ICSF to run an collection.  */

Say "Defining KMG.CAT.TRUSTED.ICSF class(FACILITY)"
"RDEFINE FACILITY KMG.CAT.TRUSTED.ICSF UACC(NONE) OWNER("SAF_OWNER")"
Say "Granting access to agent task group" CAT_AGENT_USER
"PERMIT KMG.CAT.TRUSTED.ICSF CLASS(FACILITY) ID("CAT_AGENT_USER") ACCESS(READ)"        

Say "Refreshing FACILITY"
"SETROPTS RACLIST(FACILITY) REFRESH"
