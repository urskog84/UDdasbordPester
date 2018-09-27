$page1 = new-udpage -Url "/Pester/:hostname" -Endpoint {
    param($hostname)
    Invoke-Pester -Script @{ Path = '.\*'; Parameters = @{ Hostname = $hostname }} -PassThru | Format-Pester -Path .\Results -Format HTML
    New-UDCard  -Title "Tests are done for $hostname" -links @(new-udlink -url "/Results/Pester_Results.html" -Text "Display Test" )
} 

$Initialization = New-UDEndpointInitialization -Module @("Pester", "Format-Pester")

$Dasbhord = New-UDDashboard -Title "PesterTest" -Pages @(
    $page1
) -EndpointInitialization $Initialization


Get-Item -Path .\Results\Pester_Results.html | Remove-Item 
Get-UDDashboard | Stop-UDDashboard
Start-UDDashboard -Dashboard $Dasbhord -Port 8080