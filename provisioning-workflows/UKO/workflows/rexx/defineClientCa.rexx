/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


CA_LABEL="${instance-CLIENT_CA_LABEL}"
CA_CN="${instance-CLIENT_CA_CN}"
CA_OU="${instance-CLIENT_CA_OU}"
CA_O="${instance-CLIENT_CA_O}"

/* Create a certificate authority (CA) certificate, */
/* which will be used to sign the client certificate. */
say "CA cert not found, creating..."
"RACDCERT GENCERT",
   "CERTAUTH",
   "SUBJECTSDN(CN('"CA_CN"')",
   "O('"CA_O"')",
   "OU('"CA_OU"'))",
   "SIZE(2048)",
   "WITHLABEL('"CA_LABEL"')"

Say "Refreshing DIGTCERT"
"SETROPTS RACLIST(DIGTCERT) REFRESH"
