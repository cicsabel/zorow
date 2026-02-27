ekmfport=${instance-SERVER_PORT_TLS}
echo "ekmf port:" $ekmfport
keyprefix=${instance-KEY_PREFIX}
echo "ekmf keyprefix:" $keyprefix
currentversion=${instance-SERVER_VERSION}
requiredversion="3.1.0.0"

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


###################################################################################
# key hierarchy setup 
###################################################################################
echo "*****************************"
echo "key hierarchy setup" 
echo "*****************************"

etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.integrity.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
if [ -z "$etag" ]; then
   echo "no etag found for integrity, using default";
   etag="RU1QVFk=";
fi
echo "setting integrity key to "${keyprefix}".INTEGRITY"
curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.integrity.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json'  --header 'Content-Type: application/json'  --header 'If-Match: '${etag}''  -X PATCH  -d '{  "value": "'${keyprefix}'.INTEGRITY" }' 

if [ "$(printf '%s\n' "$requiredversion" "$currentversion" | sort -V | head -n1)" = "$requiredversion" ]; then 
   #version 3.1 - secrets before DRK 
   etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.secrets-encryption.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
   if [ -z "$etag" ]; then
      echo "no etag found for secrets, using default";
      etag="RU1QVFk=";
   fi
   echo "setting secrets key to "${keyprefix}".SECRETS"
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.secrets-encryption.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'If-Match: '${etag}''     -X PATCH -d '{  "value": "'${keyprefix}'.SECRETS" }' 

   etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.recovery.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
   echo "setting recovery key to ${instance-UKO_RECOVERY_KEY}"
   if [ -z "$etag" ]; then
      echo "no etag found for recovery, using default";
      etag="RU1QVFk=";
   fi
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.recovery.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'If-Match: '${etag}''     -X PATCH -d '{ "value": "${instance-UKO_RECOVERY_KEY}" }'   
else
   # version 2.1.0.x - DRK before secrets
   etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.recovery.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
   echo "setting recovery key to ${instance-UKO_RECOVERY_KEY}"
   if [ -z "$etag" ]; then
      echo "no etag found for recovery, using default";
      etag="RU1QVFk=";
   fi
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.recovery.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'If-Match: '${etag}''     -X PATCH -d '{ "value": "${instance-UKO_RECOVERY_KEY}" }'

   etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.secrets-encryption.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
   if [ -z "$etag" ]; then
      echo "no etag found for secrets, using default";
      etag="RU1QVFk=";
   fi
   echo "setting secrets key to "${keyprefix}".SECRETS"
   curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.secrets-encryption.label'     --cert mtls-client.crt --key mtls-client.key --header 'ekmf-mtls: true' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'If-Match: '${etag}''     -X PATCH -d '{  "value": "'${keyprefix}'.SECRETS" }' 
# else
#    echo "no valid version";
#    exit;
fi

etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.identity.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
echo "setting identity key to "${keyprefix}".IDENTITY"
if [ -z "$etag" ]; then
   echo "no etag found for identity, using default";
   etag="RU1QVFk=";
fi
curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.key.identity.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json'  --header 'Content-Type: application/json'  --header 'If-Match: '${etag}''  -X PATCH  -d '{  "value": "'${keyprefix}'.IDENTITY" }' 

etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.kek.rsa.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
echo "setting RSA KEK to "${keyprefix}".KEKRSA"
if [ -z "$etag" ]; then
   echo "no etag found for rsa kek, using default";
   etag="RU1QVFk=";
fi
curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.kek.rsa.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json'  --header 'Content-Type: application/json'  --header 'If-Match: '${etag}''  -X PATCH  -d '{  "value": "'${keyprefix}'.KEKRSA" }' 

etag=$(curl -k --silent --head 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.kek.aes.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json' | grep ETag | sed -E 's/.*ETag: ([^\$])/\1/')
echo "setting AES KEK to "${keyprefix}".KEKAES"
if [ -z "$etag" ]; then
   echo "no etag found for aes kek, using default";
   etag="RU1QVFk=";
fi
curl -k --silent 'https://'${host}':'${ekmfport}'/api/v2/system/settings/ekmf.web.kek.aes.label'  --cert mtls-client.crt  --key mtls-client.key  --header 'ekmf-mtls: true'  --header 'Accept: application/json'  --header 'Content-Type: application/json'  --header 'If-Match: '${etag}''  -X PATCH  -d '{  "value": "'${keyprefix}'.KEKAES" }' 