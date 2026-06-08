#!/bin/sh
#########################################
# Setup CC ACSP Server Environment
# - Links JCCA libraries with ICSF auto-detection
# - Creates server configuration
#########################################

# Parameters (passed as environment variables from workflow)
# ${instance-SERVER_USER_DIR}
# ${instance-SERVER_STC_NAME}
# ${instance-SERVER_STC_USER}
# ${instance-SERVER_STC_GROUP}
# ${instance-SERVER_INSTALL_DIR}
# ${instance-SERVER_OUTPUT_DIR}
# ${instance-ICSF_RELEASE} (optional - fallback if auto-detection fails)
# ${instance-SERVER_TLS_KEY_STORE_KEY_RING}
# ${instance-SERVER_TLS_KEY_STORE_OWNER} (optional)
# ${instance-SERVER_PORT_NOTLS} (optional)
# ${instance-SERVER_PORT_TLS} (optional)
# ${instance-CONFIGURATION_PORT} (optional)
# ${instance-SAF_PROFILE_PREFIX}
# ${instance-ACSP_AUTH_MAP_SVC} (optional)

echo "=========================================="
echo "CC ACSP Server Environment Setup"
echo "=========================================="

#########################################
# Part 1: Link JCCA Libraries
#########################################

echo ""
echo "Part 1: Linking JCCA libraries"
echo "------------------------------------------"

cd ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}

echo "Creating new bin folder"
mkdir bin
echo "Changing ownership of the bin folder to the server user and group"
chown ${instance-SERVER_STC_USER}:${instance-SERVER_STC_GROUP} bin

cd bin

echo "Creating symbolic links for JCCA libraries"

# Determine ICSF_RELEASE to use
# ALWAYS try to auto-detect first, even if ICSF_RELEASE is provided
DETECTED_ICSF_RELEASE=""

echo "Attempting to auto-detect ICSF release from z/OS system..."

# Try to query ICSF using operator command
echo "Querying ICSF using D ICSF operator command..."
ICSF_OUTPUT=$(opercmd "D ICSF" 2>&1)
OPERCMD_RC=$?

if [ $OPERCMD_RC -eq 0 ]; then
    # Look for RELEASE column with HCR77xx pattern in the output
    # Format: SYSNAME   RELEASE  DOM  CHG_DATE
    #         MV4S      HCR77F0  006  10/27/25
    DETECTED_ICSF_RELEASE=$(echo "$ICSF_OUTPUT" | grep -E 'HCR77[A-Z][0-9]' | awk '{for(i=1;i<=NF;i++) if($i ~ /^HCR77/) print $i}' | head -1)
    
    if [ -n "$DETECTED_ICSF_RELEASE" ]; then
        echo "Successfully auto-detected ICSF release from D ICSF command: $DETECTED_ICSF_RELEASE"
    else
        echo "D ICSF command succeeded but could not extract ICSF release"
        echo "Output was:"
        echo "$ICSF_OUTPUT"
    fi
else
    echo "D ICSF command failed (RC=$OPERCMD_RC) or not authorized"
fi

# If auto-detection failed, use the provided ICSF_RELEASE variable
if [ -z "$DETECTED_ICSF_RELEASE" ]; then
    if [ -n "${instance-ICSF_RELEASE}" ]; then
        DETECTED_ICSF_RELEASE="${instance-ICSF_RELEASE}"
        echo "Using provided ICSF_RELEASE: $DETECTED_ICSF_RELEASE"
    else
        echo "ERROR: Could not auto-detect ICSF release and no ICSF_RELEASE provided"
        echo "Available JCCA libraries in ${instance-SERVER_INSTALL_DIR}/bin/:"
        ls -1 ${instance-SERVER_INSTALL_DIR}/bin/libjcca-HCR*.so.* 2>/dev/null | sed 's/.*libjcca-\([^.]*\)\.so\..*/  \1/' | sort -u
        echo ""
        echo "Please provide ICSF_RELEASE variable (e.g., HCR77F0) in your workflow properties"
        exit 1
    fi
fi

# Find the JCCA library for the detected/provided ICSF release
JCCA_FILE=$(ls ${instance-SERVER_INSTALL_DIR}/bin/libjcca-${DETECTED_ICSF_RELEASE}.so.* 2>/dev/null | head -1)

# If the detected version is not available, fall back to the latest available 64-bit version
if [ -z "$JCCA_FILE" ]; then
    echo "WARNING: Could not find libjcca-${DETECTED_ICSF_RELEASE}.so.* in ${instance-SERVER_INSTALL_DIR}/bin/"
    echo "Attempting to use the latest available 64-bit JCCA library..."
    
    # Get list of available 64-bit versions (exclude -31 suffix for 31-bit versions)
    # Use temp file approach for reliability in z/OSMF workflow shell environment
    # Complex pipelines in command substitution can fail silently on z/OS
    TEMP_FILE="${instance-TEMP_DIR}/jcca_versions_$$.txt"
    
    ls -1 ${instance-SERVER_INSTALL_DIR}/bin/libjcca-HCR*.so.* 2>/dev/null > "$TEMP_FILE"
    grep -v -- '-31.so.' "$TEMP_FILE" > "${TEMP_FILE}.tmp" && mv "${TEMP_FILE}.tmp" "$TEMP_FILE"
    sed 's/.*libjcca-\(HCR[^.]*\)\.so\..*/\1/' "$TEMP_FILE" > "${TEMP_FILE}.tmp" && mv "${TEMP_FILE}.tmp" "$TEMP_FILE"
    sort -u -r "$TEMP_FILE" > "${TEMP_FILE}.tmp" && mv "${TEMP_FILE}.tmp" "$TEMP_FILE"
    
    FALLBACK_RELEASE=$(head -1 "$TEMP_FILE" 2>/dev/null)
    rm -f "$TEMP_FILE" "${TEMP_FILE}.tmp"
    
    if [ -n "$FALLBACK_RELEASE" ]; then
        echo "Found fallback ICSF release: $FALLBACK_RELEASE"
        DETECTED_ICSF_RELEASE="$FALLBACK_RELEASE"
        JCCA_FILE=$(ls ${instance-SERVER_INSTALL_DIR}/bin/libjcca-${DETECTED_ICSF_RELEASE}.so.* 2>/dev/null | head -1)
    fi
    
    if [ -z "$JCCA_FILE" ]; then
        echo "ERROR: Could not find any suitable 64-bit JCCA library in ${instance-SERVER_INSTALL_DIR}/bin/"
        echo "Available JCCA libraries:"
        ls -1 ${instance-SERVER_INSTALL_DIR}/bin/libjcca-HCR*.so.* 2>/dev/null | sed 's/.*libjcca-\([^.]*\)\.so\..*/  \1/' | sort -u
        exit 1
    fi
fi

echo "Using ICSF release: $DETECTED_ICSF_RELEASE"
echo "Found JCCA library: $JCCA_FILE"
ln -s "$JCCA_FILE" libjcca.so

# Verify and create link for lib${ICSF_RELEASE}.so
if [ ! -f "${instance-SERVER_INSTALL_DIR}/bin/lib${DETECTED_ICSF_RELEASE}.so" ]; then
    echo "ERROR: Expected library lib${DETECTED_ICSF_RELEASE}.so not found in ${instance-SERVER_INSTALL_DIR}/bin/"
    exit 1
fi
ln -s ${instance-SERVER_INSTALL_DIR}/bin/lib${DETECTED_ICSF_RELEASE}.so lib${DETECTED_ICSF_RELEASE}.so

ln -s ${instance-SERVER_INSTALL_DIR}/bin/libacspzsec6.so libacspzsec6.so

echo "Successfully created symbolic links for JCCA libraries"

echo "Symbolic links created in bin directory, result:"
ls -al

echo "Linking to the lib and libmon installation folders"
cd ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}
ln -s ${instance-SERVER_INSTALL_DIR}/lib lib
ln -s ${instance-SERVER_INSTALL_DIR}/libmon libmon

echo "Successfully completed library linking"

#########################################
# Part 2: Create Server Configuration
#########################################

echo ""
echo "Part 2: Creating server configuration"
echo "------------------------------------------"

echo "Creating the config directory"
mkdir ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}/config

echo "Copying log4j2.properties"
cp ${instance-SERVER_INSTALL_DIR}/config/log4j2.properties ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}/config/log4j2.properties

# Build sed string for acsp.server.properties customization
sedstring=""

# remove unused services
#service.all = tcp-dir,tls-dir,tcp-all,tls-all 
sedstring="${sedstring} s#^[ \#]*service.all.*#service.all = tcp-all,tls-all#g;"

# Configure TCP port if provided
#if(${instance-SERVER_PORT_NOTLS} && ${instance-SERVER_PORT_NOTLS} != "")
    sedstring="${sedstring} s#^[ \#]*port.tcp-all.*#port.tcp-all.${instance-SERVER_PORT_NOTLS}=tcp:acp,cca,ccc#g;"
#end 

# Configure TLS port if provided
#if(${instance-SERVER_PORT_TLS} && ${instance-SERVER_PORT_TLS} != "")
    sedstring="${sedstring} s#^[ \#]*port.tls-all.*#port.tls-all.${instance-SERVER_PORT_TLS}=tls:acp,cca,ccc#g;"
#end 

# Configure monitoring port if provided
#monitor.agent.port=9050
#if(${instance-CONFIGURATION_PORT} && ${instance-CONFIGURATION_PORT} != "")
    sedstring="${sedstring} s#^[ \#]*monitor.agent.port=.*#monitor.agent.port=${instance-CONFIGURATION_PORT}#g;"
#end 

# Select jCCA JNI Library to use (use auto-detected ICSF release)
# hsm.cca.jccalib=HCR77D2
echo "Configuring ICSF release in acsp.server.properties: $DETECTED_ICSF_RELEASE"
sedstring="${sedstring} s#^[ \#]*hsm.cca.jccalib=.*#hsm.cca.jccalib=${DETECTED_ICSF_RELEASE}#g;"

# ssl.keyring.name=ACSP-IVP-KEYRING
sedstring="${sedstring} s#^[ \#]*ssl.keyring.name=.*#ssl.keyring.name=${instance-SERVER_TLS_KEY_STORE_KEY_RING}#g;"

# setting the key ring user name
#if(${instance-SERVER_TLS_KEY_STORE_OWNER} && ${instance-SERVER_TLS_KEY_STORE_OWNER} != "")
    sedstring="${sedstring} s#^[ \#]*ssl.keyring.user=.*#ssl.keyring.user=${instance-SERVER_TLS_KEY_STORE_OWNER}#g;"
#else
    sedstring="${sedstring} s#^[ \#]*ssl.keyring.user=.*#ssl.keyring.user=${instance-SERVER_STC_USER}#g;"
#end

# server.persistent.data.path = /var/acsp 
sedstring="${sedstring} s#^[ \#]*server.persistent.data.path.*#server.persistent.data.path=${instance-SERVER_OUTPUT_DIR}/${instance-SERVER_STC_NAME}#g;"
sedstring="${sedstring} s#^[ \#]*log4j2.configuration=.*#log4j2.configuration=${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}/config/log4j2.properties#g;"

# define application id for ACSP, default is ACSPPROD 
sedstring="${sedstring} s#^[ \#]*auth.map.applid=.*#auth.map.applid=${instance-SAF_PROFILE_PREFIX}#g;"

#if(${instance-ACSP_AUTH_MAP_SVC} && ${instance-ACSP_AUTH_MAP_SVC} != "")
    sedstring="${sedstring} s#^[ \#]*auth.map.svc=.*#auth.map.svc=${instance-ACSP_AUTH_MAP_SVC}#g;"
#end 

# set the default instance to JCECCARACFKS
sedstring="${sedstring} s#^[ \#]*ssl.keystore.instance=.*#ssl.keystore.instance=JCECCARACFKS#g;"
# keep the original hardware provider for now
sedstring="${sedstring} s#^[ \#]*ssl.keystore.provider=.*#ssl.keystore.provider=com.ibm.crypto.hdwrCCA.provider.IBMJCECCA,2#g"

echo "Copying acsp.server.properties and replacing values"
sed -e "$sedstring" ${instance-SERVER_INSTALL_DIR}/config/acsp.server.properties > ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}/config/acsp.server.properties;

echo "Changing ownership of the server config directory and its content"
chown -R ${instance-SERVER_STC_USER}:${instance-SERVER_STC_GROUP} ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}/config

echo ""
echo "=========================================="
echo "CC ACSP Server Environment Setup Complete"
echo "=========================================="
echo "ICSF Release: $DETECTED_ICSF_RELEASE"
echo "Server directory: ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}"
echo "Configuration: ${instance-SERVER_USER_DIR}/${instance-SERVER_STC_NAME}/config"
echo "=========================================="
