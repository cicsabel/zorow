/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

/* ********************************************** */
/* keyring creation section                       */
/* ********************************************** */

SERVER_STC_USER="${instance-UKO_SERVER_STC_USER}"
TLS_KEY_STORE_KEY_RING="${instance-UKO_TLS_KEY_STORE_KEY_RING}"
TLS_TRUST_STORE_KEY_RING="${instance-UKO_TLS_TRUST_STORE_KEY_RING}"

"SETROPTS CLASSACT(DIGTRING)"

Say "Generate the key ring"
"RACDCERT ADDRING("TLS_KEY_STORE_KEY_RING")",
   " ID("SERVER_STC_USER")"
 if RC <> 0 then do
   Say "key ring creation failed, exiting"
   exit RC
 end

#if($!{instance-UKO_TLS_KEY_STORE_KEY_RING} != $!{instance-UKO_TLS_TRUST_STORE_KEY_RING} )
Say "Generate the trust ring"
"RACDCERT ADDRING("TLS_TRUST_STORE_KEY_RING")",
   " ID("SERVER_STC_USER")"
 if RC <> 0 then do
   Say "trust ring creation failed, exiting"
   exit RC
 end
#end

"SETROPTS RACLIST(DIGTRING) REFRESH"
