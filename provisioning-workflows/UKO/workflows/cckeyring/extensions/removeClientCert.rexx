/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CA_LABEL="${instance-CLIENT_CA_LABEL}"

CLIENT_USER="${instance-GENERIC_CLIENT_USER}"
CERT_LABEL="${instance-CLIENT_CERT_LABEL}"


/* Create a client certificate, signed with the CA certificate */

Say "Deleting certificate with label" CERT_LABEL
"RACDCERT ID("CLIENT_USER") DELETE",
    " (LABEL('"CERT_LABEL"'))"
 if RC <> 0 then do
   Say "Deleting client certificate failed, exiting"
   exit RC
 end

Say "Refreshing DIGTCERT"
"SETROPTS RACLIST(DIGTCERT) REFRESH"

