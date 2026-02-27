/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


MTLS_USER="${instance-MTLS_USER}"
CA_LABEL="${instance-SERVER_CA_LABEL}"
CERT_FORMAT="${instance-CERT_FORMAT}"
MTLS_PASSWORD="${instance-MTLS_EXPORT_PASSWORD}"
MTLS_HLQ="${instance-MTLS_HLQ}"

Say "Deleting existing certificate for" MTLS_USER
"RACDCERT ID("MTLS_USER") DELETE",
   " (LABEL(""'"MTLS_USER".MTLS'""))" 
"SETROPTS RACLIST(DIGTCERT) REFRESH"                                   

Say "Creating certificate for" MTLS_USER
"RACDCERT ID("MTLS_USER") GENCERT ",
   "SUBJECTSDN(CN('"MTLS_USER"') OU('CCCC') O('IBM')) ",
   "WITHLABEL('"MTLS_USER".MTLS') ",
   "SIGNWITH(CERTAUTH LABEL('"CA_LABEL"')) ",
   "NOTAFTER(DATE(2027-11-30) TIME(23:59:59)) ",
   "RSA SIZE(2048) "                                                      
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end

Say "Refreshing DIGTCERT"   
"SETROPTS RACLIST(DIGTCERT) REFRESH"                                   
Say "Exporting certificate to "MTLS_HLQ"."MTLS_USER".MTLS "
"RACDCERT ID("MTLS_USER") EXPORT ",
   "(LABEL('"MTLS_USER".MTLS')) ",
   "DSN('"MTLS_HLQ"."MTLS_USER".MTLS') ",
   "FORMAT("CERT_FORMAT") PASSWORD('"MTLS_PASSWORD"')"      
if RC <> 0 then do
   Say "Export failed, exiting"
   exit RC
end

