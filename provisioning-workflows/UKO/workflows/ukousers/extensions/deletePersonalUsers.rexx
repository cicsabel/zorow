/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

VAULT_ADMIN="${instance-UKO_VAULT_ADMIN}"
VAULT_ADMIN_GROUP="${instance-UKO_VAULT_ADMIN_GROUP}"

KEY_ADMIN="${instance-UKO_KEY_ADMIN}"
KEY_ADMIN_GROUP="${instance-UKO_KEY_ADMIN_GROUP}"

KEY_CUSTODIAN1="${instance-UKO_KEY_CUSTODIAN1}"
KEY_CUSTODIAN1_GROUP="${instance-UKO_KEY_CUSTODIAN1_GROUP}"

KEY_CUSTODIAN2="${instance-UKO_KEY_CUSTODIAN2}"
KEY_CUSTODIAN2_GROUP="${instance-UKO_KEY_CUSTODIAN2_GROUP}"

UKO_AUDITOR="${instance-UKO_AUDITOR}"
UKO_AUDITOR_GROUP="${instance-UKO_AUDITOR_GROUP}"


#if($!{instance-UKO_CREATE_PERSONAL_USERIDS} == "true" ) 
"DELUSER" VAULT_ADMIN
"DELUSER" KEY_ADMIN
"DELUSER" KEY_CUSTODIAN1
"DELUSER" KEY_CUSTODIAN2
"DELUSER" UKO_AUDITOR
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) DELETE ID("VAULT_ADMIN")" 
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) DELETE ID("KEY_ADMIN")" 
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) DELETE ID("KEY_CUSTODIAN1")" 
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) DELETE ID("KEY_CUSTODIAN2")" 
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) DELETE ID("UKO_AUDITOR")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) DELETE ID("VAULT_ADMIN")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) DELETE ID("KEY_ADMIN")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) DELETE ID("KEY_CUSTODIAN1")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) DELETE ID("KEY_CUSTODIAN2")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) DELETE ID("UKO_AUDITOR")" 
"SETROPTS RACLIST(TSOPROC) REFRESH "

#end

#if($!{instance-UKO_CREATE_PERSONAL_USER_GROUPS} == "true" ) 
"DELGROUP" VAULT_ADMIN_GROUP
"DELGROUP" KEY_ADMIN_GROUP
"DELGROUP" KEY_CUSTODIAN1_GROUP
"DELGROUP" KEY_CUSTODIAN2_GROUP
"DELGROUP" UKO_AUDITOR_GROUP
#end

