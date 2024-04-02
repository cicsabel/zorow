/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


CA_LABEL="${instance-UKO_CA_LABEL}"
CA_CN="${instance-UKO_TLS_KEY_STORE_SERVER_CERT_CN}"
CA_OU="${instance-UKO_TLS_KEY_STORE_SERVER_CERT_OU}"
CA_O="${instance-UKO_TLS_KEY_STORE_SERVER_CERT_O}"

"SETROPTS CLASSACT(DIGTCERT)"

Say "Generate a new CA"
"RACDCERT CERTAUTH GENCERT", 
   " SUBJECTSDN(CN("||"'"||CA_CN||"'"||")",
      " OU("||"'"||CA_OU||"'"||")",
      " O("||"'"||CA_O||"'"||"))",
   " WITHLABEL("||"'"||CA_LABEL||"'"||")", 
   " NOTAFTER(DATE(2028-12-31) TIME(23:59:59))", 
   " RSA SIZE(2048)"

 if RC <> 0 then do
   Say "Creating a CA failed, exiting"
   exit RC
 end

Say "Refresh DIGTCERT"
"SETROPTS RACLIST(DIGTCERT) REFRESH"
