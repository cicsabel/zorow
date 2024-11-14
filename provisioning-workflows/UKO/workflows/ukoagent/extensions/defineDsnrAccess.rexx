/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/
/***********************************************************************/
/* Granting access to Db2 Naming protected access profiles */
/***********************************************************************/

AGENT_STC_USER="${instance-UKO_AGENT_STC_USER}"
DB_JCC_SSID="${instance-DB_JCC_SSID}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* If the agent is used with EKMF Workstation, it requires access to   */
/* BATCH for the TSO attachment facility, the call attachment facility */
/* (aka CAF) and Db2 utilities                                         */
/***********************************************************************/
Say "Defining BATCH profile in DSNR class"
"RDEFINE DSNR" DB_JCC_SSID".BATCH OWNER("SAF_OWNER") UACC(NONE)"
Say "Granting access to BATCH profile to" AGENT_STC_USER
"PERMIT" DB_JCC_SSID".BATCH CLASS(DSNR)",
   " ACCESS(READ) ID("AGENT_STC_USER")"                 

Say "Refreshing DSNR"
"SETROPTS RACLIST(DSNR) REFRESH"
