# Workflows for Unified Key Orchestrator for IBM z/OS

A detailed documentation of how to use the installation workflows can be found in the [UKO for z/OS installation documentation](https://www.ibm.com/docs/en/ukofz/3.1?topic=installation).

## Workflow Structure

The workflows are organized in a flat structure in the `workflows/` directory. Legacy workflows (old hierarchical structure) are available in `workflows_legacy/` for reference.

## Properties Files

Sample properties files are available in the `properties/` directory:

**Installation Properties:**
- `uko_install.properties` - For UKO base server installation
- `cc_liberty_install.properties` - For CC Liberty-based servers (Crypto Connect, MSDKE, CAT)
- `cc_acsp_install.properties` - For CC ACSP server installation

**Migration Properties:**
- `uko_migration.properties` - For UKO server migration
- `cc_liberty_migration.properties` - For CC Liberty server migration

Use the `migrateProps.sh` script to migrate existing properties files to the new variable naming conventions.

### Main Provisioning Workflows

**UKO Server:**
- `provisionUkoServer.xml` - Complete UKO server provisioning including users, keyring, database, and Liberty server configuration
  - Consolidates functionality from legacy workflows: ukousers, ukokeyring, ukodb, and ukoserver
  - See [UKO installation documentation](https://www.ibm.com/docs/en/ukofz/3.1?topic=installation-installing-uko-base)

**UKO Agent:**
- `provisionUkoAgent.xml` - UKO agent provisioning for managing keys in z/OS keystores
  - See [Agent installation documentation](https://www.ibm.com/docs/en/ukofz/3.1?topic=agent-setup-uko-key-management)

**Crypto Connect Server:**
- `provisionCcServer.xml` - Crypto Connect server provisioning (for CAT, MSDKE, Crypto Connect)
  - Consolidates functionality from legacy workflows: ccusers and cckeyring
- `provisionCcacsp.xml` - ACSP server provisioning
  - Consolidates functionality from legacy workflows: ccusers and cckeyring

**Angel Process:**
- `provisionAngel.xml` - Liberty angel process (required before Liberty server can start, not needed for ACSP)

**CAT Agent:**
- `provisionCatAgent.xml` - CAT agent provisioning

### Update/Migration Workflows

- `updateUkoServer.xml` - Migrate UKO server to latest version
- `updateCcServer.xml` - Migrate Crypto Connect server to latest version
- `updateDatabase.xml` - Migrate database to latest version

### Utility Workflows

- `refreshDatasetDashboard.xml` - Collect information from global catalog to populate the [Data sets dashboard](https://www.ibm.com/docs/en/ukofz/3.1?topic=how-populating-data-sets-panel)
- `grantVaultAccess.xml` - Grant access to a specific vault ID
- `setupGklm.xml` - Set up roles required for GKLM integration
- `setupZkey.xml` - Set up roles required for zkey integration


## change notes

### 3.1.0.9 intermediate fix 

**Major Refactoring:**
- Restructured workflow organization from hierarchical to flat structure
- Consolidated multiple workflows into main provisioning workflows as steps
- Old workflows moved to `workflows_legacy/` directory
- All template references updated to point to new workflow locations

**Workflow Consolidation:**
- UKO users, keyring, and database workflows consolidated into `provisionUkoServer.xml`
- CC users and keyring workflows consolidated into `provisionCcServer.xml` and `provisionCcacsp.xml`

**Breaking Changes:**
- Workflow paths have changed - update any automation or scripts that reference old paths
- See migration table above for complete mapping of old to new paths

Starting with this version, several workflows have been consolidated into main provisioning workflows as steps:

| Old Workflow Path | New Workflow Path | Notes |
|-------------------|-------------------|-------|
| `workflows/ukousers/provision.xml` | `workflows/provisionUkoServer.xml` | Now the "Define users and groups" step |
| `workflows/ukokeyring/provision.xml` | `workflows/provisionUkoServer.xml` | Now the "Define key rings and certificates" step |
| `workflows/ukodb/provision.xml` | `workflows/provisionUkoServer.xml` | Now the "Create the database" step |
| `workflows/ukoserver/provision.xml` | `workflows/provisionUkoServer.xml` | Main workflow renamed |
| `workflows/ukoagent/provision.xml` | `workflows/provisionUkoAgent.xml` | Workflow renamed |
| `workflows/ccusers/provision.xml` | `workflows/provisionCcServer.xml` | Now the "Define users and groups" step |
| `workflows/cckeyring/provision.xml` | `workflows/provisionCcServer.xml` | Now the "Define key rings and certificates" step |
| `workflows/ccserver/provision.xml` | `workflows/provisionCcServer.xml` | Workflow renamed |
| `workflows/ccserver/provisionCcacsp.xml` | `workflows/provisionCcacsp.xml` | Workflow moved to flat structure |
| `workflows/ukoserver/setUpGklm.xml` | `workflows/setupGklm.xml` | Workflow renamed |
| `workflows/ukoserver/setUpZkey.xml` | `workflows/setupZkey.xml` | Workflow renamed |

#### Using the New Workflows

The consolidated workflows allow you to:
1. Run the entire provisioning process in one workflow
2. Skip individual steps if you've already completed them manually
3. Execute only specific steps as needed

For example, if you've already created users manually, you can skip the "Define users and groups" step in the main provisioning workflow.

#### Legacy Workflows

The old workflow structure is preserved in `workflows_legacy/` for reference and backward compatibility. However, we recommend migrating to the new consolidated workflows for easier maintenance and better integration.

### 3.1.0.10

**Crypto Connect UKO Integration:**
- Enhanced Crypto Connect with optional UKO database integration for accessing UKO-managed keys
- Added 5 new EJB roles for Crypto Connect: `certificates:read`, `operations:data:sign`, `operations:data:verify`, `operations:data:encrypt`, `operations:data:decrypt`
- Created `db-database-grant-access-cryptoconnect.jcl` for Crypto Connect database grants
- Updated `configureServerForCryptoConnect` workflow step with optional DB2 configuration
  - Validates that all 4 database parameters (DB_LOCATION, DB_CURRENT_SCHEMA, DB_LIBPATH, DB_CLASSPATH) are set together or none are set
  - Conditionally links `db2-zos-type2.xml` only when database integration is configured
  - Supports both standalone and UKO-integrated deployment modes
- Added database grants for UKO server: `EKMF_WEB_KEY_ALL_TAGS`
- Updated `defineServerAccessCryptoConnect.rexx` to define all 5 EJB roles

### 3.1.0.9
- re-introduce HOST variable as SERVER_HOSTNAME, also in update flow
- 3.1.0.9 database updates and grants to new views
- access to CC CAT and ACSP roles
- acces to analytics roles

### 3.1.0.8

- add ACSP provisionCcacsp.xml workflow and related scripts
- optional creation of GENERIC_CLIENT user and group
- optional client certificate setup for certificate client (currently cc workflows only)
- variable rename and refactoring to remove UKO_ and CC_ prefix where it could be generic, migrateProps shell script available for existing properties files
- rename port variables
- add keystore checking profiles  CSF-PKDS-DEFAULT  
- add CSFPKG access
- publish some of the deletion workflows and scripts
- 3.1.0.8 database updates and access to new view BACKGROUND_JOBS
- setUpZkey workflow
