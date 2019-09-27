$JsFile = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
# Source maps to make it easier to debug in the browser 
$Maps = Get-ChildItem "$PSScriptRoot\*.map"

$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($JsFile.FullName)
# Register all the source map files so we can make debugging easier.
foreach ($item in $Maps) {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
}

function New-UDMUCarousel {
    param
    (
        [Parameter()]
        [string]$Id = [guid]::NewGuid(),
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [switch]$Autoplay,
        [Parameter()]
        [switch]$Landscape,
        [Parameter()]
        [switch]$Mobile,
        [Parameter()]
        [switch]$Open,
        [Parameter()]
        [hashtable]$ButtonProps,
        [Parameter()]
        [hashtable]$ContainerStyle,
        [Parameter()]
        [hashtable]$ModalProps,
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [int]$Interval,
        [Parameter()]
        [scriptblock]$Content,
        [Parameter()]
        [scriptblock]$OnClose,
        [Parameter()]
        [scriptblock]$OnStart,
        [Parameter()]
        [switch]$IsEndpoint,
        [Parameter()]
        [int]$RefreshInterval = 5000,
        [Parameter()]
        [switch]$AutoRefresh
    )

    End {

        if ($null -ne $Content) {
            if ($IsEndpoint.IsPresent) {
                if ($Content -is [scriptblock]) {
                    $Endpoint = New-UDEndpoint -Endpoint $Content -Id $Id 
                    $CarouselContent = $Content.Invoke()
                }
                elseif ($Content -isnot [UniversalDashboard.Models.Endpoint]) {
                    throw "Content must be a script block or UDEndpoint"
                }
            }
            else {
                $CarouselContent = $Content.Invoke()
            }
        }

        if ($null -ne $OnClose) {
            if ($OnClose -is [scriptblock]) {
                $OnCloseEndpoint = New-UDEndpoint -Endpoint $OnClose -Id ($Id + "onClose")
            }
            elseif ($OnClose -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClose must be a script block or UDEndpoint"
            }
        }

        if ($null -ne $OnStart) {
            if ($OnStart -is [scriptblock]) {
                $OnStartEndpoint = New-UDEndpoint -Endpoint $OnStart -Id ($Id + "onStart")
            }
            elseif ($OnStart -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnStart must be a script block or UDEndpoint"
            }
        }

        @{
            assetId         = $AssetId 
            isPlugin        = $true 
            id              = $Id 
            type            = 'mu-carousel'
            autoplay        = $Autoplay.IsPresent
            ButtonProps     = $ButtonProps
            containerStyle  = $ContainerStyle
            interval        = $Interval
            label           = $Label
            landscape       = $Landscape.IsPresent
            mobile          = $Mobile.IsPresent
            ModalProps      = $ModalProps
            open            = $Open.IsPresent
            content         = $CarouselContent
            className       = $ClassName
            autoRefresh     = $AutoRefresh.IsPresent
            refreshInterval = $RefreshInterval
        }
    }
}

function New-UDMUCarouselSlide {
    param(
        [Parameter()]
        [string]$Id = [guid]::NewGuid(),
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [string]$SubTitle,
        [Parameter()]
        [object]$Media,
        [Parameter()]
        [hashtable]$MediaBackgroundStyle,
        [Parameter()]
        [hashtable]$Style
    )

    End{
        @{
            assetId  = $AssetId 
            isPlugin = $true 
            id       = $Id 
            type     = 'mu-carousel-slide'
            className = $ClassName
            media = $Media
            mediaBackgroundStyle = $MediaBackgroundStyle
            style = $Style
            subtitle = $SubTitle
            title = $Title
        }
    }
}
