/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SERVER_STC_USER="${instance-CC_SERVER_STC_USER}"
TLS_KEY_STORE_KEY_RING="${instance-CC_TLS_KEY_STORE_KEY_RING}"
TLS_TRUST_STORE_KEY_RING="${instance-CC_TLS_TRUST_STORE_KEY_RING}"
SAF_OWNER="${instance-SAF_OWNER}"

Say "RDATALIB definitions: "
/* Enable the Liberty user to use the key ring */
Say "Define" SERVER_STC_USER"."TLS_KEY_STORE_KEY_RING
"RDEFINE RDATALIB",
   SERVER_STC_USER"."TLS_KEY_STORE_KEY_RING".LST",
   " UACC(NONE) OWNER("SAF_OWNER") "

#if($!{instance-CC_CREATE_KEYRING} == "true" && $!{instance-CC_CREATE_CERTIFICATES} == "false")
/* if existing certificates are added to the new key ring, then CONTROL is required */
/* to be able to access the private keys */
Say "Grant CONTROL access to" SERVER_STC_USER "in RDATALIB"
"PERMIT",
   SERVER_STC_USER"."TLS_KEY_STORE_KEY_RING".LST",
   " CLASS(RDATALIB)",
   " ACCESS(CONTROL) ID("SERVER_STC_USER")"
#else
Say "Grant READ access to" SERVER_STC_USER "in RDATALIB"
"PERMIT",
   SERVER_STC_USER"."TLS_KEY_STORE_KEY_RING".LST",
   " CLASS(RDATALIB)",
   " ACCESS(READ) ID("SERVER_STC_USER")"
#end
if RC <> 0 then do
   Say "Granting access in RDATALIB failed"
   exit RC
end

#if($!{instance-CC_TLS_KEY_STORE_KEY_RING} != $!{instance-CC_TLS_TRUST_STORE_KEY_RING} )
Say "Define" SERVER_STC_USER"."TLS_TRUST_STORE_KEY_RING
"RDEFINE RDATALIB",
   SERVER_STC_USER"."TLS_TRUST_STORE_KEY_RING".LST",
   " UACC(NONE) OWNER("SAF_OWNER") "
Say "Grant access to" SERVER_STC_USER
"PERMIT",
   SERVER_STC_USER"."TLS_TRUST_STORE_KEY_RING".LST",
   " CLASS(RDATALIB)",
   " ACCESS(READ) ID("SERVER_STC_USER")"
if RC <> 0 then do
   Say "Granting access in RDATALIB failed"
   exit RC
end
#end

Say "Refresh RDATALIB"
"SETROPTS RACLIST(RDATALIB) REFRESH"

/***********************************************************************/
/*                                                                     */
/* PLEASE READ                                                         */
/*                                                                     */
/* It is recommended to use the RDATALIB class,                        */
/* however if it is not active then instead access to the              */
/* IRR.DIGTCERT.LISTRING FACILITY resource can be used                 */
/*                                                                     */
/* By default this script will stop her, as there is an 'exit 0'       */
/* statement directly under this comment.  Review the example, remove  */
/* the RDATALIB definitions and the 'exit 0' to use FACILITY instead   */
/*                                                                     */
/***********************************************************************/

exit 0


Say "Define IRR.DIGTCERT.LISTRING in FACILITY"
"RDEFINE FACILITY IRR.DIGTCERT.LISTRING UACC(NONE)"

Say "Grant access to" SERVER_STC_USER
"PERMIT IRR.DIGTCERT.LISTRING CLASS(FACILITY) ACCESS(READ)",
   " ID("SERVER_STC_USER")"

if RC <> 0 then do
   Say "Granting access in FACILITY failed"
   exit RC
end

Say "Refresh FACILITY"
"SETROPTS RACLIST(FACILITY) REFRESH"
