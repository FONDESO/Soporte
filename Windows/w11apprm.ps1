#Windows 11 Default App Removal Script

#--------------------------------------------------------------------------------------
$apps=@(   
    # [Removable System Appx]
    # "Microsoft.NET.Native.Framework.1.7"
    # "Microsoft.NET.Native.Runtime.1.7"
    # "Microsoft.Services.Store.Engagement" 
    
    # [Removable User Appx]
    # "Microsoft.UI.Xaml.CBS"
    # "Microsoft.LanguageExperiencePackes-ES"
    # "Microsoft.LanguageExperiencePackes-MX"
    "Microsoft.549981C3F5F10"   # Cortana
    # "Microsoft.NET.Native.Framework.2.2"
    # "Microsoft.NET.Native.Framework.2.2"
    # "Microsoft.NET.Native.Runtime.2.2"
    # "Microsoft.NET.Native.Runtime.2.2"
    # "Microsoft.VCLibs.140.00.UWPDesktop"
    # "Microsoft.VCLibs.140.00.UWPDesktop"
    # "Microsoft.UI.Xaml.2.4"
    "Microsoft.Getstarted"
    # "Microsoft.UI.Xaml.2.7"
    # "Microsoft.UI.Xaml.2.7"
    # "Microsoft.UI.Xaml.2.4"
    # "MicrosoftWindows.Client.WebExperience"
    "AdvancedMicroDevicesInc-2.AMDRadeonSoftware"
    # "E046963F.LenovoSettingsforEnterprise"
    # "Microsoft.AV1VideoExtension"
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GamingApp"
    "Microsoft.GetHelp"
    # "Microsoft.HEIFImageExtension"
    # "Microsoft.HEVCVideoExtension"
    "Microsoft.MicrosoftEdge.Stable"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    # "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MixedReality.Portal"
    # "Microsoft.MPEG2VideoExtension"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.SkypeApp"
    # "Microsoft.StorePurchaseApp"
    "Microsoft.Todos"
    # "Microsoft.VP9VideoExtensions"
    # "Microsoft.WebMediaExtensions"
    # "Microsoft.WebpImageExtension"
    "Microsoft.WindowsAlarms"
    # "Microsoft.WindowsCalculator"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "RealtekSemiconductorCorp.RealtekAudioControl"
    "microsoft.windowscommunicationsapps"
    # "Microsoft.ScreenSketch"
    # "Microsoft.Paint"
    # "Microsoft.Windows.Photos"
    "Microsoft.WindowsCamera"
    # "Microsoft.WindowsNotepad"
    # "Microsoft.WindowsStore"
    "Microsoft.XboxIdentityProvider"
    "MicrosoftTeams"
    # "Microsoft.WindowsTerminal"
)

foreach ($app in $apps) {    
	Write-Output $app
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage
    # Get-AppXProvisionedPackage -Online | where DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online
            
    # $appPath="$Env:LOCALAPPDATA\Packages\$app*"
    # Remove-Item $appPath -Recurse -Force -ErrorAction 0
}

#Get-AppxPackage -Name "Microsoft.WindowsStore" -AllUsers | Remove-AppxPackage #This is the benign way to remove App Store without unprovisioning... so you can get it back.
