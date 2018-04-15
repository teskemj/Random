$path = 'c:\install'
$url = "https://github.com/teskemj/random/install-choco.ps1"
$output = "$path\install-choco.ps1"
Invoke-WebRequest -uri $url -OutFile $output -
   

    