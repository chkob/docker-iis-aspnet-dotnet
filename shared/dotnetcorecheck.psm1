function Install-DotNetCorePackages {
param (
 [parameter(Mandatory=$true)]
 [ValidateNotNullOrEmpty()]$VersionList
)
    $list = @{
    'dotnet_core_2_1' = 
        [PSCustomObject]@{
            Name = 'dotnet_core_2_1';
            SilentInstallArgs = '/q /install';
            FileHash = '70c6b46b5df73ff493d087831b4254d4c3c5c1977a0325d90f6078c725129b71245bd8f886ab72c18113697c592b80714493f5693f2f4d6f5ccf4703bb58d336';
            OutPutFile = './dotnet-hosting-2.1.30-win.exe';
            DownloadUrl = 'https://download.visualstudio.microsoft.com/download/pr/cf7b17e3-ed6d-4ded-8ae6-9f83ffaaca98/9d2ca844baa4a4a9ed83861ffc8e293e/dotnet-hosting-2.1.30-win.exe';
        }
        
    'dotnet_core_3_1_21' = 
        [PSCustomObject]@{
            Name = 'dotnet_core_3_1_21';
            SilentInstallArgs = '/q /install';
            FileHash = 'ab41bbb191d6fe619d648800d72e08396d829fbad28bc61a813af311fffabf3dab4b67f28e33f7f2eb37c18169046e2411414b80104bb78aed3f61a4ca3759de';
            OutPutFile = './dotnet-hosting-3.1.21-win.exe';
            DownloadUrl = 'https://download.visualstudio.microsoft.com/download/pr/4f5c5cdc-1354-415b-a3a2-b5c94d6ca6eb/73841934839d13ba91407f3259a8d1b4/dotnet-hosting-3.1.21-win.exe';
        }
    'dotnet_core_3_1_22' = 
        [PSCustomObject]@{
            Name = 'dotnet_core_3_1_22';
            SilentInstallArgs = '/q /install';
            FileHash = 'a0a2b181a61c10ae8b786fa9bfb8cc26bd48727b9fef38d3419ddd2775b3fc6786dd80e7ea0b6e32344b266f81eff91fee51a645a87c77e94e03e820970e179d';
            OutPutFile = './dotnet-hosting-3.1.22-win.exe';
            DownloadUrl = 'https://download.visualstudio.microsoft.com/download/pr/5b681079-0068-4c70-be77-af30f1154a83/cd5d074d8328fbc0b3bebf87c88ae082/dotnet-hosting-3.1.22-win.exe';
        }
    'dotnet_core_5_0' = 
        [PSCustomObject]@{
            Name = 'dotnet_core_5_0';
            SilentInstallArgs = '/q /install';
            FileHash = '9af148ffb81cacab298798772f11882e9f107d7c40fbcd39e23311cb24541e951cc5640fed2e69e8e5eab3db126f5bf6011fec2b359c42982dda6e188fee6d92';
            OutPutFile = './dotnet-hosting-5.0.14-win.exe';
            DownloadUrl = 'https://download.visualstudio.microsoft.com/download/pr/5adf4f36-aff5-447f-99db-86eae913d4eb/b71f76ea31156438499da1d419c577ff/dotnet-hosting-5.0.14-win.exe';
        }
    'dotnet_core_6_0' = 
        [PSCustomObject]@{
            Name = 'dotnet_core_6_0';
            SilentInstallArgs = '/q /install';
            FileHash = '4dc51d47ce213ca154761616e576127102a9bc35bcf74fff565083d26fd9bcec66f20bcf0ba4c0e9a3fcf882531900b1ed580652a171d5a7f542c86df2a07994';
            OutPutFile = './dotnet-hosting-6.0.2-win.exe';
            DownloadUrl = 'https://download.visualstudio.microsoft.com/download/pr/e77fd80d-b12b-4d8c-9dc2-a22007f44cc8/ad05622589430ca580b7309513f139fe/dotnet-hosting-6.0.2-win.exe';
        }
    }

    try {
        $versionkeys = $VersionList -split ","

        foreach ($key in $versionkeys) {
           $redistInfo = $list[$key]
           Invoke-WebRequest -Uri $redistInfo.DownloadUrl -OutFile $redistInfo.OutPutFile;
           if ((Get-FileHash $redistInfo.OutPutFile -Algorithm sha512).Hash -ne $redistInfo.FileHash) {
               Write-Error "CHECKSUM VERIFICATION FAILED!";
               return $false;
           }

           Write-Host 'CHECKSUM VERIFICATION PASS!';
           Start-Process -FilePath $redistInfo.OutPutFile -ArgumentList "$($redistInfo.SilentInstallArgs)" -Wait -NoNewWindow | Wait-Process;
           Remove-Item -Force $redistInfo.OutPutFile;
           Remove-Item -Force -Recurse ${Env:TEMP}\*;
        }
    }
    catch {
        return $false;
    }
}
Export-ModuleMember Install-DotNetCorePackages

# Install-VSRedistPackages -VersionList  "mscpp2005x64,mscpp2005x86,mscpp2008sp1x64,mscpp2008sp1x86,mscpp2010x64,mscpp2010x86,mscpp2012x64,mscpp2012x86,mscpp2013x64,mscpp2013x86,mscpp2015x64,mscpp2015x86,mscpp2017x64,mscpp2017x86"
#Install-VSRedistPackages -VersionList  "mscpp2017x64"
