userid=${instance-UKO_ADMIN_SECURITY}
if [ -d "/u/${userid}" ]  
then
      logfolder="/u/${userid}"
else
      useridLC=$(echo "${userid}" | tr '[:upper:]' '[:lower:]')
      logfolder="/u/${useridLC}"
fi 

unsortedvaultfile="${logfolder}/${instance-SERVER_STC_NAME}-vaults.log"
vaultfile="${logfolder}/${instance-SERVER_STC_NAME}-sortedvaults.log"
templatefile="${instance-TEMP_DIR}/${instance-SERVER_STC_NAME}-deleteRolesVaultTemplate.rexx"
finalscript="${logfolder}/${instance-SERVER_STC_NAME}-deleteRolesVault.rexx"

rm ${finalscript}

# Create the initial script to delete the profiles for the vault that this instance was provisioned with
# ensure that the initial vault ID wasn't ekmfwebv2
if [ "${instance-UKO_VAULT_ID}" != "ekmfwebv2" ]; then
    sed 's#^[ \#]*VAULT_ID=.*#VAULT_ID="'${instance-UKO_VAULT_ID}'"#g' ${templatefile} >> ${finalscript};
fi

# if the vaultfile was created, then additional vault-specific profiles need to be deleted
if [ -f "${unsortedvaultfile}" ]; then 
    # remove duplicates from the vaults file
    sort -u ${unsortedvaultfile} > ${vaultfile}
    echo "create deletion script for the following vaults:"
    cat ${vaultfile}
    # for each vault that had profiles created, add deletion script to the final file
   while read i
   do
      echo "i is now $i"
      if [ "$i" != "ekmfwebv2" ]; then
         echo "create script to delete profiles for vault $i"
         sed 's#^[ \#]*VAULT_ID=.*#VAULT_ID="'$i'"#g' ${templatefile} >> ${finalscript};
         echo "\n" >> ${finalscript}
      else
         echo "EKMF Web legacy profiles will be deleted separately"
      fi      
   done < ${vaultfile}

fi

# add exit command to ensure at least a valid script is created
echo "exit 0" >> ${finalscript}

chmod 700 ${finalscript}
