#########################################
# creating the sed string 
#########################################

sedstring="";

#  /* FOR SQLID, SCHEMA                  */
#  "CHANGE 'KMGSQLID' 'KMGSQLID' ALL"
#  "CHANGE 'KRYTEST1' 'KRYTEST1' ALL"

#if(${instance-DB_CURRENT_SQLID} && ${instance-DB_CURRENT_SQLID} != "")
echo "the current SQLID will be set to ${instance-DB_CURRENT_SQLID}"
sedstring="${sedstring} s/KMGSQLID/${instance-DB_CURRENT_SQLID}/g;"
#else
echo "the current SQLID will be set to ${_step-stepOwnerUpper}"
sedstring="${sedstring} s/KMGSQLID/${_step-stepOwnerUpper}/g;"
#end

sedstring="${sedstring} s/KRYTEST1/${instance-DB_CURRENT_SCHEMA}/g;"

#  /* FOR DATABASE, STORAGE GROUP */
#  "CHANGE 'DKMG0001' 'DKMG0001' ALL"
sedstring="${sedstring} s/DKMG0001/${instance-DB_NAME_UKO}/g;"
#  "CHANGE 'DKMGPE1'  'DKMGPE1'  ALL"
sedstring="${sedstring} s/DKMGPE1/${instance-DB_NAME_DATASET_ENCRYPTION_STATUS}/g;"
#  "CHANGE 'GKMG0001' 'GKMG0001' ALL"
sedstring="${sedstring} s/GKMG0001/${instance-DB_STOGROUP}/g;"

#  /* FOR tablespace bufferpools */
#  "CHANGE 'BUFFERPOOL BP8K0' 'BUFFERPOOL BP8K0' ALL"
sedstring="${sedstring} s/BP8K0/${instance-DB_BUFFERPOOL_TABLESPACE_8K}/g;"
sedstring="${sedstring} s/BP32K/${instance-DB_BUFFERPOOL_TABLESPACE_32K}/g;"

#  /* FOR DATABASE bufferpools */
#  "CHANGE 'BUFFERPOOL BP1' 'BUFFERPOOL BP1' ALL"
#  "CHANGE 'INDEXBP    BP2' 'INDEXBP    BP2' ALL"
sedstring="${sedstring} s/BP1/${instance-DB_BUFFERPOOL_DEFAULT}/g;"
sedstring="${sedstring} s/BP2/${instance-DB_BUFFERPOOL_INDEX}/g;"

#  /* MISC   */
#  "CHANGE 'PRIQTY 28 SECQTY 28' 'PRIQTY 28 SECQTY 28' ALL"
#  "CHANGE 'CLOSE NO'            'CLOSE NO'            ALL"
#  "CHANGE 'MAXPARTITIONS 128' 'MAXPARTITIONS 128'     ALL"
#  "CHANGE 'FREEPAGE 10'       'FREEPAGE 10'           ALL"
#  "CHANGE 'PCTFREE 10'        'PCTFREE 10'            ALL"

# echo "sedstring: $sedstring"
# echo "instance variables: ${instance-DB_NAME_UKO}, ${instance-DB_NAME_DATASET_ENCRYPTION_STATUS}, ${instance-DB_BUFFERPOOL_TABLESPACE_8K}, ${instance-DB_STOGROUP}"


#########################################
# creating the list of DDLs
#########################################

echo "removing existing ddl file in case it existed from previous run"
rm -f ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.ddl

for i in `cat ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.files`; do
  # copy the current DDL
  cp "//'${instance-DB_DATASET_INSTALL_HLQ}($i)'" ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.tmp.ddl
  #check whether the current ddl contains database creation
  if (grep -Fq "CREATE DATABASE" ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.tmp.ddl)
  then
      echo "$i contains database creation and will not be added";
  else
    echo "DDL added to list of updates: $i"
    sed -e "$sedstring" ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.tmp.ddl >> ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.unconverted.ddl
    echo "\nCOMMIT;\n" >> ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.unconverted.ddl;   
  fi
  rm ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.tmp.ddl
  
done;

echo "convert the current DDL from IBM-037 to ${instance-DB_CODEPAGE}"
iconv -f IBM-037 -t ${instance-DB_CODEPAGE} ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.unconverted.ddl > ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.ddl

rm ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.unconverted.ddl

echo "Changing permissions of zosmf-${_workflow-workflowKey}.ddl to ensure other user IDs can read it"
chmod 644 ${instance-TEMP_DIR}/zosmf-${_workflow-workflowKey}.ddl