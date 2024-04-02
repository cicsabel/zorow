/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

DB_CURRENT_SQLID="${instance-DB_CURRENT_SQLID}"

#if($!{instance-UKO_CREATE_TECHNICAL_USERIDS} == "true" ) 

"REMOVE  ${instance-UKO_ADMIN_DB} GROUP("||DB_CURRENT_SQLID||")"
"DELGROUP "||DB_CURRENT_SQLID||" " 

#end

