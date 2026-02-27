/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

/***********************************************************************/
/* Creating the required groups for the schema                         */
/***********************************************************************/

/* AGENT_STC_USER="${instance-AGENT_STC_USER}" */
/* SERVER_STC_USER="${instance-SERVER_STC_USER}" */

DB_CURRENT_SQLID="${instance-DB_CURRENT_SQLID}"


Say "Creating the database group"
"ADDGROUP" DB_CURRENT_SQLID "SUPGROUP(CCCAGRP) OMVS(AUTOGID)"
/* remove the comments if you grant database access using a */
/* schema group */
/* "CONNECT " SERVER_STC_USER "GROUP("DB_CURRENT_SQLID")",*/
/*    " AUTH(USE) UACC(NONE)" */
/* "CONNECT " AGENT_STC_USER "GROUP("DB_CURRENT_SQLID")", */
   /* " AUTH(USE) UACC(NONE)" */
"CONNECT  ${instance-UKO_ADMIN_DB} GROUP("DB_CURRENT_SQLID")",
   " AUTH(USE) UACC(NONE)"


