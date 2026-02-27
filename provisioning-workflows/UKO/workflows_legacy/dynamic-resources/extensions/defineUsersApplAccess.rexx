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
SYSTEMQ="${instance-SYS_QUALIFIER}"

Say "Grant access to" SYSTEMQ "to" VAULT_ADMIN
"PERMIT" SYSTEMQ "CLASS(APPL) ACCESS(READ) ID("VAULT_ADMIN")"
Say "Grant access to" SYSTEMQ "to" KEY_ADMIN
"PERMIT" SYSTEMQ "CLASS(APPL) ACCESS(READ) ID("KEY_ADMIN")"
Say "Grant access to" SYSTEMQ "to" KEY_CUSTODIAN1
"PERMIT" SYSTEMQ "CLASS(APPL) ACCESS(READ) ID("KEY_CUSTODIAN1")"
Say "Grant access to" SYSTEMQ "to" KEY_CUSTODIAN2
"PERMIT" SYSTEMQ "CLASS(APPL) ACCESS(READ) ID("KEY_CUSTODIAN2")"
Say "Grant access to" SYSTEMQ "to" UKO_AUDITOR
"PERMIT" SYSTEMQ "CLASS(APPL) ACCESS(READ) ID("UKO_AUDITOR")"

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"
