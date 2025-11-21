/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

SERVER_CA_LABEL="${instance-SERVER_CA_LABEL}"
CERT_LABEL="${instance-CLIENT_CERT_LABEL}"
CLIENT_USER="${instance-GENERIC_CLIENT_USER}"
EXPORT_HLQ="${instance-EXPORT_HLQ}"

PASSWORD="${instance-EXPORT_PASSWORD}"

/* Export the client certificate to a PKCS #12 file */
/* by entering the following command: */
Say "Exporting client certificate "CERT_LABEL
Say "to "EXPORT_HLQ"."CLIENT_USER
"RACDCERT ID("CLIENT_USER") EXPORT(LABEL('"CERT_LABEL"'))",
    "PASSWORD('"PASSWORD"')",
    "DSN('"EXPORT_HLQ"."CLIENT_USER"')"

Say "Exporting server certificate "SERVER_CA_LABEL 
Say "to "EXPORT_HLQ"."CLIENT_USER".SERVERCA"
"RACDCERT CERTAUTH EXPORT(LABEL('"SERVER_CA_LABEL"'))",
    "DSN('"EXPORT_HLQ"."CLIENT_USER".SERVERCA')"

"SETROPTS RACLIST(DIGTCERT) REFRESH"
"SETROPTS RACLIST(DIGTRING) REFRESH"