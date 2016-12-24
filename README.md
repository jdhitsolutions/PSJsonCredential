# PSJsonCredential

This PowerShell module contains a set of functions for storing a PSCredential object in a JSON file. 

## Why
You can achieve similar results using the Export-CliXML and Import-Clixml cmdlets. The resulting XML files are slightly larger in size and the conversion is slightly longer, but only by a few milliseconds. I merely wanted to provide an alternative file format and json is a popular option these days.

## Is it safe
The commands use the secure string convert cmdlets. These cmdlet rely on Windows crypto APIs to properly convert a secure string. The converted string can only be decrypted on the original computer. If the file is copied to another computer, the ConvertTo-SecureString command will fail.

Because the json file is a plain text file, the user name will be visible. You should still take precautions to secure the json file.

*Last updated 24 December 2016*