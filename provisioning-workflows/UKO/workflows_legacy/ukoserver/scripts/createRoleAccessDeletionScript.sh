
userid=${instance-UKO_ADMIN_SECURITY}
if [ -d "/u/${userid}" ]  
then
      logfolder="/u/${userid}"
else
      useridLC=$(echo "${userid}" | tr '[:upper:]' '[:lower:]')
      logfolder="/u/${useridLC}"
fi 

templatefile="${instance-TEMP_DIR}/${instance-SERVER_STC_NAME}-deleteRoleAccessTemplate.rexx"
finalscript="${logfolder}/${instance-SERVER_STC_NAME}-deleteRoleAccess.rexx"
echo "copying from ${templatefile} to ${finalscript}"
cat ${templatefile} >> ${finalscript}
echo "\n" >> ${finalscript}
rm ${templatefile}

chmod 700 ${finalscript}
