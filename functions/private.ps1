#these are private helper functions

function _convertSecureString {
    Param(
        [System.Security.SecureString]$SecureString
    )
    if ($IsCoreClr) {
        ConvertFrom-SecureString -SecureString $SecureString -AsPlainText
    }
    else {
        #this method does not appear to run properly in PowerShell 7
        #on non-Windows platforms
        [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($SecureString))
    }
}
function _getBytes {
    Param(
        [string]$String
    )
    [system.text.encoding]::UTF8.GetBytes($String)
}