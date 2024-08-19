//**********************************************************************/
//* Copyright Contributors to the zOS-Workflow Project.                */
//* SPDX-License-Identifier: Apache-2.0                                */
//**********************************************************************/
//*******************************************************
//* GRANT access to the database
//*******************************************************
//EKMFSQL  EXEC PGM=IKJEFT01,REGION=0M               
//         EXPORT SYMLIST=*
//         SET WEBUSER='${instance-UKO_SERVER_STC_USER}'
//STEPLIB  DD DISP=SHR,DSN=${instance-DB_HLQ}.SDSNLOAD               
//SYSTSPRT DD SYSOUT=*,DCB=BLKSIZE=131                         
//SYSPRINT DD SYSOUT=*                                         
//SYSUDUMP DD SYSOUT=*                                         
//SYSTSIN  DD *                                                
 DSN SYSTEM(${instance-DB_JCC_SSID})                                              
 RUN PROGRAM(${instance-DB_PROGRAM}) PLAN(${instance-DB_PLAN}) LIB('${instance-DB_RUNLIB}') 
 END                                                           
//SYSIN     DD    *,SYMBOLS=(JCLONLY)
#if(${instance-UKO_ADMIN_DB} && ${instance-UKO_ADMIN_DB} != "")
SET CURRENT SQLID = '${instance-UKO_ADMIN_DB}';   
#else
  #if(${instance-DB_CURRENT_SQLID} && ${instance-DB_CURRENT_SQLID} != "")
SET CURRENT SQLID = '${instance-DB_CURRENT_SQLID}';   
  #else
SET CURRENT SQLID = '${_step-stepOwnerUpper}';   
  #end
#end
SET CURRENT SCHEMA = '${instance-DB_CURRENT_SCHEMA}' ;

GRANT SELECT ON AUD_CONT TO &WEBUSER;
GRANT SELECT ON AUD_REG TO &WEBUSER;

GRANT SELECT ON AWSKMS_KEYSTORES TO &WEBUSER;
GRANT INSERT ON AWSKMS_KEYSTORES TO &WEBUSER;
GRANT UPDATE ON AWSKMS_KEYSTORES TO &WEBUSER;
GRANT DELETE ON AWSKMS_KEYSTORES TO &WEBUSER;

GRANT SELECT ON AZURE_KEYSTORES TO &WEBUSER;
GRANT INSERT ON AZURE_KEYSTORES TO &WEBUSER;
GRANT UPDATE ON AZURE_KEYSTORES TO &WEBUSER;
GRANT DELETE ON AZURE_KEYSTORES TO &WEBUSER;

GRANT SELECT ON EKMF_AUDIT_LOG_VIEW TO &WEBUSER;

GRANT SELECT ON EKMF_KEY_DISTRIBUTIONS TO &WEBUSER;

GRANT SELECT ON EKMF_META TO &WEBUSER;
GRANT INSERT ON EKMF_META TO &WEBUSER;

GRANT SELECT ON EKMF_WEB_CERTIFICATES TO &WEBUSER;

GRANT SELECT ON EKMF_WEB_KEY_INSTANCES TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEY_MATERIAL_EXPORT_CONTROL_KEYS_ALLOWED 
TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEY_MATERIALS TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEY_TAGS TO &WEBUSER;

GRANT SELECT ON EKMF_WEB_KEY_TEMPLATES TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEY_TEMPLATES_MANAGING_SYSTEM TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEY_TEMPLATES_ORIGINS TO &WEBUSER;

GRANT SELECT ON EKMF_WEB_KEY_XML TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEYS TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEYS_MANAGING_SYSTEM TO &WEBUSER;

GRANT SELECT ON IBMCLOUD_KEYSTORES TO &WEBUSER;
GRANT INSERT ON IBMCLOUD_KEYSTORES TO &WEBUSER;
GRANT UPDATE ON IBMCLOUD_KEYSTORES TO &WEBUSER;
GRANT DELETE ON IBMCLOUD_KEYSTORES TO &WEBUSER;

GRANT SELECT ON KEY_EVENT_CHANGES TO &WEBUSER;
GRANT SELECT ON KEY_EVENTS TO &WEBUSER;

GRANT SELECT ON KEY_STORES TO &WEBUSER;
GRANT INSERT ON KEY_STORES TO &WEBUSER;
GRANT UPDATE ON KEY_STORES TO &WEBUSER;
GRANT DELETE ON KEY_STORES TO &WEBUSER;

GRANT SELECT ON KEYSTORE_TAGS TO &WEBUSER;
GRANT INSERT ON KEYSTORE_TAGS TO &WEBUSER;
GRANT UPDATE ON KEYSTORE_TAGS TO &WEBUSER;
GRANT DELETE ON KEYSTORE_TAGS TO &WEBUSER;

GRANT SELECT ON KMGAGENT_KEYSTORES TO &WEBUSER;
GRANT INSERT ON KMGAGENT_KEYSTORES TO &WEBUSER;
GRANT UPDATE ON KMGAGENT_KEYSTORES TO &WEBUSER;
GRANT DELETE ON KMGAGENT_KEYSTORES TO &WEBUSER;

GRANT SELECT ON KMGPE_DATASET TO &WEBUSER;
GRANT SELECT ON KMGPE_SCAN_FILTER TO &WEBUSER;
GRANT SELECT ON KMGPE_SEC_DATASET TO &WEBUSER;
GRANT SELECT ON KMGPE_SYSTEM_INFO TO &WEBUSER;

GRANT SELECT ON VTSAUDIT TO &WEBUSER;
GRANT INSERT ON VTSAUDIT TO &WEBUSER;

GRANT SELECT ON WORKSTATION_KEYSTORES_CONFIG TO &WEBUSER;

GRANT SELECT ON XCERTS TO &WEBUSER;
GRANT INSERT ON XCERTS TO &WEBUSER;
GRANT UPDATE ON XCERTS TO &WEBUSER;
GRANT DELETE ON XCERTS TO &WEBUSER;

GRANT SELECT ON XTEMPLATESPURE TO &WEBUSER;
GRANT INSERT ON XTEMPLATESPURE TO &WEBUSER;
GRANT UPDATE ON XTEMPLATESPURE TO &WEBUSER;
GRANT DELETE ON XTEMPLATESPURE TO &WEBUSER;

GRANT SELECT ON XUKDS7 TO &WEBUSER;
GRANT INSERT ON XUKDS7 TO &WEBUSER;
GRANT UPDATE ON XUKDS7 TO &WEBUSER;
GRANT DELETE ON XUKDS7 TO &WEBUSER;

-- V2.1.0.4
GRANT SELECT ON LAST_SEQNO TO &WEBUSER;
GRANT INSERT ON LAST_SEQNO TO &WEBUSER;
GRANT UPDATE ON LAST_SEQNO TO &WEBUSER;
GRANT DELETE ON LAST_SEQNO TO &WEBUSER;

-- V3.1.0.0 
GRANT SELECT ON EKMF_KEY_DISTRIBUTIONS_WITHOUT_KEYSTORE TO &WEBUSER;

GRANT SELECT ON EKMF_VAULTS TO &WEBUSER;
GRANT INSERT ON EKMF_VAULTS TO &WEBUSER;
GRANT UPDATE ON EKMF_VAULTS TO &WEBUSER;
GRANT DELETE ON EKMF_VAULTS TO &WEBUSER;

GRANT SELECT ON EKMF_WEB_KEY_KEYSTORE_GROUPS TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_KEY_TEMPLATE_KEYSTORE_GROUPS TO &WEBUSER;

GRANT SELECT ON EKMF_WEB_SETTINGS TO &WEBUSER;
GRANT INSERT ON EKMF_WEB_SETTINGS TO &WEBUSER;
GRANT UPDATE ON EKMF_WEB_SETTINGS TO &WEBUSER;
GRANT DELETE ON EKMF_WEB_SETTINGS TO &WEBUSER;

GRANT SELECT ON GOOGLE_KMS_KEYSTORES TO &WEBUSER;
GRANT INSERT ON GOOGLE_KMS_KEYSTORES TO &WEBUSER;
GRANT UPDATE ON GOOGLE_KMS_KEYSTORES TO &WEBUSER;
GRANT DELETE ON GOOGLE_KMS_KEYSTORES TO &WEBUSER;

GRANT SELECT ON VTSSPARAM TO &WEBUSER;
GRANT INSERT ON VTSSPARAM TO &WEBUSER;
GRANT UPDATE ON VTSSPARAM TO &WEBUSER;

GRANT SELECT ON XCONFIG TO &WEBUSER;

-- temporary grants on tables
-- required from V3.1.0.0 to V3.1.0.1, fixed in 3.1.0.2

GRANT SELECT ON T_VAULTS_API_V4 TO &WEBUSER;
GRANT INSERT ON T_VAULTS_API_V4 TO &WEBUSER;
GRANT UPDATE ON T_VAULTS_API_V4 TO &WEBUSER;
GRANT DELETE ON T_VAULTS_API_V4 TO &WEBUSER;

GRANT SELECT ON T_TEMPLATES_API_V4 TO &WEBUSER;
GRANT INSERT ON T_TEMPLATES_API_V4 TO &WEBUSER;
GRANT UPDATE ON T_TEMPLATES_API_V4 TO &WEBUSER;
GRANT DELETE ON T_TEMPLATES_API_V4 TO &WEBUSER;

GRANT SELECT ON T_KEYS_API_V4 TO &WEBUSER;
GRANT INSERT ON T_KEYS_API_V4 TO &WEBUSER;
GRANT UPDATE ON T_KEYS_API_V4 TO &WEBUSER;
GRANT DELETE ON T_KEYS_API_V4 TO &WEBUSER;

GRANT SELECT ON T_KEYSTORES_API_V4 TO &WEBUSER;
GRANT INSERT ON T_KEYSTORES_API_V4 TO &WEBUSER;
GRANT UPDATE ON T_KEYSTORES_API_V4 TO &WEBUSER;
GRANT DELETE ON T_KEYSTORES_API_V4 TO &WEBUSER;

GRANT SELECT ON T_KEYSTORE_TAGS TO &WEBUSER;
GRANT INSERT ON T_KEYSTORE_TAGS TO &WEBUSER;
GRANT UPDATE ON T_KEYSTORE_TAGS TO &WEBUSER;
GRANT DELETE ON T_KEYSTORE_TAGS TO &WEBUSER;

-- V3.1.0.1
GRANT SELECT ON EKMF_WEB_KEY_KEYSTORES TO &WEBUSER;
GRANT SELECT ON EKMF_WEB_TEMPLATE_XML TO &WEBUSER;

GRANT SELECT ON INTERNAL_KEYSTORES TO &WEBUSER;
GRANT INSERT ON INTERNAL_KEYSTORES TO &WEBUSER;
GRANT UPDATE ON INTERNAL_KEYSTORES TO &WEBUSER;
GRANT DELETE ON INTERNAL_KEYSTORES TO &WEBUSER;

GRANT SELECT ON KEYSTORES_WITH_GROUPS TO &WEBUSER;

-- V3.1.0.2

GRANT SELECT ON VAULTS_API_V4 TO &WEBUSER;
GRANT INSERT ON VAULTS_API_V4 TO &WEBUSER;
GRANT UPDATE ON VAULTS_API_V4 TO &WEBUSER;
GRANT DELETE ON VAULTS_API_V4 TO &WEBUSER;

GRANT SELECT ON TEMPLATES_API_V4 TO &WEBUSER;
GRANT INSERT ON TEMPLATES_API_V4 TO &WEBUSER;
GRANT UPDATE ON TEMPLATES_API_V4 TO &WEBUSER;
GRANT DELETE ON TEMPLATES_API_V4 TO &WEBUSER;

GRANT SELECT ON KEYS_API_V4 TO &WEBUSER;
GRANT INSERT ON KEYS_API_V4 TO &WEBUSER;
GRANT UPDATE ON KEYS_API_V4 TO &WEBUSER;
GRANT DELETE ON KEYS_API_V4 TO &WEBUSER;

GRANT SELECT ON KEYSTORES_API_V4 TO &WEBUSER;
GRANT INSERT ON KEYSTORES_API_V4 TO &WEBUSER;
GRANT UPDATE ON KEYSTORES_API_V4 TO &WEBUSER;
GRANT DELETE ON KEYSTORES_API_V4 TO &WEBUSER;


/*
