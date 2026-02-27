/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SERVER_STC_USER="${instance-SERVER_STC_USER}"
TLS_TRUST_STORE_KEY_RING="${instance-SERVER_TLS_TRUST_STORE_KEY_RING}"

CA_LABEL="${instance-CLIENT_CA_LABEL}"

Say "remove client CA from server trust ring"
"RACDCERT ID("SERVER_STC_USER")",
   " REMOVE(CERTAUTH LABEL('"CA_LABEL"')",
   " RING("TLS_TRUST_STORE_KEY_RING"))"

Say "Refreshing DIGTRING"
"SETROPTS RACLIST(DIGTRING) REFRESH"
