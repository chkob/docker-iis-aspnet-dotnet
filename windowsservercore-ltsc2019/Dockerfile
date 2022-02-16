# escape=`
# modified from original source https://github.com/Microsoft/iis-docker/issues/33#issuecomment-373124539

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-20220210-windowsservercore-ltsc2019

RUN Add-WindowsFeature Web-Server; `
    Add-WindowsFeature NET-Framework-45-ASPNET; `
    Add-WindowsFeature Web-Asp-Net45; `
    Remove-Item -Recurse C:\inetpub\wwwroot\*; `
    Invoke-WebRequest -UseBasicParsing -Uri https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe -OutFile C:\ServiceMonitor.exe;

# dotnet 2.1 host bundle
RUN powershell -Command `
    Invoke-WebRequest -UseBasicParsing -Uri "https://download.visualstudio.microsoft.com/download/pr/cf7b17e3-ed6d-4ded-8ae6-9f83ffaaca98/9d2ca844baa4a4a9ed83861ffc8e293e/dotnet-hosting-2.1.30-win.exe" -OutFile "dotnet-hosting-2.1.30-win.exe"; `
    $aspnetcore_sha512 = '70c6b46b5df73ff493d087831b4254d4c3c5c1977a0325d90f6078c725129b71245bd8f886ab72c18113697c592b80714493f5693f2f4d6f5ccf4703bb58d336'; `
    if ((Get-FileHash ./dotnet-hosting-2.1.30-win.exe -Algorithm sha512).Hash -ne $aspnetcore_sha512) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
        exit 1; `
    }; `
     `
    Write-Host 'CHECKSUM VERIFICATION PASS!';

RUN ./dotnet-hosting-2.1.30-win.exe /quiet /install

RUN powershell -Command Remove-Item -Force ./dotnet-hosting-2.1.30-win.exe
RUN powershell Remove-Item -Force -Recurse ${Env:TEMP}\*

# dotnet 3.1 host bundle
RUN powershell -Command `
    Invoke-WebRequest -UseBasicParsing -Uri "https://download.visualstudio.microsoft.com/download/pr/5b681079-0068-4c70-be77-af30f1154a83/cd5d074d8328fbc0b3bebf87c88ae082/dotnet-hosting-3.1.22-win.exe" -OutFile "dotnet-hosting-3.1.22-win.exe"; `
    $aspnetcore_sha512 = 'a0a2b181a61c10ae8b786fa9bfb8cc26bd48727b9fef38d3419ddd2775b3fc6786dd80e7ea0b6e32344b266f81eff91fee51a645a87c77e94e03e820970e179d'; `
    if ((Get-FileHash ./dotnet-hosting-3.1.22-win.exe -Algorithm sha512).Hash -ne $aspnetcore_sha512) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
        exit 1; `
    }; `
     `
    Write-Host 'CHECKSUM VERIFICATION PASS!';

RUN ./dotnet-hosting-3.1.22-win.exe /quiet /install

RUN powershell -Command Remove-Item -Force ./dotnet-hosting-3.1.22-win.exe
RUN powershell Remove-Item -Force -Recurse ${Env:TEMP}\*

# dotnet 5.0 host bundle
RUN powershell -Command `
    Invoke-WebRequest -UseBasicParsing -Uri "https://download.visualstudio.microsoft.com/download/pr/5adf4f36-aff5-447f-99db-86eae913d4eb/b71f76ea31156438499da1d419c577ff/dotnet-hosting-5.0.14-win.exe" -OutFile "dotnet-hosting-5.0.14-win.exe"; `
    $aspnetcore_sha512 = '9af148ffb81cacab298798772f11882e9f107d7c40fbcd39e23311cb24541e951cc5640fed2e69e8e5eab3db126f5bf6011fec2b359c42982dda6e188fee6d92'; `
    if ((Get-FileHash ./dotnet-hosting-5.0.14-win.exe -Algorithm sha512).Hash -ne $aspnetcore_sha512) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
        exit 1; `
    }; `
     `
    Write-Host 'CHECKSUM VERIFICATION PASS!';

RUN ./dotnet-hosting-5.0.14-win.exe /quiet /install

RUN powershell -Command Remove-Item -Force ./dotnet-hosting-5.0.14-win.exe
RUN powershell Remove-Item -Force -Recurse ${Env:TEMP}\*

# dotnet 6.0 host bundle
RUN powershell -Command `
    Invoke-WebRequest -UseBasicParsing -Uri "https://download.visualstudio.microsoft.com/download/pr/e77fd80d-b12b-4d8c-9dc2-a22007f44cc8/ad05622589430ca580b7309513f139fe/dotnet-hosting-6.0.2-win.exe" -OutFile "dotnet-hosting-6.0.2-win.exe"; `
    $aspnetcore_sha512 = '4dc51d47ce213ca154761616e576127102a9bc35bcf74fff565083d26fd9bcec66f20bcf0ba4c0e9a3fcf882531900b1ed580652a171d5a7f542c86df2a07994'; `
    if ((Get-FileHash ./dotnet-hosting-6.0.2-win.exe -Algorithm sha512).Hash -ne $aspnetcore_sha512) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
        exit 1; `
    }; `
     `
    Write-Host 'CHECKSUM VERIFICATION PASS!';

RUN ./dotnet-hosting-6.0.2-win.exe /quiet /install

RUN powershell -Command Remove-Item -Force ./dotnet-hosting-6.0.2-win.exe
RUN powershell Remove-Item -Force -Recurse ${Env:TEMP}\*

RUN Import-Module WebAdministration; `
    New-Item "IIS:\AppPools\NetCoreApp21"; `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp21" -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp21" -Name managedRuntimeVersion -value ''; `
    New-Item "IIS:\AppPools\NetCoreApp31"; `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp31" -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp31" -Name managedRuntimeVersion -value ''; `
    New-Item "IIS:\AppPools\NetCoreApp50"; `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp50" -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp50" -Name managedRuntimeVersion -value ''; `
    New-Item "IIS:\AppPools\NetCoreApp60"; `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp60" -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty "IIS:\AppPools\NetCoreApp60" -Name managedRuntimeVersion -value ''; `
    New-Item "IIS:\AppPools\NetApp48"; `
    Set-ItemProperty "IIS:\AppPools\NetApp48 -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty "IIS:\AppPools\NetApp48" -Name managedRuntimeVersion -value 'v4.0';
    
RUN powershell -Command `
    Stop-WebAppPool -Name "NetCoreApp21"; `
    Stop-WebAppPool -Name "NetCoreApp31"; `
    Stop-WebAppPool -Name "NetCoreApp50"; `
    Stop-WebAppPool -Name "NetCoreApp60"; `
    Stop-WebAppPool -Name "NetApp48";

RUN Remove-WebSite -Name 'Default Web Site'; ` 
   New-Item -Path 'C:/Application' -Type Directory; `
   New-Website -Name 'Application' -Port 80 -PhysicalPath 'C:/Application';

EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]

