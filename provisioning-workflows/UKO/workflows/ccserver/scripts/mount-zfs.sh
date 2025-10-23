#
# /******************************************************************************/
# /* Copyright Contributors to the zOS-Workflow Project.                        */
# /* SPDX-License-Identifier: Apache-2.0                                        */
# /******************************************************************************/

#
#   STATUS = @STATUS@
#
# FILE : mount-zfs.sh
#
#
## Set the $ sign for use in the script
#set ( $d = "$")
#set ($zfs = "${instance-SERVER_FILE_SYSTEM_HLQ}.${instance-SERVER_STC_NAME}")

if [ ! -d "${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}" ]; then
    echo "Creating server directory ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}"
    mkdir -p ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}
    if [ $? -gt 0 ]; then 
        echo "ERROR: Could not create directory" >&amp;2;
        exit "2"; 
    fi
    echo "changing access to 755"
    chmod 755 ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}
fi

# Query information about the main mountpoint
df_out=${d}(df ${instance-SERVER_USER_DIR})

echo "df_out set to ${d}df_out"

# Split to obtain the data set for the mount point
dataset=${d}(echo ${d}df_out | sed -e 's/.*(//' | sed -e 's/).*//')

echo "dataset set to ${d}dataset"

# Using the data set restrict using grep in the mount -qv comment
mount_info=${d}(mount -qv ${instance-SERVER_USER_DIR} | grep ${d}dataset)

echo "mount_info set to ${d}mount_info"

# Look at the 5 byte to work out what to do next
parent_mount=${d}(expr substr "${d}mount_info" 5 1)

echo "parent_mount set to ${d}parent_mount"

# Decide the automount value
case ${d}parent_mount in
   "A")
       echo "Automount (yes)"
       mountvalue="yes"
       ;;
   "U")
       echo "Unmount (unmount)"
       mountvalue="unmount"
       ;;
   "-")
       echo "NoAutomount (no)"
       mountvalue="no"
       ;;
esac

echo "mountvalue ${d}mountvalue"

if [ -z "${mountvalue}" ]; then
    echo "Running command: mount -t ZFS -f ${zfs} ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}"
    mount -t ZFS -f ${zfs} ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}
else
    echo "Running command: mount -t ZFS -a ${d}mountvalue -f ${zfs} ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}"
    mount -t ZFS -a ${d}mountvalue -f ${zfs} ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}
fi

rc=${d}?
if [ ${d}rc -gt 0 ]; then
  echo "Failed to mount the directory see STDERR with RC ${d}rc"
  exit ${d}rc
fi

echo "Creating directories / files"

mkdir ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}/PROVISION_OK
chmod 755 ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}
#if(${instance-SERVER_STC_GROUP} != "" && ${instance-SERVER_STC_GROUP})
chown ${instance-SERVER_STC_USER}:${instance-SERVER_STC_GROUP} ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}
#else
#if(${instance-SERVER_STC_USER} != ${instance-CC_ADMIN_ZFS})
chown ${instance-SERVER_STC_USER} ${instance-SERVER_USER_DIR}/servers/${instance-SERVER_STC_NAME}
#end
#end

# ##########################

#if(${instance-SERVER_OUTPUT_DIR} && $!{instance-SERVER_OUTPUT_DIR} != "")
# mount SERVER_OUTPUT_DIR if specified
#set ($zfs = "${instance-SERVER_FILE_SYSTEM_HLQ}.${instance-SERVER_STC_NAME}.OUTPUT")

if [ ! -d "${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}" ]; then
    echo "Creating output directory ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}"
    mkdir -p ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}
    if [ $? -gt 0 ]; then 
        echo "ERROR: Could not create directory" >&amp;2;
        exit "2"; 
    fi
    echo "changing access to 755"
    chmod 755 ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}
fi

# Query information about the main mountpoint
df_out=${d}(df ${instance-SERVER_OUTPUT_DIR})

echo "df_out set to ${d}df_out"

# Split to obtain the data set for the mount point
dataset=${d}(echo ${d}df_out | sed -e 's/.*(//' | sed -e 's/).*//')

echo "dataset set to ${d}dataset"

# Using the data set restrict using grep in the mount -qv comment
mount_info=${d}(mount -qv ${instance-SERVER_OUTPUT_DIR} | grep ${d}dataset)

echo "mount_info set to ${d}mount_info"

# Look at the 5 byte to work out what to do next
parent_mount=${d}(expr substr "${d}mount_info" 5 1)

echo "parent_mount set to ${d}parent_mount"

# Decide the automount value
case ${d}parent_mount in
   "A")
       echo "Automount (yes)"
       mountvalue="yes"
       ;;
   "U")
       echo "Unmount (unmount)"
       mountvalue="unmount"
       ;;
   "-")
       echo "NoAutomount (no)"
       mountvalue="no"
       ;;
esac

echo "mountvalue ${d}mountvalue"

if [ -z "${mountvalue}" ]; then
    echo "Running command: mount -t ZFS -f ${zfs} ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}"
    mount -t ZFS -f ${zfs} ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}
else
    echo "Running command: mount -t ZFS -a ${d}mountvalue -f ${zfs} ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}"
    mount -t ZFS -a ${d}mountvalue -f ${zfs} ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}
fi

rc=${d}?
if [ ${d}rc -gt 0 ]; then
  echo "Failed to mount the output directory see STDERR with RC ${d}rc"
  exit ${d}rc
fi
mkdir ${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}/PROVISION_OK

#end