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
"RACDCERT ADDRING("||TLS_KEY_STORE_KEY_RING||")",
   " ID("||SERVER_STC_USER||")"
 if RC <> 0 then do
   Say "key ring creation failed, exiting"
   exit RC
 end

#if($!{instance-UKO_TLS_KEY_STORE_KEY_RING} != $!{instance-UKO_TLS_TRUST_STORE_KEY_RING} )
Say "Generate the trust ring"
"RACDCERT ADDRING("||TLS_TRUST_STORE_KEY_RING||")",
   " ID("||SERVER_STC_USER||")"
 if RC <> 0 then do
   Say "trust ring creation failed, exiting"
   exit RC
 end
#end

"SETROPTS RACLIST(DIGTRING) REFRESH"
/* ********************************************** */
/* keyring access section                         */
/* ********************************************** */
Say "RDATALIB definitions: "
/* Enable the Liberty user to use the key ring */
Say "Define "||SERVER_STC_USER||"."||TLS_KEY_STORE_KEY_RING||" "
"RDEFINE RDATALIB",
   " "||SERVER_STC_USER||"."||TLS_KEY_STORE_KEY_RING||".LST",
   " UACC(NONE)"

#if($!{instance-UKO_CREATE_KEYRING} == "true" && $!{instance-UKO_CREATE_CERTIFICATES} == "false")
/* if existing certificates are added to the new key ring, then ALTER is required */
/* to be able to access the private keys */
Say "Grant ALTER access to "||SERVER_STC_USER||" in RDATALIB"
"PERMIT",
   " "||SERVER_STC_USER||"."||TLS_KEY_STORE_KEY_RING||".LST",
   " CLASS(RDATALIB)",
   " ACCESS(ALTER) ID("||SERVER_STC_USER||")"
#else
Say "Grant READ access to "||SERVER_STC_USER||" in RDATALIB"
"PERMIT",
   " "||SERVER_STC_USER||"."||TLS_KEY_STORE_KEY_RING||".LST",
   " CLASS(RDATALIB)",
   " ACCESS(READ) ID("||SERVER_STC_USER||")"
#end


#if($!{instance-UKO_TLS_KEY_STORE_KEY_RING} != $!{instance-UKO_TLS_TRUST_STORE_KEY_RING} )
Say "Define "||SERVER_STC_USER||"."||TLS_TRUST_STORE_KEY_RING||" "
"RDEFINE RDATALIB",
   " "||SERVER_STC_USER||"."||TLS_TRUST_STORE_KEY_RING||".LST",
   " UACC(NONE)"

Say "Grant access to "||SERVER_STC_USER||" "
"PERMIT",
   " "||SERVER_STC_USER||"."||TLS_TRUST_STORE_KEY_RING||".LST",
   " CLASS(RDATALIB)",
   " ACCESS(READ) ID("||SERVER_STC_USER||")"
#end

Say "Refresh RDATALIB"
"SETROPTS RACLIST(RDATALIB) REFRESH"

/* It is recommended to use the RDATALIB class, */
/* however if it is not active then instead access to the */
/* IRR.DIGTCERT.LISTRING FACILITY resource can be used */

Say "Define IRR.DIGTCERT.LISTRING in FACILITY"
"RDEFINE FACILITY IRR.DIGTCERT.LISTRING UACC(NONE)"

Say "Grant access to "||SERVER_STC_USER||" "
"PERMIT IRR.DIGTCERT.LISTRING CLASS(FACILITY) ACCESS(READ)",
   " ID("||SERVER_STC_USER||")"

Say "Refresh FACILITY"
"SETROPTS RACLIST(FACILITY) REFRESH"
