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

Say "Defining STARTED task for the server"
"RDEF STARTED "SERVER_STC_NAME".* UACC(NONE) OWNER("SAF_OWNER") " ,
   " STDATA(USER("SERVER_STC_USER") PRIVILEGED(NO) TRUSTED(NO) TRACE(YES))"

Say "Refreshing STARTED"
"SETROPTS RACLIST(STARTED) REFRESH"

/*******************************************************************/
/* CSFSERV                          */
/*******************************************************************/

Say "Defining CSFSERV Access"
"PERMIT  CSFCKM  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFCVE  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFENC  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFDEC  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFDSG  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFDSV  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFIQF  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFKDSL CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFKDMR CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKD  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKE  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKI  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKG  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKRC CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFKET  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFKRC  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFRKD  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFOWH  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFKGN  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFKRD  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFKYT  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPCI  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKRD CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKTC CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFPKX  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFRKL  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
/* IA: Do we need both, RNG and RNGL? todo: test removing the other*/
/* after server start I get a RNGL message undocumented */
"PERMIT  CSFRNG  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFRNGL CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFSYI  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"
"PERMIT  CSFSYX  CLASS(CSFSERV) ACCESS(READ) ID("SERVER_STC_USER")"

Say "Refreshing CSFSERV"
"SETROPTS RACLIST(CSFSERV) REFRESH"


/* Allow task access to ACSP svc */
Say "allowing server access to SVCs"
"RDEF XFACILIT (ACSP.SVC) UACC(READ) OWNER("SAF_OWNER") "
"PERMIT ACSP.SVC CLASS(XFACILIT) ACC(READ) ID("SERVER_STC_USER")"
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

Say "Define" TLS_KEY_STORE_OWNER"."TLS_KEY_STORE_KEY_RING
"RDEFINE RDATALIB",
   TLS_KEY_STORE_OWNER"."TLS_KEY_STORE_KEY_RING".LST",
   " UACC(NONE) OWNER("SAF_OWNER") "

Say "Grant CONTROL access to" SERVER_STC_USER "in RDATALIB"
"PERMIT",
   TLS_KEY_STORE_OWNER"."TLS_KEY_STORE_KEY_RING".LST",
   " CLASS(RDATALIB)",
   " ACCESS(CONTROL) ID("SERVER_STC_USER")"

Say "Refresh RDATALIB"
"SETROPTS RACLIST(RDATALIB) REFRESH"

/*                                                            */
/* PERMIT ACSP server to IRR.DIGTCERT resources               */
/* (Remove if RDATALIB is used)                               */
/*                                                            */

/* "RDEF FACILITY (IRR.DIGTCERT.LISTRING) UACC(NONE) OWNER("SAF_OWNER") " */
/* "RDEF FACILITY (IRR.DIGTCERT.LIST)     UACC(NONE) OWNER("SAF_OWNER") " */

/* "PERMIT IRR.DIGTCERT.LISTRING CLASS(FACILITY) ACCESS(READ) " , */
/*   " ID("SERVER_STC_USER")"*/
/*"PERMIT IRR.DIGTCERT.LIST    CLASS(FACILITY) ACCESS(READ) " ,*/
/*   " ID("SERVER_STC_USER")"*/

/* required for the internal search of RACF resource profiles */
/* like the ACSP Server command authorization and key label prefix */
Say "Allow "SERVER_STC_USER" to search RACF resource profiles "
"PERMIT IRR.RADMIN.RLIST CLASS(FACILITY) ACC(READ) ID("SERVER_STC_USER")"

Say "Refresh FACILITY"
"SETROPTS RACLIST(FACILITY) REFRESH"

/* define application id for ACSP, default is ACSPPROD */
/* must match auth.map.applid in server properties */
/* Server ID needs access if no user mapping is done */
Say "Define APPL profile called" SAFPREFIX
"RDEF APPL "SAFPREFIX" UACC(NONE) OWNER("SAF_OWNER") "
Say "Grant access to "SERVER_STC_USER" if no user is mapped"
"PERMIT "SAFPREFIX" CLASS(APPL) ACCESS(READ) ID("SERVER_STC_USER")"
Say "Refresh APPL"
"SETROPTS RACLIST(APPL) REFRESH"


/*******************************************************************/
/* PROGRAM CONTROL                          */
/*******************************************************************/
/* Edit below sample commands if SETROPTS WHEN(PROGRAM) is used  */
/* If the RACF program control is active, SETROPTS WHEN(PROGRAM), */
/* then the modules used in the ACSP server need to be */
/* defined in the PROGRAM class. */

Say "Add members to PROGRAM class"
"RALTER PROGRAM ** ADDMEM('SYS1.SIEALNKE'//NOPADCHK)"
"RALTER PROGRAM ** ADDMEM('CEE.SCEERUN'//NOPADCHK)"
"RALTER PROGRAM ** ADDMEM('CEE.SCEERUN2'//NOPADCHK)"
"RALTER PROGRAM ** ADDMEM('SYS1.CSSLIB'//NOPADCHK)"
Say "Grant access to ** profile to" SERVER_STC_USER
"PERMIT ** CLASS(PROGRAM) ACC(READ) ID("SERVER_STC_USER")"
Say "Do a WHEN(PROGRAM) REFRESH"
"SETR WHEN(PROGRAM) REFRESH"

/* ACSP commands resources */
Say "Defining ACSP command resources"
"RDEF XFACILIT ACSP.COMMAND.CRYPTO   UACC(NONE) OWNER("SAF_OWNER") "
"RDEF XFACILIT ACSP.COMMAND.DISPLAY  UACC(NONE) OWNER("SAF_OWNER") "
"RDEF XFACILIT ACSP.COMMAND.SET      UACC(NONE) OWNER("SAF_OWNER") "
"RDEF XFACILIT ACSP.COMMAND.STATUS   UACC(READ) OWNER("SAF_OWNER") "
"RDEF XFACILIT ACSP.COMMAND.START    UACC(NONE) OWNER("SAF_OWNER") "
"RDEF XFACILIT ACSP.COMMAND.STOP     UACC(NONE) OWNER("SAF_OWNER") "
"RDEF XFACILIT ACSP.COMMAND.SHUTDOWN UACC(NONE) OWNER("SAF_OWNER") "

/* The ACSP server needs access to the command resoruces */
/* When a /F console command is executed, the server id is checked */
Say "Granting access to the operator commands to the server"
"PERMIT ACSP.COMMAND.CRYPTO   CLASS(XFACILIT) ACC(READ) ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.DISPLAY  CLASS(XFACILIT) ACC(READ) ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.SET      CLASS(XFACILIT) ACC(READ) ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.START    CLASS(XFACILIT) ACC(READ) ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.STOP     CLASS(XFACILIT) ACC(READ) ID("SERVER_STC_USER")" 
"PERMIT ACSP.COMMAND.SHUTDOWN CLASS(XFACILIT) ACC(READ) ID("SERVER_STC_USER")" 

/* REFRESH" */
Say "Refreshing XFACILIT"
"SETROPTS RACLIST(XFACILIT) REFRESH"


/* If ICSF keystore policy checking is active and the  */
/* CSF.PKDS.TOKEN.CHECK.DEFAULT.LABEL resource in XFACILIT class is  */
/* defined, the CSF-PKDS-DEFAULT resource in CSFKEYS class must also  */
/* be defined and the Server's <task-user> needs access.*/
Say "Defining keystore checking profiles CSF-PKDS-DEFAULT"
"RDEF CSFKEYS CSF-PKDS-DEFAULT UACC(NONE) OWNER("SAF_OWNER") "
Say "Defining keystore checking profiles CSF-CKDS-DEFAULT"
"RDEF CSFKEYS CSF-CKDS-DEFAULT UACC(NONE) OWNER("SAF_OWNER") "
Say "Granting access to server for PKDS keystore checking for RACF keyrings"
"PERMIT CSF-PKDS-DEFAULT CLASS(CSFKEYS) ACCESS(READ) ID("SERVER_STC_USER")"

Say "Refreshing CSFKEYS"
"SETROPTS RACLIST(CSFKEYS) REFRESH"
