/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

SERVER_STC_USER="${instance-SERVER_STC_USER}"
SERVER_STC_GROUP="${instance-SERVER_STC_GROUP}"
SERVER_STC_NAME="${instance-SERVER_STC_NAME}"
SAF_OWNER="${instance-SAF_OWNER}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"
TLS_KEY_STORE_KEY_RING="${instance-SERVER_TLS_KEY_STORE_KEY_RING}"
#if(${instance-SERVER_TLS_KEY_STORE_OWNER} && ${instance-SERVER_TLS_KEY_STORE_OWNER} != "")
TLS_KEY_STORE_OWNER="${instance-SERVER_TLS_KEY_STORE_OWNER}"
#else
TLS_KEY_STORE_OWNER="${instance-SERVER_STC_USER}"
#end


/*******************************************************************/
/* Setup the STARTED task for this server                          */
/*******************************************************************/

Say "Deleting STARTED task for the server"
"RDEL STARTED "SERVER_STC_NAME".* "

Say "Refreshing STARTED"
"SETROPTS RACLIST(STARTED) REFRESH"

/*******************************************************************/
/* CSFSERV                          */
/*******************************************************************/

Say "Deleting CSFSERV Access"
"PERMIT  CSFCKM  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFCVE  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFENC  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFDEC  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFDSG  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFDSV  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFIQF  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFKDSL CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFKDMR CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKD  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKE  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKI  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKG  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKRC CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFKET  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFKRC  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFRKD  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFOWH  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFKGN  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFKRD  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFKYT  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPCI  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKRD CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKTC CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFPKX  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFRKL  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
/* IA: Do we need both, RNG and RNGL? todo: test removing the other*/
/* after server start I get a RNGL message undocumented */
"PERMIT  CSFRNG  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFRNGL CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFSYI  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"
"PERMIT  CSFSYX  CLASS(CSFSERV) DELETE ID("SERVER_STC_USER")"

Say "Refreshing CSFSERV"
"SETROPTS RACLIST(CSFSERV) REFRESH"


/* Allow task access to ACSP svc */
Say "Removing server access to SVCs"
"PERMIT ACSP.SVC CLASS(XFACILIT) DELETE ID("SERVER_STC_USER")"
Say "Refreshing XFACILIT"
"SETROPTS RACLIST(XFACILIT) REFRESH"

/* RACF key ring access:                                      */
/*                                                            */
/* Edit commands to use either RDATALIB or                    */
/* IRR.DIGTCERT profiles in the FACILITY class                */
/*                                                            */
/* Use following if RDATALIB class is ACTIVE in RACF          */
/* Otherwise remove and "PERMIT the IRR.DIGTCERT resources     */


Say "RDATALIB definitions: "

/* Keyring access must be given if RDATALIB class is activated. */
/* The values correspond to acsp.server.properties: */
/*    ssl.keyring.user */
/*    ssl.keyring.name */

Say "Remove access from" SERVER_STC_USER "in RDATALIB"
"PERMIT",
   TLS_KEY_STORE_OWNER"."TLS_KEY_STORE_KEY_RING".LST",
   " CLASS(RDATALIB)",
   " DELETE ID("SERVER_STC_USER")"

Say "Refresh RDATALIB"
"SETROPTS RACLIST(RDATALIB) REFRESH"

/*                                                            */
/* PERMIT ACSP server to IRR.DIGTCERT resources               */
/* (Remove if RDATALIB is used)                               */
/*                                                            */

/* "RDEF FACILITY (IRR.DIGTCERT.LISTRING) UACC(NONE) OWNER("SAF_OWNER") " */
/* "RDEF FACILITY (IRR.DIGTCERT.LIST)     UACC(NONE) OWNER("SAF_OWNER") " */

/* "PERMIT IRR.DIGTCERT.LISTRING CLASS(FACILITY) DELETE " , */
/*   " ID("SERVER_STC_USER")"*/
/*"PERMIT IRR.DIGTCERT.LIST    CLASS(FACILITY) DELETE " ,*/
/*   " ID("SERVER_STC_USER")"*/

/* required for the internal search of RACF resource profiles */
/* like the ACSP Server command authorization and key label prefix */
Say "Remove "SERVER_STC_USER" access to search RACF resource profiles "
"PERMIT IRR.RADMIN.RLIST CLASS(FACILITY) DELETE ID("SERVER_STC_USER")"

Say "Refresh FACILITY"
"SETROPTS RACLIST(FACILITY) REFRESH"

/* define application id for ACSP, default is ACSPPROD */
/* must match auth.map.applid in server properties */
/* Server ID needs access if no user mapping is done */
Say "Remove access of "SERVER_STC_USER" to APPL"
"PERMIT "SAFPREFIX" CLASS(APPL) DELETE ID("SERVER_STC_USER")"

#if(${instance-SAF_PROFILE_PREFIX} && ${instance-SAF_PROFILE_PREFIX} != "ACSPPROD")
/* if the SAF prefix is dynamic, the groups need to be removed. */
Say "Deleting the server specific APPLID" SAFPREFIX "from RACF"
"RDELETE APPL" SAFPREFIX
#end

Say "Refresh APPL"
"SETROPTS RACLIST(APPL) REFRESH"


/*******************************************************************/
/* PROGRAM CONTROL                          */
/*******************************************************************/
/* Edit below sample commands if SETROPTS WHEN(PROGRAM) is used  */
/* If the RACF program control is active, SETROPTS WHEN(PROGRAM), */
/* then the modules used in the ACSP server need to be */
/* defined in the PROGRAM class. */

Say "Remove access to ** profile from" SERVER_STC_USER
"PERMIT ** CLASS(PROGRAM) DELETE ID("SERVER_STC_USER")"
Say "Do a WHEN(PROGRAM) REFRESH"
"SETR WHEN(PROGRAM) REFRESH"


Say "Removing access to the operator commands from the server"
"PERMIT ACSP.COMMAND.CRYPTO   CLASS(XFACILIT) DELETE ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.DISPLAY  CLASS(XFACILIT) DELETE ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.SET      CLASS(XFACILIT) DELETE ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.START    CLASS(XFACILIT) DELETE ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.STOP     CLASS(XFACILIT) DELETE ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.SHUTDOWN CLASS(XFACILIT) DELETE ID("SERVER_STC_USER")" 

/* REFRESH" */
Say "Refreshing XFACILIT"
"SETROPTS RACLIST(XFACILIT) REFRESH"


/* If ICSF keystore policy checking is active and the  */
/* CSF.PKDS.TOKEN.CHECK.DEFAULT.LABEL resource in XFACILIT class is  */
/* defined, the CSF-PKDS-DEFAULT resource in CSFKEYS class must also  */
/* be defined and the Server's <task-user> needs access.*/
Say "Removing access to server for keystore checking"
"PERMIT CSF-PKDS-DEFAULT CLASS(CSFKEYS) DELETE ID("SERVER_STC_USER")"

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"
