/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

AGENT_STC_USER="${instance-UKO_AGENT_STC_USER}"
DB_JCC_SSID="${instance-DB_JCC_SSID}"

#if($!{instance-UKO_CREATE_TECHNICAL_USERIDS} == "true" ) 
/***********************************************************************/
/***********************************************************************/
/* Remove userids from profiles                                        */
/* this is only done if the userid had been genererated                */
/***********************************************************************/
/***********************************************************************/

/***********************************************************************/
/* Removing access to Db2 Naming protected access profiles */
/***********************************************************************/

Say "Removing access to BATCH profile from" AGENT_STC_USER
"PERMIT" DB_JCC_SSID".RRSAF CLASS(DSNR)",
   " DELETE ID("AGENT_STC_USER")"                 

Say "Refreshing DSNR"
"SETROPTS RACLIST(DSNR) REFRESH"


#end
