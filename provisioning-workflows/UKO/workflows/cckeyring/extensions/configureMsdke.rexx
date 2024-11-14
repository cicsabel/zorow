/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


/* This is an optional step with sample certificate names */
/* You will need to add those to the trust store if you want to */
/* connect to cloud keystores. */

/* exit 0 */

SERVER_STC_USER="${instance-CC_SERVER_STC_USER}"
TLS_TRUST_STORE_KEY_RING="${instance-CC_TLS_TRUST_STORE_KEY_RING}"
TLS_KEY_STORE_KEY_RING="${instance-CC_TLS_KEY_STORE_KEY_RING}"
MSDKE_RABBIT_CA="${instance-MSDKE_RABBIT_CA}"
MSDKE_RABBIT_CERT="${instance-MSDKE_RABBIT_CERT}"

/* Add CA to trust ring */
Say "Connect RABBIT CA to trust ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('"MSDKE_RABBIT_CA"')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"
if RC <> 0 then do
   Say "connecting rabbitMQ CA to trust ring failed, exiting"
   exit RC
end

/* Connect certificate to keyring */
Say "Connect rabbitMQ Certificate to key ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(SITE LABEL('"MSDKE_RABBIT_CERT"')",
      " RING("TLS_KEY_STORE_KEY_RING")",
      " USAGE(PERSONAL))"
if RC <> 0 then do
   Say "connecting rabbitMQ cert to key ring failed, exiting"
   exit RC
end

#if($!{instance-CC_TLS_KEY_STORE_KEY_RING} != $!{instance-CC_TLS_TRUST_STORE_KEY_RING} )
/* Connect certificate to trust ring */
Say "Connect rabbitMQ provider certificate to trust ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(LABEL('"MSDKE_RABBIT_CERT"')",
   " RING("TLS_TRUST_STORE_KEY_RING")",
   " USAGE(PERSONAL))"
 if RC <> 0 then do
   Say "connecting rabbitMQ cert to trust ring failed, exiting"
   exit RC
 end
#end

Say "Refresh DIGTRING in RACF"
"SETROPTS RACLIST(DIGTRING) REFRESH"

Say "Grant CONTROL access to" SERVER_STC_USER "in RDATALIB"
"PERMIT",
   SERVER_STC_USER"."TLS_KEY_STORE_KEY_RING".LST",
   " CLASS(RDATALIB)",
   " ACCESS(CONTROL) ID("SERVER_STC_USER")"
Say "Refresh RDATALIB"
"SETROPTS RACLIST(RDATALIB) REFRESH"

Say "List the final keyring"
"RACDCERT ID("SERVER_STC_USER")",
   " LISTRING("TLS_KEY_STORE_KEY_RING")"

#if($!{instance-CC_TLS_KEY_STORE_KEY_RING} != $!{instance-CC_TLS_TRUST_STORE_KEY_RING} )
/* Connect certificate to trust ring */
Say "List the final trust keyring"
"RACDCERT ID("SERVER_STC_USER")",
   " LISTRING("TLS_TRUST_STORE_KEY_RING")"
#end