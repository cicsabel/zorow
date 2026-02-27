cd /Users/isabelarnold/Documents/git/ekmf-workflow/
rm -R ../zorow/provisioning-workflows/UKO
mkdir ../zorow/provisioning-workflows/UKO
cp -R * ../zorow/provisioning-workflows/UKO
cd ../zorow/provisioning-workflows/UKO

rm -R ./travis
rm -R ./templates
rm -R ./workflowsnew
rm ./zapp.yaml
rm ./sonar-project.properties
rm ./properties/uko_template_db2v13.properties
rm ./properties/uko_template_db2v12.properties
rm ./properties/ccc_groups.properties
rm ./properties/cc_template.properties
rm ./properties/ccacsp_template.properties
rm ./properties/ccacsp_template_sharedkeyring.properties

rm -R ./workflows/virtual-sysprog
rm -R ./workflows/workflow
rm -R ./workflows/dynamic-resources
rm -R ./workflows/cc-dynamic-resources
#rm -R ./workflows/ukoangel

rm -R ./workflows/ukoserver/checkStatus.xml
rm -R ./workflows/ccserver/checkStatus.xml


# xml will not work if those files are missing 
# rm -R ./workflows/ukoagent/extensions/image_properties.xml
# rm -R ./workflows/ukodb/extensions/image_properties.xml
# rm -R ./workflows/ukokeyring/extensions/image_properties.xml
# rm -R ./workflows/ukoserver/extensions/image_properties.xml
# rm -R ./workflows/ukousers/extensions/image_properties.xml

rm -R ./workflows/ukoagent/deprovision.xml
rm -R ./workflows/ukodb/deprovision.xml
rm -R ./workflows/ukodb/updateDatabaseLegacy.xml
rm -R ./workflows/ukokeyring/deprovision.xml
rm -R ./workflows/ukoserver/deprovision.xml
rm -R ./workflows/ukoangel/deprovision.xml

rm -R ./workflows/ukoserver/grantVaultAccessInternal.xml
rm -R ./workflows/ukoserver/scripts/createRoleAccessDeletionScript.sh
rm -R ./workflows/ukoserver/scripts/createVaultDeletionScript.sh

rm -R ./workflows/ukousers/deprovision.xml
rm -R ./workflows/ukousers/jcl

rm -R ./workflows/cckeyring/deprovision.xml
rm -R ./workflows/ccagent/deprovision.xml
rm -R ./workflows/ccserver/deprovision.xml
rm -R ./workflows/ccserver/switchMsdkeKeyServer.xml
rm -R ./workflows/ccserver/jcl/database-grant-access-switch.jcl

rm -R ./workflows/ccusers/deprovision.xml
rm -R ./workflows/ccusers/jcl

ls -l
pax -wvf ./uko-workflows.pax *