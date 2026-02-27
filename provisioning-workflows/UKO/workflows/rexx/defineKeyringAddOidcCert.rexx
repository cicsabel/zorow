/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


SERVER_STC_USER="${instance-SERVER_STC_USER}"
/* Name of the OpenID certificate */
OIDC_PROVIDER_CERT="${instance-SERVER_OIDC_PROVIDER_CERT}"
/* Name of the key ring */
TLS_KEY_STORE_KEY_RING="${instance-SERVER_TLS_KEY_STORE_KEY_RING}"

/* Connect OIDC certificate to keyring */
/* The OIDC signing certificate contains a private key and should */
/* only be added to the key ring, not the trust ring */
Say "Connect OIDC provider certificate to key ring"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(LABEL('"OIDC_PROVIDER_CERT"')",
   " RING("TLS_KEY_STORE_KEY_RING")",
   " USAGE(PERSONAL))"
 if RC <> 0 then do
   Say "connecting oidc cert to key ring failed, exiting"
   exit RC
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