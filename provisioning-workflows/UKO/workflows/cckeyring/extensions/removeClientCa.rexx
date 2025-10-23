/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


CA_LABEL="${instance-CLIENT_CA_LABEL}"

/* Create a certificate authority (CA) certificate, */
/* which will be used to sign the client certificate. */

Say "Deleting CA with label" CA_LABEL
"RACDCERT CERTAUTH DELETE",
    " (LABEL('"CA_LABEL"'))"

Say "Refreshing DIGTCERT"
"SETROPTS RACLIST(DIGTCERT) REFRESH"
