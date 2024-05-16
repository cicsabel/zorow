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

SUPERIOR_GROUP="${instance-UKO_PERSONAL_SUPERIOR_GROUP}"

#if($!{instance-UKO_CREATE_PERSONAL_USER_GROUPS} == "true" ) 
/***********************************************************************/
/* Creating required groups                                        */
/***********************************************************************/
Say "Creating required groups"
Say "Creating vault administrator group "||VAULT_ADMIN_GROUP||" "
"ADDGROUP "||VAULT_ADMIN_GROUP||" SUPGROUP("||SUPERIOR_GROUP||") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating key administrator group "||KEY_ADMIN_GROUP||" "
"ADDGROUP "||KEY_ADMIN_GROUP||" SUPGROUP("||SUPERIOR_GROUP||") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating key custodian1 group "||KEY_CUSTODIAN1_GROUP||" "
"ADDGROUP "||KEY_CUSTODIAN1_GROUP||" SUPGROUP("||SUPERIOR_GROUP||") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating key custodian2 group"||KEY_CUSTODIAN2_GROUP||" "
"ADDGROUP "||KEY_CUSTODIAN2_GROUP||" SUPGROUP("||SUPERIOR_GROUP||") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
Say "Creating auditor group "||UKO_AUDITOR_GROUP||" "
"ADDGROUP "||UKO_AUDITOR_GROUP||" SUPGROUP("||SUPERIOR_GROUP||") OMVS(AUTOGID)"
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
#end

#if($!{instance-UKO_CREATE_PERSONAL_USERIDS} == "true" ) 
/***********************************************************************/
/* Creating all required user ids                                      */
/***********************************************************************/

Say "Adding vault administrator user "||VAULT_ADMIN||" "
"ADDUSER "||VAULT_ADMIN||" NOOIDCARD ",
   " DFLTGRP("||VAULT_ADMIN_GROUP||") NAME('VAULT ADMIN')",
   " PHRASE('${instance-USER_PASSPHRASE}')",
   " TSO( acctnum(${instance-USER_TSO_ACCOUNT_NUMBER})", 
      " holdclass(${instance-USER_TSO_HOLDCLASS}) ",
      " msgclass(${instance-USER_TSO_MSGCLASS}) ",
      " sysoutclass(${instance-USER_TSO_SYSOUTCLASS}) ",
      " proc(${instance-USER_TSO_LOGON_PROCEDURE}) ",
      " size(${instance-USER_TSO_SIZE}) ",
      " unit(${instance-USER_TSO_UNIT})) ",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"||VAULT_ADMIN||"'"||")) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) ACCESS(READ) ID("||VAULT_ADMIN||")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) ACCESS(READ) ID("||VAULT_ADMIN||")" 
"SETROPTS RACLIST(TSOPROC) REFRESH "

Say "Adding key administrator user "||KEY_ADMIN||" "
"ADDUSER "||KEY_ADMIN||" NOOIDCARD ",
   " DFLTGRP("||KEY_ADMIN_GROUP||") NAME('KEY ADMIN')",
   " PHRASE('${instance-USER_PASSPHRASE}')",
   " TSO( acctnum(${instance-USER_TSO_ACCOUNT_NUMBER})", 
      " holdclass(${instance-USER_TSO_HOLDCLASS}) ",
      " msgclass(${instance-USER_TSO_MSGCLASS}) ",
      " sysoutclass(${instance-USER_TSO_SYSOUTCLASS}) ",
      " proc(${instance-USER_TSO_LOGON_PROCEDURE}) ",
      " size(${instance-USER_TSO_SIZE}) ",
      " unit(${instance-USER_TSO_UNIT})) ",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"||KEY_ADMIN||"'"||")) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) ACCESS(READ) ID("||KEY_ADMIN||")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) ACCESS(READ) ID("||KEY_ADMIN||")" 
"SETROPTS RACLIST(TSOPROC) REFRESH "

Say "Adding key custodian 1 user "||KEY_CUSTODIAN1||" "
"ADDUSER "||KEY_CUSTODIAN1||" NOOIDCARD ",
   " DFLTGRP("||KEY_CUSTODIAN1_GROUP||") NAME('KEY CUSTODIAN 1')",
   " PHRASE('${instance-USER_PASSPHRASE}')",
   " TSO( acctnum(${instance-USER_TSO_ACCOUNT_NUMBER})", 
      " holdclass(${instance-USER_TSO_HOLDCLASS}) ",
      " msgclass(${instance-USER_TSO_MSGCLASS}) ",
      " sysoutclass(${instance-USER_TSO_SYSOUTCLASS}) ",
      " proc(${instance-USER_TSO_LOGON_PROCEDURE}) ",
      " size(${instance-USER_TSO_SIZE}) ",
      " unit(${instance-USER_TSO_UNIT})) ",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"||KEY_CUSTODIAN1||"'"||")) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) ACCESS(READ) ID("||KEY_CUSTODIAN1||")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) ACCESS(READ) ID("||KEY_CUSTODIAN1||")" 
"SETROPTS RACLIST(TSOPROC) REFRESH "


Say "Adding key custodian 2 user "||KEY_CUSTODIAN2||""
"ADDUSER "||KEY_CUSTODIAN2||" NOOIDCARD ",
   " DFLTGRP("||KEY_CUSTODIAN2_GROUP||") NAME('KEY CUSTODIAN 2')",
   " PHRASE('${instance-USER_PASSPHRASE}')",
   " TSO( acctnum(${instance-USER_TSO_ACCOUNT_NUMBER})", 
      " holdclass(${instance-USER_TSO_HOLDCLASS}) ",
      " msgclass(${instance-USER_TSO_MSGCLASS}) ",
      " sysoutclass(${instance-USER_TSO_SYSOUTCLASS}) ",
      " proc(${instance-USER_TSO_LOGON_PROCEDURE}) ",
      " size(${instance-USER_TSO_SIZE}) ",
      " unit(${instance-USER_TSO_UNIT})) ",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"||KEY_CUSTODIAN2||"'"||")) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) ACCESS(READ) ID("||KEY_CUSTODIAN2||")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) ACCESS(READ) ID("||KEY_CUSTODIAN2||")" 
"SETROPTS RACLIST(TSOPROC) REFRESH "


Say "Adding auditor user "||UKO_AUDITOR||" "
"ADDUSER "||UKO_AUDITOR||" NOOIDCARD ",
   " DFLTGRP("||UKO_AUDITOR_GROUP||") NAME('KEY AUDITOR')",
   " PHRASE('${instance-USER_PASSPHRASE}')",
   " TSO( acctnum(${instance-USER_TSO_ACCOUNT_NUMBER})", 
      " holdclass(${instance-USER_TSO_HOLDCLASS}) ",
      " msgclass(${instance-USER_TSO_MSGCLASS}) ",
      " sysoutclass(${instance-USER_TSO_SYSOUTCLASS}) ",
      " proc(${instance-USER_TSO_LOGON_PROCEDURE}) ",
      " size(${instance-USER_TSO_SIZE}) ",
      " unit(${instance-USER_TSO_UNIT})) ",
   " OMVS(AUTOUID ",
   " HOME('${instance-USER_HOME_PARENT_DIR}/"||UKO_AUDITOR||"'"||")) "
if RC <> 0 then do
   Say "Creation failed, exiting"
   exit RC
end
"PERMIT ${instance-USER_TSO_ACCOUNT_NUMBER} CL(ACCTNUM ) ACCESS(READ) ID("||UKO_AUDITOR||")" 
"PERMIT ${instance-USER_TSO_LOGON_PROCEDURE} CL(TSOPROC ) ACCESS(READ) ID("||UKO_AUDITOR||")" 
"SETROPTS RACLIST(TSOPROC) REFRESH "


#end 

