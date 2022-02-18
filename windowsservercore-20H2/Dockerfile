# escape=`
# modified from original source https://github.com/Microsoft/iis-docker/issues/33#issuecomment-373124539

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-20220208-windowsservercore-20H2

RUN dism /Online /Quiet /Enable-Feature /All /FeatureName:IIS-WebServerRole /FeatureName:NetFx4Extended-ASPNET45 /FeatureName:IIS-ASPNET45 `
    && dism /Online /Quiet /Disable-Feature /FeatureName:IIS-WebServerManagementTools

RUN del /q "C:\inetpub\wwwroot\*" ` 
    && for /D %p IN ("C:\inetpub\wwwroot\*") DO rmdir "%p" /s /q

RUN curl -fSLo C:\ServiceMonitor.exe https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe

RUN %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen update `
    && %windir%\Microsoft.NET\Framework\v4.0.30319\ngen update

# Install 3.11.0 Roslyn compilers
RUN curl -fSLo microsoft.net.compilers.3.11.0.zip https://api.nuget.org/packages/microsoft.net.compilers.3.11.0.nupkg `
    && mkdir C:\RoslynCompilers-3.11.0 `
    && tar -C C:\RoslynCompilers-3.11.0 -zxf microsoft.net.compilers.3.11.0.zip `
    && del microsoft.net.compilers.3.11.0.zip `
    && %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen install C:\RoslynCompilers-3.11.0\tools\csc.exe /ExeConfig:C:\RoslynCompilers-3.11.0\tools\csc.exe `
    && %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen install C:\RoslynCompilers-3.11.0\tools\vbc.exe /ExeConfig:C:\RoslynCompilers-3.11.0\tools\vbc.exe `
    && %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen install C:\RoslynCompilers-3.11.0\tools\VBCSCompiler.exe /ExeConfig:C:\RoslynCompilers-3.11.0\tools\VBCSCompiler.exe
    
# Install 4.0.1 Roslyn compilers
RUN curl -fSLo microsoft.net.compilers.4.0.1.zip https://api.nuget.org/packages/microsoft.net.compilers.4.0.1.nupkg `
    && mkdir C:\RoslynCompilers-4.0.1 `
    && tar -C C:\RoslynCompilers-4.0.1 -zxf microsoft.net.compilers.4.0.1.zip `
    && del microsoft.net.compilers.4.0.1.zip `
    && %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen install C:\RoslynCompilers-4.0.1\tools\csc.exe /ExeConfig:C:\RoslynCompilers-4.0.1\tools\csc.exe `
    && %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen install C:\RoslynCompilers-4.0.1\tools\vbc.exe /ExeConfig:C:\RoslynCompilers-4.0.1\tools\vbc.exe `
    && %windir%\Microsoft.NET\Framework64\v4.0.30319\ngen install C:\RoslynCompilers-4.0.1\tools\VBCSCompiler.exe /ExeConfig:C:\RoslynCompilers-4.0.1\tools\VBCSCompiler.exe

ENV ROSLYN_COMPILER_LOCATION=C:\RoslynCompilers-4.0.1\tools

ENV DOT_NET_CORE_LIST="dotnet_core_2_1,dotnet_core_3_1_21,dotnet_core_5_0,dotnet_core_6_0"

RUN curl -fSLo dotnetcorecheck.psm1 https://raw.githubusercontent.com/chkob/docker-iis-aspnet-dotnet/add-dot-net-core/shared/dotnetcorecheck.psm1 `
    && curl -fSLo install-dotnet-core.ps1 https://raw.githubusercontent.com/chkob/docker-iis-aspnet-dotnet/add-dot-net-core/shared/install-dotnet-core.ps1

RUN powershell .\install-dotnet-core.ps1

RUN dism /Online /Quiet /Disable-Feature /FeatureName:IIS-WebServerManagementTools

RUN powershell -Command `
    New-WebAppPool -Name "NetCoreApp21"; `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp21 -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp21 -Name managedRuntimeVersion -value ''; `
    New-WebAppPool -Name "NetCoreApp31"; `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp31 -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp31 -Name managedRuntimeVersion -value ''; `
    New-WebAppPool -Name "NetCoreApp50"; `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp50 -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp50 -Name managedRuntimeVersion -value ''; `
    New-WebAppPool -Name "NetCoreApp60"; `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp60 -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty -Path IIS:\AppPools\NetCoreApp60 -Name managedRuntimeVersion -value ''; `
    New-WebAppPool -Name "NetApp48"; `
    Set-ItemProperty -Path IIS:\AppPools\NetApp48 -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
    Set-ItemProperty -Path IIS:\AppPools\NetApp48 -Name managedRuntimeVersion -value 'v4.0';

RUN powershell -Command `
    Stop-WebAppPool -Name "NetCoreApp21"; `
    Stop-WebAppPool -Name "NetCoreApp31"; `
    Stop-WebAppPool -Name "NetCoreApp50"; `
    Stop-WebAppPool -Name "NetCoreApp60"; `
    Stop-WebAppPool -Name "NetApp48";

RUN powershell -Command `
    Remove-WebSite -Name 'Default Web Site'; `
    New-Item -Path 'C:/Application' -Type Directory; `
    New-Website -Name 'Application' -Port 80 -PhysicalPath 'C:/Application';

EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]

