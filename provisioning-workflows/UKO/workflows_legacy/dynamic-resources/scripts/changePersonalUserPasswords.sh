VAULT_ADMIN="${instance-UKO_VAULT_ADMIN}"
KEY_ADMIN="${instance-UKO_KEY_ADMIN}"
KEY_CUSTODIAN1="${instance-UKO_KEY_CUSTODIAN1}"
KEY_CUSTODIAN2="${instance-UKO_KEY_CUSTODIAN2}"
UKO_AUDITOR="${instance-UKO_AUDITOR}"

userid=${instance-UKO_ADMIN_SECURITY}
#userid=${_step-stepOwnerUpper}

if [ -d "/u/${userid}" ]  
then
   cd /u/${userid}/mtls
else
   useridLC=$(echo "${userid}" | tr '[:upper:]' '[:lower:]')
   cd /u/${useridLC}/mtls
fi

host=$(hostname | tr [:upper:] [:lower:]) 

echo "setting passwords for the test users"
echo "setting vault admin password:"
curl -k --silent -X PUT -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key -d '{ "userID": "'${VAULT_ADMIN}'", "oldPwd": "pass4youpass4you", "newPwd": "passyou7passyou7"}' 'https://'${host}':32070/zosmf/services/authenticate'
echo "setting key admin password:"
curl -k --silent -X PUT -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key -d '{ "userID": "'${KEY_ADMIN}'", "oldPwd": "pass4youpass4you", "newPwd": "passyou7passyou7"}' 'https://'${host}':32070/zosmf/services/authenticate'
echo "setting key custodian 1 password:"
curl -k --silent -X PUT -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key -d '{ "userID": "'${KEY_CUSTODIAN1}'", "oldPwd": "pass4youpass4you", "newPwd": "passyou7passyou7"}' 'https://'${host}':32070/zosmf/services/authenticate'
echo "setting key custodian 2 password:"
curl -k --silent -X PUT -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key -d '{ "userID": "'${KEY_CUSTODIAN2}'", "oldPwd": "pass4youpass4you", "newPwd": "passyou7passyou7"}' 'https://'${host}':32070/zosmf/services/authenticate'
echo "setting auditor password:"
curl -k --silent -X PUT -H 'X-CSRF-ZOSMF-HEADER: zosmf' -H 'Accept: application/json' --cert mtls-client.crt  --key mtls-client.key -d '{ "userID": "'${UKO_AUDITOR}'", "oldPwd": "pass4youpass4you", "newPwd": "passyou7passyou7"}' 'https://'${host}':32070/zosmf/services/authenticate'
