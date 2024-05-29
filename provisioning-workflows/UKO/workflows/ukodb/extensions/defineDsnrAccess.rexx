/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/
/***********************************************************************/
/* Granting access to Db2 Naming protected access profiles */
/***********************************************************************/

SERVER_STC_USER="${instance-UKO_SERVER_STC_USER}"
AGENT_STC_USER="${instance-UKO_AGENT_STC_USER}"

/***********************************************************************/
/* RRSAF for the Recoverable Resource Services access facility         */
/***********************************************************************/
Say "Defining RRSAF profile in DSNR class"
"RDEFINE DSNR ${instance-DB_JCC_SSID}.RRSAF UACC(NONE)"
Say "Granting access to RRSAF profile to" SERVER_STC_USER
"PERMIT ${instance-DB_JCC_SSID}.RRSAF CLASS(DSNR)",
   " ACCESS(READ) ID("SERVER_STC_USER")"                 

#if(${instance-WORKSTATION_ACCESS_REQUIRED} && ${instance-WORKSTATION_ACCESS_REQUIRED} == "true")
/***********************************************************************/
/* BATCH for the TSO attachment facility, the call attachment facility */
/* (aka CAF) and Db2 utilities */
/***********************************************************************/
Say "Defining BATCH profile in DSNR class"
"RDEFINE DSNR ${instance-DB_JCC_SSID}.BATCH UACC(NONE)"
Say "Granting access to BATCH profile to" AGENT_STC_USER
"PERMIT ${instance-DB_JCC_SSID}.BATCH CLASS(DSNR)",
   " ACCESS(READ) ID("AGENT_STC_USER")"                 
#end

/***********************************************************************/
/* DIST for the DDF address space, required for type 4 access          */
/***********************************************************************/
Say "Defining DIST profile in DSNR class"
"RDEFINE DSNR ${instance-DB_JCC_SSID}.DIST UACC(NONE)"
Say "Granting access to DIST profile to" AGENT_STC_USER
"PERMIT ${instance-DB_JCC_SSID}.DIST CLASS(DSNR)",
   " ACCESS(READ) ID("SERVER_STC_USER")"                 


Say "Refreshing DSNR"
"SETROPTS RACLIST(DSNR) REFRESH"
