/* REXX */
/*----------------------------------------------------------------*/
/* Copyright Contributors to the zOS-Workflow Project.            */
/* PDX-License-Identifier: Apache-2.0                             */
/*----------------------------------------------------------------*/

CC_GROUP="${instance-CRYPTO_CONNECT_USER_GROUP}"
SAFPREFIX="${instance-SAF_PROFILE_PREFIX}"

/***********************************************************************/
/* deleting access from the different user roles                         */
/***********************************************************************/

Say "Delete Permissions from" CC_GROUP
"PERMIT" SAFPREFIX".crypto-connect.operations:data:encrypt CLASS(EJBROLE)",
    " DELETE ID("CC_GROUP")"
"PERMIT" SAFPREFIX".crypto-connect.operations:data:decrypt CLASS(EJBROLE)",
    " DELETE ID("CC_GROUP")"

#if(${instance-SAF_PROFILE_PREFIX} && ${instance-SAF_PROFILE_PREFIX} != "EKMFWEB")
/* if the SAF prefix is dynamic, the groups need to be removed. */
/* For APPL=EKMFWEB, keep the access for pre v3.1.0.2 compatibility */
"RDELETE EJBROLE" SAFPREFIX".crypto-connect.operations:data:encrypt"
"RDELETE EJBROLE" SAFPREFIX".crypto-connect.operations:data:decrypt"
"RDELETE EJBROLE" SAFPREFIX".ekmf-rest-api.authenticated"
"RDELETE EJBROLE" SAFPREFIX".com.ibm.ws.security.oauth20.*"
"RDELETE EJBROLE" SAFPREFIX".*.* "
#end

/* Refresh */
Say "Refreshing EJBROLE"
"SETROPTS RACLIST(EJBROLE) REFRESH"

#if(${instance-SAF_PROFILE_PREFIX} && ${instance-SAF_PROFILE_PREFIX} != "EKMFWEB")
/* if the SAF prefix is dynamic, the groups need to be removed. */
/* For APPL=EKMFWEB, keep the access for pre v3.1.0.2 compatibility */
Say "Remove access to CC from" CC_GROUP
"PERMIT" SAFPREFIX "CLASS(APPL)",
   " DELETE ID("CC_GROUP")"

Say "Refreshing APPL"
"SETROPTS RACLIST(APPL) REFRESH"

#end

exit