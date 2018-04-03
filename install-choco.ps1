function install-choco {
    [cmdletbinding()]
    param (
        [string]$path

    )

    $url = "http://www.chocolatey.org/install.ps1"
    $output = "$path\install.ps1"

    if (test-path $path) {
        Invoke-WebRequest -uri $url -OutFile $output
    } else {
        md $path
        Invoke-WebRequest -uri $url -OutFile $output
    
    }
    
    sl $path
    .\install.ps1
        
}