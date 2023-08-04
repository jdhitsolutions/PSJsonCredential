# Change Log for PSJsonCredential

## v2.2.0

### Added

- Added a parameter to `Export-PSCredentialToJson` to encrypt the credential user name.
- Added a `-Comment` parameter to `Export-PSCredentialToJson` which will include it in metadata. This change results in new parameter sets.
- Added format file `psjsoncredential.format.ps1xml` with a default list view. There is also a named list view called `nometa`.

### Fixed

- Revised private function to convert secure strings to better handle differences between PowerShell 7 and Windows PowerShell. ([Issue #5](https://github.com/jdhitsolutions/PSJsonCredential/issues/5))

### Changed

- Restructured module layout.
- Modified import and export commands to accept a secure string for the key and not plain text password. **This is a breaking change**
- Moved .NET methods to private functions for future Pester tests.
- Changed output from `Get-PSCredentialFromJson` to include the metadata comment.
- Added sample files.
- Help updates.
- General code cleanup.
- Revised Pester tests for v5.
- Updated `README.md`.

## v2.1.0

- fixed metadata bug on non-Windows platforms ([Issue #4](https://github.com/jdhitsolutions/PSJsonCredential/issues/4))
- Minor Pester test correction

## v2.0.0

- Updated manifest to support Desktop and Core PSEditions
- Modified commands to use a Key to secure password and not rely on the Crypto API
- Made metadata optional on `Export-PSCredentialToJson`
- Updated help
- Updated `README.md`
- Updated Pester tests
- Removed online help download links

## v1.3.1

- file cleanup for the PowerShell Gallery
- Updated `README.md`

## v1.3.0

- Added parameter validation to `Path` in `Export-PSCredentialToJson` for .json extension.
- Fixed a new bug with an apparent change in `ConvertFrom-Json`. Password value was no longer a simple string.
- Code cleanup

## v1.2.0

- code cleanup
- revised license
- fixed Pester test bugs
- Updated `README.md`
- Updated help

## v1.1.3.0

- changed author in manifest
- changed to semantic version numbers

## v1.1.2

- Added links for online help
- Updated help documentation
- updated version number

## v1.1.1

- revised help

## v1.1.0

- Added path to output from `Get-PSJsonCredential` ([Issue #1](https://github.com/jdhitsolutions/PSJsonCredential/issues/1))
- Updated documentation

## v1.0.0

- public release to PSGallery

## v0.1.0

- updated manifest
- updated README
- created help markdown documents
- created external help

## v0.0.9

- initial build
