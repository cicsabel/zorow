/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


SERVER_STC_USER="${instance-CC_SERVER_STC_USER}"
CA_LABEL="${instance-CC_CA_LABEL}"
/* Name of the server certificate */
TLS_KEY_STORE_SERVER_CERT="${instance-CC_TLS_KEY_STORE_SERVER_CERT}"
/* Name of the OpenID certificate */
OIDC_PROVIDER_CERT="${instance-CC_OIDC_PROVIDER_CERT}"
/* Name of the key ring */
TLS_KEY_STORE_KEY_RING="${instance-CC_TLS_KEY_STORE_KEY_RING}"
TLS_TRUST_STORE_KEY_RING="${instance-CC_TLS_TRUST_STORE_KEY_RING}"

/* Connect certificates to keyring */
Say "Connect TLS server  certificate to key ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(LABEL('"TLS_KEY_STORE_SERVER_CERT"')",
      " RING("TLS_KEY_STORE_KEY_RING")",
      " DEFAULT USAGE(PERSONAL))"
 if RC <> 0 then do
   Say "connecting server cert to key ring failed, exiting"
   exit RC
 end

  #if($!{instance-CC_TLS_KEY_STORE_SERVER_CERT} != $!{instance-CC_OIDC_PROVIDER_CERT} )
Say "Connect OIDC provider certificate to key ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(LABEL('"OIDC_PROVIDER_CERT"')",
   " RING("TLS_KEY_STORE_KEY_RING")",
   " USAGE(PERSONAL))"
 if RC <> 0 then do
   Say "connecting oidc cert to key ring failed, exiting"
   exit RC
 end
  #end

   #if($!{instance-CC_TLS_KEY_STORE_KEY_RING} != $!{instance-CC_TLS_TRUST_STORE_KEY_RING} )
Say "Connect OIDC provider certificate to trust ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(LABEL('"OIDC_PROVIDER_CERT"')",
   " RING("TLS_TRUST_STORE_KEY_RING")",
   " USAGE(PERSONAL))"
 if RC <> 0 then do
   Say "connecting oidc cert to trust ring failed, exiting"
   exit RC
 end
   #end

Say "Connect CA to trust ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('"CA_LABEL"')",
   " RING("TLS_TRUST_STORE_KEY_RING")",
   " USAGE(CERTAUTH))"
 if RC <> 0 then do
   Say "connecting CA to trust ring failed"
 end

Say "Refreshing DIGTRING"
"SETROPTS RACLIST(DIGTRING) REFRESH"

Say "List the key ring for diagnostics"
"RACDCERT ID("SERVER_STC_USER")",
   " LISTRING("TLS_KEY_STORE_KEY_RING")"
 if RC <> 0 then do
   Say "listing the key ring failed, exiting"
   exit RC
 end

#if($!{instance-CC_TLS_KEY_STORE_KEY_RING} != $!{instance-CC_TLS_TRUST_STORE_KEY_RING} )
Say "List the trust ring for diagnostics"
"RACDCERT ID("SERVER_STC_USER")",
   " LISTRING("TLS_TRUST_STORE_KEY_RING")"
 if RC <> 0 then do
   Say "listing the trust ring failed, exiting"
   exit RC
 end
#end
