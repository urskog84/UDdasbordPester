$page1 = new-udpage -Url "/Pester/:hostname" -Endpoint {
    param($hostname)
    #New-UDPreloader -Circular 
    Invoke-Pester -Script @{ Path = '.\*'; Parameters = @{ Hostname = $hostname }} -PassThru | Format-Pester -Path .\Results -Format HTML
    new-udcard -Title "$hostname Test" -Text "hej" -Links @(new-udlink -url "/Results/Pester_Results.html" -Text "hello" )
} 

$Initialization = New-UDEndpointInitialization -Module @("Pester", "Format-Pester")

$Dasbhord = New-UDDashboard -Title "PesterTest" -Pages @(
    $page1
) -EndpointInitialization $Initialization


Get-Item -Path .\Results\Pester_Results.html | Remove-Item -Force
Get-UDDashboard | Stop-UDDashboard
Start-UDDashboard -Dashboard $Dasbhord -Port 8080