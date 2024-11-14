/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

SERVER_STC_GROUP="${instance-CC_SERVER_STC_GROUP}"

"PERMIT  CSFPKRR CLASS(CSFSERV) DELETE ID("SERVER_STC_GROUP")"
"PERMIT  CSFPKI  CLASS(CSFSERV) DELETE ID("SERVER_STC_GROUP")"
"PERMIT  CSFPKX  CLASS(CSFSERV) DELETE ID("SERVER_STC_GROUP")"
"PERMIT  CSFSAE  CLASS(CSFSERV) DELETE ID("SERVER_STC_GROUP")"
"PERMIT  CSFKRR2 CLASS(CSFSERV) DELETE ID("SERVER_STC_GROUP")"
"PERMIT  CSFSAD  CLASS(CSFSERV) DELETE ID("SERVER_STC_GROUP")"
"PERMIT  CSFPKD  CLASS(CSFSERV) DELETE ID("SERVER_STC_GROUP")"

"SETROPTS RACLIST(CSFSERV) REFRESH"

