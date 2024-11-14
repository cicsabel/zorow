/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

SERVER_STC_USER="${instance-CC_SERVER_STC_USER}"
SERVER_STC_GROUP="${instance-CC_SERVER_STC_GROUP}"

SERVER_UNAUTHENTICATED_USER="${instance-CC_UNAUTHENTICATED_USER}"
SERVER_UNAUTHENTICATED_GROUP="${instance-CC_UNAUTHENTICATED_GROUP}"

CC_GROUP="${instance-CRYPTO_CONNECT_USER_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"


/***********************************************************************/
/* Delete the STARTED task for this server                             */
/***********************************************************************/
Say "Deleting STARTED task for the server"
"RDELETE STARTED ${instance-CC_SERVER_STC_NAME}.*"

Say "Refreshing STARTED"
"SETROPTS RACLIST(STARTED) REFRESH"

#if($!{instance-CC_CREATE_TECHNICAL_USERIDS} == "true" ) 
/***********************************************************************/
/***********************************************************************/
/* Remove userids from profiles                                        */
/* this is only done if the userid had been genererated                */
/***********************************************************************/
/***********************************************************************/

/***********************************************************************/
/* Removing access to Db2 Naming protected access profiles */
/***********************************************************************/
Say "Removing access to RRSAF profile from" SERVER_STC_USER
"PERMIT ${instance-DB_JCC_SSID}.RRSAF CLASS(DSNR)",
   " DELETE ID("SERVER_STC_USER")"                 

Say "Refreshing DSNR"
"SETROPTS RACLIST(DSNR) REFRESH"

/***********************************************************************/
/* Delete access to APPL class profile                                 */
/***********************************************************************/

Say "Remove unauthenticated user" SERVER_UNAUTHENTICATED_USER "access",
   " to the profile in the APPL class"
"PERMIT" SAFPREFIX "CLASS(APPL)",
   " DELETE ID("SERVER_UNAUTHENTICATED_USER")"

#if(${instance-SAF_PROFILE_PREFIX} && ${instance-SAF_PROFILE_PREFIX} != "EKMFWEB")
/* if the SAF prefix is dynamic, the groups need to be removed. */
/* For APPL=EKMFWEB, keep the access for pre v3.1.0.2 compatibility */
Say "Deleting the server specific APPLID" SAFPREFIX "from RACF"
"RDELETE APPL" SAFPREFIX
#end

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"

/***********************************************************************/
/* Delete the security domain for server auth                          */
/***********************************************************************/
Say "Remove" SERVER_STC_USER "access from security domain for the server"
"PERMIT BBG.SECPFX."SAFPREFIX "CLASS(SERVER)",
   " DELETE ID("SERVER_STC_USER")"  

#if(${instance-SAF_PROFILE_PREFIX} && ${instance-SAF_PROFILE_PREFIX} != "EKMFWEB")
/* if the SAF prefix is dynamic, the groups need to be removed. */
/* For APPL=EKMFWEB, keep the access for pre v3.1.0.2 compatibility */
Say "Deleting security domain for the server"
"RDELETE SERVER BBG.SECPFX."SAFPREFIX
#end


/***********************************************************************/
/* Delete the servers access to the angel process                      */
/***********************************************************************/
Say "Removing the servers access to the angel process"
#if(${instance-WLP_ANGEL_NAME} && ${instance-WLP_ANGEL_NAME} != "")
"PERMIT BBG.ANGEL.${instance-WLP_ANGEL_NAME} CLASS(SERVER)",
   " DELETE ID("SERVER_STC_USER")"
#else
"PERMIT BBG.ANGEL CLASS(SERVER) DELETE ID("SERVER_STC_USER")"
#end
/***********************************************************************/
/* Remove the servers access to use the z/OS Authorized services       */
/***********************************************************************/

Say "Removing the server ids READ access to the authorized module BBGZSAFM"
"PERMIT BBG.AUTHMOD.BBGZSAFM CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the SAF authorized user registry services and SAF authorization services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.SAFCRED CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the SVCDUMP services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.ZOSDUMP CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the optimized local adapter authorized service"
"PERMIT BBG.AUTHMOD.BBGZSAFM.LOCALCOM CLASS(SERVER) DELETE ID("SERVER_STC_USER")"
"PERMIT BBG.AUTHMOD.BBGZSAFM.WOLA CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the authorized module BBGZSCFM"
"PERMIT BBG.AUTHMOD.BBGZSCFM CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the optimized local adapter authorized client service"
"PERMIT BBG.AUTHMOD.BBGZSCFM.WOLA CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the WLM services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.ZOSWLM CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the TXRRS services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.TXRRS CLASS(SERVER) DELETE ID("SERVER_STC_USER")"

Say "Removing the server ids READ access to the IFAUSAGE services (PRODMGR)"
"PERMIT BBG.AUTHMOD.BBGZSAFM.PRODMGR CLASS(SERVER) DELETE ID("SERVER_STC_USER")"    

Say "Refreshing SERVER"
"SETROPTS RACLIST(SERVER) GENERIC(SERVER) REFRESH"

/***********************************************************************/
/* SMF Logging */
/***********************************************************************/
Say "Removing access to BPX.SMF CLASS(FACILITY) from" SERVER_STC_GROUP
"PERMIT BPX.SMF CLASS(FACILITY) DELETE ID("SERVER_STC_GROUP") "

Say "Refreshing FACILITY"
"SETROPTS RACLIST(FACILITY) REFRESH"


/***********************************************************************/
/***********************************************************************/
#end

exit