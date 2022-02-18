# escape=`
# modified from original source https://github.com/Microsoft/iis-docker/issues/33#issuecomment-373124539

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-20220210-windowsservercore-ltsc2019

RUN Add-WindowsFeature Web-Server; `
    Add-WindowsFeature NET-Framework-45-ASPNET; `
    Add-WindowsFeature Web-Asp-Net45; `
    Remove-Item -Recurse C:\inetpub\wwwroot\*; `
    Invoke-WebRequest -UseBasicParsing -Uri https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe -OutFile C:\ServiceMonitor.exe;

ENV DOT_NET_CORE_LIST="dotnet_core_2_1,dotnet_core_3_1_22,dotnet_core_5_0,dotnet_core_6_0"

RUN Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/chkob/docker-iis-aspnet-dotnet/add-dot-net-core/shared/dotnetcorecheck.psm1 -OutFile "dotnetcorecheck.psm1"; `
    Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/chkob/docker-iis-aspnet-dotnet/add-dot-net-core/shared/install-dotnet-core.ps1 -OutFile "install-dotnet-core.ps1";

RUN powershell .\install-dotnet-core.ps1

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

