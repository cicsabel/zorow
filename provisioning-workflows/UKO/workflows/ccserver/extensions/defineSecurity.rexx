/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/
/***********************************************************************/
/* Define dynamic security profiles for the server                     */
/***********************************************************************/

SERVER_STC_USER="${instance-CC_SERVER_STC_USER}"
SERVER_STC_GROUP="${instance-CC_SERVER_STC_GROUP}"

SERVER_UNAUTHENTICATED_USER="${instance-CC_UNAUTHENTICATED_USER}"
SERVER_UNAUTHENTICATED_GROUP="${instance-CC_UNAUTHENTICATED_GROUP}"

SERVER_STC_NAME="${instance-CC_SERVER_STC_NAME}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
SAF_OWNER="${instance-SAF_OWNER}"

/***********************************************************************/
/* Setup the STARTED task for this server                              */
/***********************************************************************/
Say "Defining STARTED task for the server"
"RDEF STARTED" SERVER_STC_NAME".*  OWNER("SAF_OWNER") UACC(NONE)",
   " STDATA(USER("SERVER_STC_USER") PRIVILEGED(NO) TRUSTED(NO) TRACE(YES))"

Say "Refreshing STARTED"
"SETROPTS RACLIST(STARTED) REFRESH"

/***********************************************************************/
/* Setup the APPL class profile                                        */
/***********************************************************************/
Say "Define the server specific APPLID to RACF"
"RDEFINE APPL" SAFPREFIX " OWNER("SAF_OWNER") UACC(NONE)"

Say "Activating the APPL class"
/* If not active, the domain is not restricted, which means anyone can authenticate to it */
"SETROPTS CLASSACT(APPL)"

Say "Grant an unauthenticated" SERVER_UNAUTHENTICATED_USER "user ID READ access to the profile in the APPL class"
"PERMIT" SAFPREFIX "CLASS(APPL) ACCESS(READ) ID("SERVER_UNAUTHENTICATED_USER")"

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"

/***********************************************************************/
/* Configure a security domain for server auth                         */
/***********************************************************************/

Say "Create the security domain for the server"
"RDEFINE SERVER BBG.SECPFX."SAFPREFIX " OWNER("SAF_OWNER") UACC(NONE)"

Say "Grant the servers id READ access to the security domain for the server"
"PERMIT BBG.SECPFX."SAFPREFIX "CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

/***********************************************************************/
/* Grant the server access to the angel process                        */
/***********************************************************************/

#if(${instance-WLP_ANGEL_NAME} && ${instance-WLP_ANGEL_NAME} != "")
Say "Define the class for the named angel process"
"RDEFINE SERVER BBG.ANGEL.${instance-WLP_ANGEL_NAME} ",
   " OWNER("SAF_OWNER") UACC(NONE)"
Say "Permitting the server access to the angel process"
"PERMIT BBG.ANGEL.${instance-WLP_ANGEL_NAME} CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"
#else
Say "Define the class for the default angel process"
"RDEFINE SERVER BBG.ANGEL  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permitting the server access to the angel process"
"PERMIT BBG.ANGEL CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"
#end

/***********************************************************************/
/* Grant the server access to use the z/OS Authorized services         */
/***********************************************************************/

Say "Create a SERVER profile for the authorized module BBGZSAFM"
"RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the authorized module BBGZSAFM"
"PERMIT BBG.AUTHMOD.BBGZSAFM CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create a profile for the SAF authorized user registry services and SAF authorization services"
"RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM.SAFCRED  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the SAF authorized user registry services and SAF authorization services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.SAFCRED CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create a profile for the SVCDUMP services"
"RDEFINE  SERVER BBG.AUTHMOD.BBGZSAFM.ZOSDUMP  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the SVCDUMP services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.ZOSDUMP CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create profiles for the optimized local adapter authorized service"
"RDEFINE  SERVER BBG.AUTHMOD.BBGZSAFM.LOCALCOM  OWNER("SAF_OWNER") UACC(NONE)"
"RDEFINE  SERVER BBG.AUTHMOD.BBGZSAFM.WOLA  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the optimized local adapter authorized service"
"PERMIT BBG.AUTHMOD.BBGZSAFM.LOCALCOM CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT BBG.AUTHMOD.BBGZSAFM.WOLA CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create a SERVER profile for the authorized module BBGZSCFM"
"RDEFINE SERVER BBG.AUTHMOD.BBGZSCFM  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the authorized module BBGZSCFM"
"PERMIT BBG.AUTHMOD.BBGZSCFM CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create profiles for the optimized local adapter authorized client service"
"RDEFINE  SERVER BBG.AUTHMOD.BBGZSCFM.WOLA  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the optimized local adapter authorized client service"
"PERMIT BBG.AUTHMOD.BBGZSCFM.WOLA CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create a profile for WLM services"
"RDEFINE  SERVER BBG.AUTHMOD.BBGZSAFM.ZOSWLM  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the WLM services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.ZOSWLM CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create a profile for the TXRRS services"
"RDEFINE  SERVER BBG.AUTHMOD.BBGZSAFM.TXRRS  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the TXRRS services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.TXRRS CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create a profile for the IFAUSAGE services (PRODMGR)"
"RDEFINE  SERVER BBG.AUTHMOD.BBGZSAFM.PRODMGR  OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the IFAUSAGE services (PRODMGR)"
"PERMIT BBG.AUTHMOD.BBGZSAFM.PRODMGR CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Create a profile for the ZOSAIO services"
"RDEFINE SERVER BBG.AUTHMOD.BBGZSAFM.ZOSAIO OWNER("SAF_OWNER") UACC(NONE)"
Say "Permit" SERVER_STC_USER "READ access to the ZOSAIO services"
"PERMIT BBG.AUTHMOD.BBGZSAFM.ZOSAIO CLASS(SERVER)",
   " ACCESS(READ) ID("SERVER_STC_USER")"

Say "Refreshing SERVER"
"SETROPTS RACLIST(SERVER) GENERIC(SERVER) REFRESH"

/***********************************************************************/
/* Granting access to Db2 Naming protected access profiles */
/***********************************************************************/
Say "Defining RRSAF profile in DSNR class"
"RDEFINE DSNR ${instance-DB_JCC_SSID}.RRSAF OWNER("SAF_OWNER") UACC(NONE)"
Say "Granting access to RRSAF profile to" SERVER_STC_USER
"PERMIT ${instance-DB_JCC_SSID}.RRSAF CLASS(DSNR)",
   " ACCESS(READ) ID("SERVER_STC_USER")"                 

Say "Refreshing DSNR"
"SETROPTS RACLIST(DSNR) REFRESH"

/***********************************************************************/
/* SMF Logging */
/***********************************************************************/

/* This is required only if smf logging is enabled */
Say "Creating BPX.SMF in the FACILITY class to enable SMF logging"
"RDEFINE FACILITY BPX.SMF OWNER("SAF_OWNER") UACC(NONE)" 
Say "Granting access to BPX.SMF CLASS(FACILITY) to" SERVER_STC_GROUP
"PERMIT BPX.SMF CLASS(FACILITY) ID("SERVER_STC_GROUP") ACCESS(READ)"

Say "Refreshing FACILITY"
"SETROPTS RACLIST(FACILITY) REFRESH"

exit