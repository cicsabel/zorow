/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso


MTLS_USER="${instance-MTLS_USER}"

Say "Deleting certificate" MTLS_USER".MTLS "
"RACDCERT ID("MTLS_USER") DELETE",
   " (LABEL(""'"MTLS_USER".MTLS'""))"  
Say "Issuing a refresh on DIGTCERT" 
"SETROPTS RACLIST(DIGTCERT) REFRESH"