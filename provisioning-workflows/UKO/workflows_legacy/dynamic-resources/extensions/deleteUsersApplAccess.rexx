/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

address tso

/***********************************************************************/
/* Creating the required user IDs and groups                           */
/***********************************************************************/

VAULT_ADMIN="${instance-UKO_VAULT_ADMIN}"
KEY_ADMIN="${instance-UKO_KEY_ADMIN}"
KEY_CUSTODIAN1="${instance-UKO_KEY_CUSTODIAN1}"
KEY_CUSTODIAN2="${instance-UKO_KEY_CUSTODIAN2}"
UKO_AUDITOR="${instance-UKO_AUDITOR}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

Say "Grant access to" SAFPREFIX "to" VAULT_ADMIN
"PERMIT" SAFPREFIX "CLASS(APPL) DELETE ID("VAULT_ADMIN")"
Say "Grant access to" SAFPREFIX "to" KEY_ADMIN
"PERMIT" SAFPREFIX "CLASS(APPL) DELETE ID("KEY_ADMIN")"
Say "Grant access to" SAFPREFIX "to" KEY_CUSTODIAN1
"PERMIT" SAFPREFIX "CLASS(APPL) DELETE ID("KEY_CUSTODIAN1")"
Say "Grant access to" SAFPREFIX "to" KEY_CUSTODIAN2
"PERMIT" SAFPREFIX "CLASS(APPL) DELETE ID("KEY_CUSTODIAN2")"
Say "Grant access to" SAFPREFIX "to" UKO_AUDITOR
"PERMIT" SAFPREFIX "CLASS(APPL) DELETE ID("UKO_AUDITOR")"

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"