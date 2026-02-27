/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

CA_LABEL="${instance-CLIENT_CA_LABEL}"

CLIENT_USER="${instance-GENERIC_CLIENT_USER}"
CERT_LABEL="${instance-CLIENT_CERT_LABEL}"
CERT_CN="${instance-CLIENT_CERT_CN}"
CERT_OU="${instance-CLIENT_CERT_OU}"
CERT_O="${instance-CLIENT_CERT_O}"


/* Create a client certificate, signed with the CA certificate */

Say "Creating certificate with label" CA_LABEL
"RACDCERT ID("CLIENT_USER") GENCERT",
    "SUBJECTSDN(CN('"CERT_CN"')",
    "O('"CERT_O"')",
    "OU('"CERT_OU"'))",
    "SIZE(2048)",
    "SIGNWITH (CERTAUTH LABEL('"CA_LABEL"'))",
    "WITHLABEL('"CERT_LABEL"')"
 if RC <> 0 then do
   Say "creating client certificate failed, exiting"
   exit RC
 end

Say "Refreshing DIGTCERT"
"SETROPTS RACLIST(DIGTCERT) REFRESH"

