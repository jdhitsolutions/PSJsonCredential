# Change Log for PSJsonCredential

## v2.0.0

+ Updated manifest to support Desktop and Core PSEditions
+ Modified commands to use a Key to secure password and not rely on the Crypto API
+ Made metadata optional on `Export-PSCredentialToJson`
+ Updated help
+ Updated `README.md`
+ Updated Pester tests
+ Removed online help download links

## v1.3.1

+ file cleanup for the PowerShell Gallery
+ Updated `README.md`

## v1.3.0

+ Added parameter validation to `Path` in `Export-PSCredentialToJson` for .json extension.
+ Fixed a new bug with an apparent change in `ConvertFrom-Json`. Password value was no longer a simple string.
+ Code cleanup

## v1.2.0

+ code cleanup
+ revised license
+ fixed Pester test bugs
+ Updated `README.md`
+ Updated help

## v1.1.3.0

+ changed author in manifest
+ changed to semantic version numbers

## v1.1.2

+ Added links for online help
+ Updated help documentation
+ updated version number

## v1.1.1

+ revised help

## v1.1.0

+ Added path to output from `Get-PSJsonCredential` (Issue #1)
+ Updated documentation

## v1.0.0

+ public release to PSGallery

## v0.1.0

+ updated manifest
+ updated README
+ created help markdown documents
+ created external help

## v0.0.9

+ initial build