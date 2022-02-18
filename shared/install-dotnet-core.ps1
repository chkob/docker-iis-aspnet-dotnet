import-module .\dotnetcorecheck.psm1
Install-DotNetCorePackages -VersionList ${env:DOT_NET_CORE_LIST}