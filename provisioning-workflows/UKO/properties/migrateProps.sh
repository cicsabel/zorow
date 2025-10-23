# Assisted by watsonx Code Assistant

#!/bin/bash

# Read the old configuration file
old_config_file=$1
new_config_file=$2

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "Error: Incorrect number of arguments. Usage: $0 <old_config_file> <new_config_file>"
  exit 1
fi

# Check if arguments are identical
if [ "$old_config_file" = "$new_config_file" ]; then
  echo "Error: old_config_file and new_config_file cannot be the same."
  exit 1
fi

# Check if new_config_file already exists
if [ -f "$new_config_file" ]; then
  echo "Error: new_config_file '$new_config_file' already exists. Please choose a different name."
  exit 1
fi

# Continue with your migration script logic here
echo "Migration script will now process '$old_config_file' to create '$new_config_file'."

sedstring=""
sedstring="${sedstring} s#UKO_INSTALL_DIR#SERVER_INSTALL_DIR#g;"

# Define old and new variable names
sedstring="${sedstring} s#UKO_INSTALL_DIR#SERVER_INSTALL_DIR#g;"
sedstring="${sedstring} s#WLP_USER_DIR#SERVER_USER_DIR#g;"
sedstring="${sedstring} s#WLP_OUTPUT_DIR#SERVER_OUTPUT_DIR#g;"
sedstring="${sedstring} s#UKO_FILE_SYSTEM_HLQ#SERVER_FILE_SYSTEM_HLQ#g;"
sedstring="${sedstring} s#UKO_ZOS_VSAM_VOLUME#ZOS_VSAM_VOLUME#g;"
sedstring="${sedstring} s#UKO_ZOS_PROCLIB#ZOS_PROCLIB#g;"
sedstring="${sedstring} s#UKO_ZOS_PARMLIB#ZOS_PARMLIB#g;"
sedstring="${sedstring} s#UKO_ZFS_DATACLASS#ZOS_ZFS_DATACLASS#g;"
sedstring="${sedstring} s#UKO_CREATE_TECHNICAL_USER_GROUPS#CREATE_TECHNICAL_USER_GROUPS#g;"
sedstring="${sedstring} s#UKO_TECHNICAL_SUPERIOR_GROUP#TECHNICAL_SUPERIOR_GROUP#g;"
sedstring="${sedstring} s#UKO_CREATE_PERSONAL_USER_GROUPS#CREATE_PERSONAL_USER_GROUPS#g;"
sedstring="${sedstring} s#UKO_PERSONAL_SUPERIOR_GROUP#PERSONAL_SUPERIOR_GROUP#g;"
sedstring="${sedstring} s#UKO_CREATE_TECHNICAL_USERIDS#CREATE_TECHNICAL_USERIDS#g;"
sedstring="${sedstring} s#UKO_CREATE_PERSONAL_USERIDS#CREATE_PERSONAL_USERIDS#g;"
sedstring="${sedstring} s#UKO_AGENT_STC_USER#AGENT_STC_USER#g;"
sedstring="${sedstring} s#UKO_AGENT_STC_GROUP#AGENT_STC_GROUP#g;"
sedstring="${sedstring} s#UKO_AGENT_PORT#AGENT_PORT#g;"
sedstring="${sedstring} s#UKO_AGENT_STC_NAME#AGENT_STC_NAME#g;"
sedstring="${sedstring} s#UKO_AGENT_EXECLIB#AGENT_EXECLIB#g;"
sedstring="${sedstring} s#UKO_AGENT_SAMPLIB#AGENT_SAMPLIB#g;"
sedstring="${sedstring} s#UKO_AGENT_DBRMLIB#AGENT_DBRMLIB#g;"
sedstring="${sedstring} s#UKO_AGENT_RUNLIB#AGENT_RUNLIB#g;"
sedstring="${sedstring} s#UKO_CREATE_CA#SERVER_CREATE_CA#g;"
sedstring="${sedstring} s#UKO_CA_LABEL#SERVER_CA_LABEL#g;"
sedstring="${sedstring} s#UKO_CA_CN#SERVER_CA_CN#g;"
sedstring="${sedstring} s#UKO_CA_OU#SERVER_CA_OU#g;"
sedstring="${sedstring} s#UKO_CA_O#SERVER_CA_O#g;"
sedstring="${sedstring} s#UKO_CREATE_KEYRING#SERVER_CREATE_KEYRING#g;"
sedstring="${sedstring} s#UKO_USE_KEYRING_AS_TRUST_STORE#SERVER_USE_KEYRING_AS_TRUST_STORE#g;"
sedstring="${sedstring} s#UKO_CREATE_CERTIFICATES#SERVER_CREATE_CERTIFICATES#g;"
sedstring="${sedstring} s#UKO_TLS_KEY_STORE_SERVER_CERT#SERVER_TLS_KEY_STORE_SERVER_CERT#g;"
sedstring="${sedstring} s#UKO_TLS_KEY_STORE_SERVER_CERT_CN#SERVER_TLS_KEY_STORE_SERVER_CERT_CN#g;"
sedstring="${sedstring} s#UKO_TLS_KEY_STORE_SERVER_CERT_OU#SERVER_TLS_KEY_STORE_SERVER_CERT_OU#g;"
sedstring="${sedstring} s#UKO_TLS_KEY_STORE_SERVER_CERT_O#SERVER_TLS_KEY_STORE_SERVER_CERT_O#g;"
sedstring="${sedstring} s#UKO_TLS_KEY_STORE_KEY_RING#SERVER_TLS_KEY_STORE_KEY_RING#g;"
sedstring="${sedstring} s#UKO_TLS_TRUST_STORE_KEY_RING#SERVER_TLS_TRUST_STORE_KEY_RING#g;"
sedstring="${sedstring} s#UKO_OIDC_PROVIDER_CERT#SERVER_OIDC_PROVIDER_CERT#g;"
sedstring="${sedstring} s#UKO_SERVER_STC_NAME#SERVER_STC_NAME#g;"
sedstring="${sedstring} s#UKO_SERVER_STC_USER#SERVER_STC_USER#g;"
sedstring="${sedstring} s#UKO_SERVER_STC_GROUP#SERVER_STC_GROUP#g;"
sedstring="${sedstring} s#UKO_UNAUTHENTICATED_USER#WLP_UNAUTHENTICATED_USER#g;"
sedstring="${sedstring} s#UKO_UNAUTHENTICATED_GROUP#WLP_UNAUTHENTICATED_GROUP#g;"
sedstring="${sedstring} s#UKO_HTTP_PORT#SERVER_PORT_NOTLS#g;"
sedstring="${sedstring} s#UKO_HTTPS_PORT#SERVER_PORT_TLS#g;"
sedstring="${sedstring} s#UKO_KEY_PREFIX#KEY_PREFIX#g;"
sedstring="${sedstring} s#CC_INSTALL_DIR#SERVER_INSTALL_DIR#g;"
sedstring="${sedstring} s#CC_FILE_SYSTEM_HLQ#SERVER_FILE_SYSTEM_HLQ#g;"
sedstring="${sedstring} s#CC_CREATE_TECHNICAL_USER_GROUPS#CREATE_TECHNICAL_USER_GROUPS#g;"
sedstring="${sedstring} s#CC_TECHNICAL_SUPERIOR_GROUP#TECHNICAL_SUPERIOR_GROUP#g;"
sedstring="${sedstring} s#CC_CREATE_TECHNICAL_USERIDS#CREATE_TECHNICAL_USERIDS#g;"
sedstring="${sedstring} s#CC_CREATE_CA#SERVER_CREATE_CA#g;"
sedstring="${sedstring} s#CC_CA_LABEL#SERVER_CA_LABEL#g;"
sedstring="${sedstring} s#CC_CA_CN#SERVER_CA_CN#g;"
sedstring="${sedstring} s#CC_CA_OU#SERVER_CA_OU#g;"
sedstring="${sedstring} s#CC_CA_O#SERVER_CA_O#g;"
sedstring="${sedstring} s#CC_CREATE_KEYRING#SERVER_CREATE_KEYRING#g;"
sedstring="${sedstring} s#CC_USE_KEYRING_AS_TRUST_STORE#SERVER_USE_KEYRING_AS_TRUST_STORE#g;"
sedstring="${sedstring} s#CC_CREATE_CERTIFICATES#SERVER_CREATE_CERTIFICATES#g;"
sedstring="${sedstring} s#CC_TLS_KEY_STORE_SERVER_CERT_CN#SERVER_TLS_KEY_STORE_SERVER_CERT_CN#g;"
sedstring="${sedstring} s#CC_TLS_KEY_STORE_SERVER_CERT_OU#SERVER_TLS_KEY_STORE_SERVER_CERT_OU#g;"
sedstring="${sedstring} s#CC_TLS_KEY_STORE_SERVER_CERT_O#SERVER_TLS_KEY_STORE_SERVER_CERT_O#g;"
sedstring="${sedstring} s#CC_TLS_KEY_STORE_KEY_RING#SERVER_TLS_KEY_STORE_KEY_RING#g;"
sedstring="${sedstring} s#CC_TLS_TRUST_STORE_KEY_RING#SERVER_TLS_TRUST_STORE_KEY_RING#g;"
sedstring="${sedstring} s#CC_TLS_KEY_STORE_SERVER_CERT#SERVER_TLS_KEY_STORE_SERVER_CERT#g;"
sedstring="${sedstring} s#CC_OIDC_PROVIDER_CERT#SERVER_OIDC_PROVIDER_CERT#g;"
sedstring="${sedstring} s#CC_SERVER_STC_NAME#SERVER_STC_NAME#g;"
sedstring="${sedstring} s#CC_SERVER_STC_USER#SERVER_STC_USER#g;"
sedstring="${sedstring} s#CC_SERVER_STC_GROUP#SERVER_STC_GROUP#g;"
sedstring="${sedstring} s#CC_UNAUTHENTICATED_USER#WLP_UNAUTHENTICATED_USER#g;"
sedstring="${sedstring} s#CC_UNAUTHENTICATED_GROUP#WLP_UNAUTHENTICATED_GROUP#g;"
sedstring="${sedstring} s#CC_HTTP_PORT#SERVER_PORT_NOTLS#g;"
sedstring="${sedstring} s#CC_HTTPS_PORT#SERVER_PORT_TLS#g;"
sedstring="${sedstring} s#CC_KEY_PREFIX#KEY_PREFIX#g;"

sed -e "$sedstring" ${old_config_file} > ${new_config_file};

echo "Migration complete. New configuration saved to ${new_config_file}"

exit