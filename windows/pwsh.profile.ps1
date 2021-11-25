& $HOME/.pyenv/Scripts/activate.ps1

Set-Alias which Get-Command
Set-Alias grep Select-String

function google ($search) {
    $url = "https://www.google.com/search?q=" + $search
    Start-Process $url
}

function bing ($search) {
    $url = "https://cn.bing.com/search?ensearch=1&q=" + $search
    Start-Process $url
}

$global:proxy = "";

function useproxy() {
    $env:http_proxy = $global:proxy
    $env:https_proxy = $global:proxy
}

function resetproxy() {
    $env:http_proxy = ""
    $env:https_proxy = ""
}

$global:__sshcMap = @{};

function sshc {
    param (
        [String] $name
    )
    ssh $global:__sshcMap[$name];
}

function mcli {
    mycli mysql://root:123456@127.0.0.1:13306/mysql
}

function pcli {
    pgcli postgres://postgres:123456@127.0.0.1:15432/postgres
}
function rcli {
    docker exec -it redisdb redis-cli    
}

function mgcli {
    docker exec -it mongo mongosh -u root -p 123456
}

function gs() {
    git status
}

function gp() {
    git pull
}

function gam() {
    param (
        [String] $msg
    )
    git add *
    git commit -am $msg
}

function gl1(){
    git log -1
}

$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$local = "$ScriptDir/local.ps1"
if (Test-Path -Path $local) {
    . $local
}


