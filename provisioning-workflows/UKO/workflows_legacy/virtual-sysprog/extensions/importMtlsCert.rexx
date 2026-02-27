/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


MTLS_USER="${instance-MTLS_USER}"
MTLS_PASSWORD="${instance-MTLS_EXPORT_PASSWORD}"
MTLS_HLQ="${instance-MTLS_HLQ}"

Say "Checking certificate dataset "MTLS_HLQ"."MTLS_USER".MTLS"
"RACDCERT CHECKCERT('"MTLS_HLQ"."MTLS_USER".MTLS')",
   " PASSWORD('"MTLS_PASSWORD"')"
if RC <> 0 then do
   Say "Checking of the dataset was not succesful"
   exit RC
end

Say "Deleting existing certificate for" MTLS_USER
"RACDCERT ID("MTLS_USER") DELETE",
   " (LABEL('"MTLS_USER".MTLS'))" 
"SETROPTS RACLIST(DIGTCERT) REFRESH"                                   

Say "Importing certificate"
"RACDCERT ID("MTLS_USER")", 
 "ADD('"MTLS_HLQ"."MTLS_USER".MTLS')", 
 "WITHLABEL('"MTLS_USER".MTLS')", 
  "TRUST PASSWORD('"MTLS_PASSWORD"')"

Say "Refreshing DIGTCERT"
"SETROPTS RACLIST(DIGTCERT) REFRESH"

