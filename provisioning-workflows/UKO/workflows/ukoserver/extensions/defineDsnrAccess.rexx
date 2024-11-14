/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/
/***********************************************************************/
/* Granting access to Db2 Naming protected access profiles */
/***********************************************************************/

SERVER_STC_USER="${instance-UKO_SERVER_STC_USER}"
DB_JCC_SSID="${instance-DB_JCC_SSID}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* RRSAF for the Recoverable Resource Services access facility         */
/***********************************************************************/
Say "Defining RRSAF profile in DSNR class"
"RDEFINE DSNR" DB_JCC_SSID".RRSAF OWNER("SAF_OWNER") UACC(NONE)"
Say "Granting access to RRSAF profile to" SERVER_STC_USER
"PERMIT" DB_JCC_SSID".RRSAF CLASS(DSNR)",
   " ACCESS(READ) ID("SERVER_STC_USER")"                 

/***********************************************************************/
/* DIST for the DDF address space, required for type 4 access          */
/***********************************************************************/
Say "Defining DIST profile in DSNR class"
"RDEFINE DSNR" DB_JCC_SSID".DIST OWNER("SAF_OWNER") UACC(NONE)"
Say "Granting access to DIST profile to" AGENT_STC_USER
"PERMIT" DB_JCC_SSID".DIST CLASS(DSNR)",
   " ACCESS(READ) ID("SERVER_STC_USER")"                 

Say "Refreshing DSNR"
"SETROPTS RACLIST(DSNR) REFRESH"
