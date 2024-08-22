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

SERVER_STC_USER="${instance-UKO_SERVER_STC_USER}"
TLS_TRUST_STORE_KEY_RING="${instance-UKO_TLS_TRUST_STORE_KEY_RING}"

/* ********************************************** */
/* keyring section start                          */
/* ********************************************** */
/* Connect certificates to keyring */

Say "Connect certificates to trust ring"
Say "Connect GoogleTrustCert"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('GTS Root R1 GlobalSigned')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"

Say "Connect GoogleTrustCert"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('GlobalSign Root CA for GTS')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"

Say "Connect IBMDigiCertGlobalRootCA"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('IBMDigiCertGlobalRootCA')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"

Say "Connect IBMDigiCertGlobalRootG2"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('IBMDigiCertGlobalRootG2')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"

Say "Connect DIGICERT-ROOT-CA"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('DIGICERT-ROOT-CA')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"
Say "Connect DIGICERT-SHA2-SECURE-SERVER-CA"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('DIGICERT-SHA2-SECURE-SERVER-CA')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"

/* Azure Certificates */                               
Say "Connect AZURE-BALTCTRT"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('AZURE-BALTCTRT')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"
Say "Connect AZURE-DCGLBRG2"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('AZURE-DCGLBRG2')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"
Say "Connect AZURE-DTRTC3CA"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('AZURE-DTRTC3CA')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"
Say "Connect AZURE-MSECCRCA"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('AZURE-MSECCRCA')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"
Say "Connect AZURE-MSRSARCA"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(CERTAUTH LABEL('AZURE-MSRSARCA')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"

Say "Connect WINMVS3N Db2 Site certificate"
"RACDCERT ID("SERVER_STC_USER")",
   " CONNECT(SITE LABEL('WINMVS3N')",
      " RING("TLS_TRUST_STORE_KEY_RING")",
      " USAGE(CERTAUTH))"

Say "Connect ISRG Root X1"
"RACDCERT ID("||SERVER_STC_USER||")",
   " CONNECT(CERTAUTH LABEL('ISRG Root X1')",
      " RING("||TLS_TRUST_STORE_KEY_RING||")",
      " USAGE(CERTAUTH))"

Say "Connect E5 LETS ENCRYPT"
"RACDCERT ID("||SERVER_STC_USER||")",
   " CONNECT(CERTAUTH LABEL('E5 LETS ENCRYPT')",
      " RING("||TLS_TRUST_STORE_KEY_RING||")",
      " USAGE(CERTAUTH))"

Say "Refresh DIGTRING in RACF"
"SETROPTS RACLIST(DIGTRING) REFRESH"

Say "List the final trust keyring"
"RACDCERT ID("SERVER_STC_USER")",
   " LISTRING("TLS_TRUST_STORE_KEY_RING")"
