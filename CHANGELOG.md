# Zlux App Server Changelog

All notable changes to the Zlux App Server package will be documented in this file.

## v1.25.0

- Enhancement: Changed how app-server scripts locate app-server directories so that they work in container mode, where the folder layout is different. This unifies container and non-container location behavior.
- Enhancement: Use GATEWAY_HOST env var over ZOWE_EXPLORER_HOST to find mediation layer gateway if hostname not explicitly specified elsewhere

## v1.24.0

- Bugfix: IP Explorer was not installed upon upgrade, only on new installs.


## v1.23.0

- Bugfix: Sync state of certificate verification of zlux with keystore configuration, so that certificate verification can be turned on or off centrally
- Enhancement: Automatically create APIML static definition for ZSS when app-server is running in Docker.

## v1.22.0

- Bugfix: Prefer internal IP/hostname over external one when stating to discovery server where app-server is located. For many users there is no behavior difference because the values are the same.

## v1.21.0

- Bugfix: Set the hostname used for eureka to match the value of ZWE_EXTERNAL_HOSTS if exists, or otherwise ZOWE_EXLORER_HOST, for the purpose of avoiding certificate verification issues between app-server and APIML under certain circumstances

## v1.20.0

- Added a manifest file, a validate script, and refactored configure, start, and app-server scripts to better conform to zowe lifecycle management standards

## v1.17.0

- Bugfix: make use of external certificate authorities referenced during keystore setup time

## v1.16.0

- Bugfix: Changes to terminal settings in instance.env would not take effect post-install, causing the initial values to be permenent unless users set personalized settings
- Feature: More terminal settings present in the UI can be set as defaults from instance.env. TN3270 mod type can be set by ZOWE_ZLUX_TN3270_MOD, and the row and column by ZOWE_ZLUX_TN3270_ROW and ZOWE_ZLUX_TN3270_COL. ZOWE_ZLUX_TN3270_CODEPAGE also can be used to set the default codepage to a value which matches the strings seen in the UI, such as "278: Finnish/Swedish" for EBCDIC-278. As a shorthand, just the number can be set as well, such as "278".

## v1.13.0

- Align app server's instance ID parameter to the Zowe Instance value

## v1.12.0

- Add v1.12 update script for replacing all bundled plugin references with ones that use $ROOT_DIR environment variable
- Change Scripts to work with independent zss component
- Add v1.12 update script for removing apiml-auth if it is not being explicitly used
