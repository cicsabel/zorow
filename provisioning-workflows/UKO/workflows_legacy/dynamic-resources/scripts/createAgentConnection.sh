vaultid=${instance-UKO_VAULT_ID}
echo "vault id:" $vaultid
ekmfport=${instance-SERVER_PORT_TLS}
echo "ekmf port:" $ekmfport
keyprefix=${instance-KEY_PREFIX}
echo "ekmf keyprefix:" $keyprefix
currentversion=${instance-SERVER_VERSION}
echo "ekmf version:" $currentversion
agentprefix=${instance-AGENT_STC_NAME}
echo "agent started task name:" $agentprefix
requiredversion="3.1.0.00"

userid=${instance-UKO_ADMIN_SERVER}
#userid=${_step-stepOwnerUpper}

if [ -d "/u/${userid}" ]  
then
   cd /u/${userid}/mtls
else
   useridLC=$(echo "${userid}" | tr '[:upper:]' '[:lower:]')
   cd /u/${useridLC}/mtls
fi

host=$(hostname | tr [:upper:] [:lower:]) 

echo "*****************************"
echo "agent connection setup" 
echo "*****************************"

jobid=$(curl -k --silent 'https://'${host}':32070/zosmf/restjobs/jobs?owner=*&prefix='${agentprefix}'&max-jobs=1000&exec-data=N&status=active' -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key | cut -d ',' -f  8 | cut -c 10-17)
echo "agent jobid: " $jobid
agenthash=$(curl -k --silent 'https://'${host}':32070/zosmf/restjobs/jobs/'${agentprefix}'/'${jobid}'/files/102/records?mode=text&search=%20-%20SHA-256%20%3A%20&maxreturnsize=1' -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key | sed -E 's/.*: ([^\$])/\1/')
echo "agent hash: " $agenthash
agentport=$(curl -k --silent 'https://'${host}':32070/zosmf/restjobs/jobs/'${agentprefix}'/'${jobid}'/files/102/records?mode=text&search=port&maxreturnsize=1' -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key | sed -E 's/.*: ([^\$])/\1/')
echo "agent port: " $agentport

if [ "$(printf '%s\n' "$requiredversion" "$currentversion" | sort -V | head -n1)" = "$requiredversion" ]; then 
   echo "\n create connection to own agent"
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/keystores' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{  "name": "KMGAGENT",  "type": "cca", "cca_host": "'${host}'",  "cca_port": "'${agentport}'",  "cca_public_key_hash": "'${agenthash}'", "cca_use_tls": "false", "groups": [ "'${agentprefix}'","I:KEYMNGNT", "COMMON"],  "vault": { "id": "'${vaultid}'"}}' 
else
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/keystores' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{  "keystoreType": "KMGAGENT",  "name": "KMGAGENT",  "address": "'${host}'",  "port": "'${agentport}'",  "publicKeyHash": "'${agenthash}'" }'    
fi

echo "\n retrieving details for at-tls agent"

agentprefix=${instance-UKO_AGENT_ATTLS_NAME}
jobid=$(curl -k --silent 'https://'${host}':32070/zosmf/restjobs/jobs?owner=*&prefix='${agentprefix}'&max-jobs=1000&exec-data=N&status=active' -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key | cut -d ',' -f  8 | cut -c 10-17)
echo "agent jobid: " $jobid
agenthash=$(curl -k --silent 'https://'${host}':32070/zosmf/restjobs/jobs/'${agentprefix}'/'${jobid}'/files/102/records?mode=text&search=%20-%20SHA-256%20%3A%20&maxreturnsize=1' -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key | sed -E 's/.*: ([^\$])/\1/')
echo "agent hash: " $agenthash
agentport=$(curl -k --silent 'https://'${host}':32070/zosmf/restjobs/jobs/'${agentprefix}'/'${jobid}'/files/102/records?mode=text&search=port&maxreturnsize=1' -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key | sed -E 's/.*: ([^\$])/\1/')
echo "agent port: " $agentport

if [ "$(printf '%s\n' "$requiredversion" "$currentversion" | sort -V | head -n1)" = "$requiredversion" ]; then 
   echo "\n create connection to attls agent"
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/keystores' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{  "name": "attls-'${agentprefix}'","type":"cca","vault":{"id":"'${vaultid}'"},"groups":["'${agentprefix}'", "attls" ],"cca_host":"'${host}'", "cca_port": "'${agentport}'",  "cca_public_key_hash": "'${agenthash}'","cca_use_tls":true,
     "cca_trusted_issuer":"LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUQ1VENDQXMyZ0F3SUJBZ0lCRkRBTkJna3Foa2lHOXcwQkFRc0ZBREJpTVFzd0NRWURWUVFHRXdKVlV6RTAKTURJR0ExVUVDaE1yU1c1MFpYSnVZWFJwYjI1aGJDQkNkWE5wYm1WemN5Qk5ZV05vYVc1bGN5QkRiM0p3YjNKaApkR2x2YmpFZE1Cc0dBMVVFQXhNVVNVSk5JRWx1ZEdWeWJtRnNJRkp2YjNRZ1EwRXdIaGNOTVRZd01qSTBNRFV3Ck1EQXdXaGNOTXpVd01UQXpNRFExT1RVNVdqQmlNUXN3Q1FZRFZRUUdFd0pWVXpFME1ESUdBMVVFQ2hNclNXNTAKWlhKdVlYUnBiMjVoYkNCQ2RYTnBibVZ6Y3lCTllXTm9hVzVsY3lCRGIzSndiM0poZEdsdmJqRWRNQnNHQTFVRQpBeE1VU1VKTklFbHVkR1Z5Ym1Gc0lGSnZiM1FnUTBFd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3CmdnRUtBb0lCQVFEVUtHdWs5VG1yaTQzUjNTYXVTN2dZOXJROURYdlJ3a2xuYlcrM1RzOC9NZWI0TVBQeGV6ZEUKY3FWSnRIVmMza2luRHB6Vk1lS0pYbEI4Q0FCQnB4TUJTTEFwbUlReXdFS29WZDBIMHc2MlljM3JZdWh2MDNpWQp5Nk9vekJWMEJMNnR6WkUwVWJ2dExHdUFRWE1aN2VoenhxSXRhODVKamZGTjg2QU8ydTd4ck5GMEZZeUdIK0UwClJuNnlOaGIyNVZycXhFME9ZYlNNSUdvV2R2UzExSzRTZ1ZEcXJKOU9xSWs4TkhySUo4RWQyNFAvWVBNZUFwM2oKVTQwOUdldjF6R2N1TGRScjA5V2NrUTE0NUZaVkRiUHE0MmdjbDdxWUlDUGhaNC9lRFVVakZneHBpcGZNR2tNYgoxWCtZM2tGRGdiNEJPOFhyZGRhMlZRbzFpRFpzOEE4YkFnTUJBQUdqZ2FVd2dhSXdQd1lKWUlaSUFZYjRRZ0VOCkJESVdNRWRsYm1WeVlYUmxaQ0JpZVNCMGFHVWdVMlZqZFhKcGRIa2dVMlZ5ZG1WeUlHWnZjaUI2TDA5VElDaFMKUVVOR0tUQU9CZ05WSFE4QkFmOEVCQU1DQVFZd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVQorZDRZNVo0d0UybFJwLzE1aFVpTWZBNXYyT013SHdZRFZSMGpCQmd3Rm9BVStkNFk1WjR3RTJsUnAvMTVoVWlNCmZBNXYyT013RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQUg4N01zOHlGeUFiOW5YZXNhS2pUSGtzTGkxVktlMmkKekVTV296WUZYblJ0T2dPVzcvMHhYY2ZLKzdQVzZ4d2NPcXZUazYxZnFUR3hqK2lSeVpmMmUzRk50SUIrVC9MZwozU1pGOXN6dFBNMGpFVUVMV3ljQzhsNldQVHZ6UWpaWkJDc0YrY1diVTFueHZSTlFsdXpDc1REVUVJZlRoSklGCmNMdTBXa29RY2xVckMzZDJ0TThqY2xMUHNzYjYvT1Y4R2FKKzRteDRyaTdIYkdhVUFPdEEvVFhLUjZBdWhna1IKTlBLWWhwUFUwcS9QUmxHWGR3SlA4elhiOCtDWE1NVG5JNVVwdXI3VGM1VDNJL3gxR3FmejduMXNUUlpmc3VpUQpKNXV1YTRoejR0ZTNvVjJ0bTdMV2NOSXRIRDQzenR0QlRUeC9tNWljZzcxSkUyZ2NyMm9pbmN3PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0t"}' 
fi


# echo "Creating keystore connection to AWS"
# if [ "$(printf '%s\n' "$requiredversion" "$currentversion" | sort -V | head -n1)" = "$requiredversion" ]; then 
#    curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/keystores' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{  "name":"AWS-eu-central-1", "type":"aws_kms", "vault":{ "id":"'${vaultid}'"}, "groups":[ "AWS-eu-central-1"], "aws_region":"eu_central_1", "aws_access_key_id":"changeme", "aws_secret_access_key":"changeme"}'   
# else
#    curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/keystores' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{  "keystoreType": "AWSKMS",  "name": "'AWS-eu-central-1'",  "secretAccessKey": "chanegme", "accessKeyId": "changeme", "awsRegion": "eu-central-1", "keystoreTags": []}'   
# fi

# echo "Creating keystore connection to Azure"
# if [ "$(printf '%s\n' "$requiredversion" "$currentversion" | sort -V | head -n1)" = "$requiredversion" ]; then 
#    curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/keystores' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{  "name": "ekmf-premium-vault-01", "type":"azure_key_vault", "vault":{ "id":"'${vaultid}'"}, "groups":[ "sdfsdf"], "azure_resource_group":"ekmf-vault-resource", "azure_location":"europe_north", "azure_service_name":"ekmf-premium-vault-01", "azure_environment":"azure", "azure_service_principal_client_id":"changeme", "azure_service_principal_password":"changeme", "azure_tenant":"fcf67057-50c9-4ad4-98f3-ffca64add9e9", "azure_subscription_id":"9e468a96-19e1-49fb-994e-ad730ad76b2b" }' 
# else
#    curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/keystores' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{ "keystoreType": "AZURE","name": "ekmf-premium-vault-01","resourceGroup": "ekmf-vault-resource","location": "EUROPE_NORTH","servicePrincipalClientId": "changeme","servicePrincipalPassword": "changeme","tenant": "changeme","subscriptionId": "changeme","environment": "AZURE"   }' 
# fi

echo " "   
echo "*****************************"
echo "creating templates" 
echo "*****************************"

echo "creating PE template"
if [ "$(printf '%s\n' "$requiredversion" "$currentversion" | sort -V | head -n1)" = "$requiredversion" ]; then 
   echo "\n create active PE template: "
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/templates' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{ "vault":{ "id":"'${vaultid}'"}, "name":"PE-active-template", "description": "Template to generate active PE CIPHER keys", "key":{ "algorithm":"aes", "size":"256", "activation_date":"P0D", "expiration_date":"P1Y", "state":"active","deactivate_on_rotation":false},"keystores":[{"group":"COMMON","type":"cca","naming_scheme":"'${keyprefix}'.<env><seqno>","cca_key_type":"cipher","cca_key_words":["DECRYPT",  "ENCRYPT", "ANY-MODE", "XPRT-SYM", "XPRT-RAW", "XPRTUASY", "XPRTAASY", "NOEX-DES", "XPRT-AES", "XPRT-RSA", "V1PYLD", "XPRTCPAC"]}],"naming_scheme":"'${keyprefix}'.<env>"}'
   echo "\n create preactive PE template: "
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/templates' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{ "vault":{ "id":"'${vaultid}'"}, "name":"PE-preactive-template", "description": "Template to generate preactive PE CIPHER keys", "key":{ "algorithm":"aes", "size":"256", "activation_date":"P0D", "expiration_date":"P1Y", "state":"pre_activation","deactivate_on_rotation":false},"keystores":[{"group":"COMMON","type":"cca","naming_scheme":"'${keyprefix}'.<env><seqno>","cca_key_type":"cipher","cca_key_words":["DECRYPT",  "ENCRYPT", "ANY-MODE", "XPRT-SYM", "XPRT-RAW", "XPRTUASY", "XPRTAASY", "NOEX-DES", "XPRT-AES", "XPRT-RSA", "V1PYLD", "XPRTCPAC"]}],"naming_scheme":"'${keyprefix}'.<env>"}'
   echo "\n create template for AT-TLS connection "
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/templates' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{ "vault":{ "id":"'${vaultid}'"}, "name":"PE-active-template-'${agentprefix}'", "description": "Template to generate active PE CIPHER keys over at-tls", "key":{ "algorithm":"aes", "size":"256", "activation_date":"P0D", "expiration_date":"P1Y", "state":"active","deactivate_on_rotation":false},"keystores":[{"group":"'${agentprefix}'","type":"cca","naming_scheme":"ROBOT.'${keyprefix}'.<env><seqno>","cca_key_type":"cipher","cca_key_words":["DECRYPT",  "ENCRYPT", "ANY-MODE", "XPRT-SYM", "XPRT-RAW", "XPRTUASY", "XPRTAASY", "NOEX-DES", "XPRT-AES", "XPRT-RSA", "V1PYLD", "XPRTCPAC"]}],"naming_scheme":"ROBOT.'${keyprefix}'.<env>"}'

else
   echo "create first template: "
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/templates' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{ "name": "PE-active-template",  "keyType": "CIPHER",  "keyState": "ACTIVE",  "keyLength": 256,  "labelTemplate": "'${keyprefix}'.<env>.<seqno>",  "exportAllowed": true, "labelTags": [{ "name": "Application", "description": "Name of the application using the key."}], "keystoreTag": "'${agentprefix}'", "description": "Template to generate active PE CIPHER keys", "algorithm": "AES", "installInKeystore": true, "keystoreType": "PERVASIVE_ENCRYPTION", "advancedProperties": { "keyWords": [ "DECRYPT","ENCRYPT", "XPRTCPAC", "ANY-MODE", "XPRT-SYM", "NOEX-RAW", "NOEXUASY", "NOEXAASY", "NOEX-DES", "XPRT-AES", "NOEX-RSA", "V1PYLD"]}}' 
   echo "create second template: "
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/templates' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{ "name": "PE-preactive-template",  "keyType": "CIPHER",  "keyState": "PRE-ACTIVATION",  "keyLength": 256,  "labelTemplate": "'${keyprefix}'.<env>",  "exportAllowed": true, "labelTags": [{ "name": "Application", "description": "Name of the application using the key."}], "keystoreTag": "'${agentprefix}'", "description": "Template to generate active PE CIPHER keys", "algorithm": "AES", "installInKeystore": true, "keystoreType": "PERVASIVE_ENCRYPTION", "advancedProperties": { "keyWords": [ "DECRYPT","ENCRYPT", "XPRTCPAC", "ANY-MODE", "XPRT-SYM", "NOEX-RAW", "NOEXUASY", "NOEXAASY", "NOEX-DES", "XPRT-AES", "NOEX-RSA", "V1PYLD"]}}' 
fi

# echo "creating AWS template"
# if [ "$(printf '%s\n' "$requiredversion" "$currentversion" | sort -V | head -n1)" = "$requiredversion" ]; then 
#    curl -k --silent 'https://'${host}':'${ekmfport}'/api/v4/templates' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{  "vault":{ "id":"'${vaultid}'"}, "name": "AWS-active-template",  "description": "Template to generate active AWS keys", "key":{ "algorithm":"aes", "size":"256", "activation_date":"P0D", "expiration_date":"P1Y", "state":"active"}, "naming_scheme": "aws-<env>-<seqno>", "keystores":[{ "group":"AWS-eu-central-1", "type":"aws_kms"}]}' 
# else
#    curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/templates' --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' -X POST -d '{ "name": "AWS-active-template",  "keyState": "ACTIVE",  "keyLength": 256,  "keyType": "DATA" , "labelTemplate": "aws-<env>-<seqno>",  "keystoreTag": "AWS-eu-central-1", "description": "Template to generate active AWS keys", "algorithm": "AES", "installInKeystore": true, "keystoreType": "AMAZON_WEB_SERVICES", "advancedProperties": { "keyWords": []}}' 
# fi

echo "Test templates were created"