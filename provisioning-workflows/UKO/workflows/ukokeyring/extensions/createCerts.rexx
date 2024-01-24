/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

SERVER_STC_USER="${instance-UKO_SERVER_STC_USER}"
CA_LABEL="${instance-UKO_CA_LABEL}"
/* Name of the server certificate */
TLS_KEY_STORE_SERVER_CERT="${instance-UKO_TLS_KEY_STORE_SERVER_CERT}"
/* Name of the OpenID certificate */
OIDC_PROVIDER_CERT="${instance-UKO_OIDC_PROVIDER_CERT}"

TLS_CN="${instance-UKO_TLS_KEY_STORE_SERVER_CERT_CN}"
TLS_OU="${instance-UKO_TLS_KEY_STORE_SERVER_CERT_OU}"
TLS_O="${instance-UKO_TLS_KEY_STORE_SERVER_CERT_O}"

Say "Generate a server certificate"
Say "Define "||TLS_KEY_STORE_SERVER_CERT||" for "||SERVER_STC_USER||" with CA "||CA_LABEL||" "

"RACDCERT ID("||SERVER_STC_USER||") GENCERT",
   " SUBJECTSDN(CN("||"'"||TLS_CN||"'"||")",
      " OU("||"'"||TLS_OU||"'"||")",
      " O("||"'"||TLS_O||"'"||"))",
   " WITHLABEL("||"'"||TLS_KEY_STORE_SERVER_CERT||"'"||")", 
   " SIGNWITH(CERTAUTH LABEL("||"'"||CA_LABEL||"'"||"))",
   " NOTAFTER(DATE(2025-12-31) TIME(23:59:59))",
   " RSA SIZE(2048)"
 if RC <> 0 then do
   Say "creating server certificate failed, exiting"
   exit RC
 end

#if($!{instance-UKO_TLS_KEY_STORE_SERVER_CERT} != $!{instance-UKO_OIDC_PROVIDER_CERT} )
Say "Generate an OIDC certificate"
Say "Define "||OIDC_PROVIDER_CERT||" for "||SERVER_STC_USER||" with CA "||CA_LABEL||" "
"RACDCERT ID("||SERVER_STC_USER||") GENCERT",
   " SUBJECTSDN(CN("||"'"||TLS_CN||"'"||")",
      " OU("||"'"||TLS_OU||"'"||")",
      " O("||"'"||TLS_O||"'"||"))",
   " WITHLABEL("||"'"||OIDC_PROVIDER_CERT||"'"||")", 
   " SIGNWITH(CERTAUTH LABEL("||"'"||CA_LABEL||"'"||"))",
   " NOTAFTER(DATE(2025-12-31) TIME(23:59:59))",
   " RSA SIZE(2048)"
 if RC <> 0 then do
   Say "creating oidc certificate failed, exiting"
   exit RC
 end
#end

Say "Refresh DIGTCERT"
"SETROPTS RACLIST(DIGTCERT) REFRESH"
