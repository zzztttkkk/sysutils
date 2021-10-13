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

function useproxy() {
    $env:http_proxy = "http://127.0.0.1:54113"
    $env:https_proxy = "http://127.0.0.1:54113"
}

$global:__SSHCMap = @{};

function sshc {
    param (
        [String] $name
    )
    
    ssh $__SSHCMap[$name];
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
    docker exec -it mongodb mongosh -u root -p 123456
}

function tsrun {
    param (
        [String] $name
    )
    node --require ts-node/register $name
}

function exceltool() {
    pythonw D:\\works\\export_tools\\gui.py
}

function pbtool() {
    pythonw D:\works\akaserver\AkaProto\tools\proto_test_tool\client.py    
}

function pullakaproposal() {
    $cwd = Get-Location;
    Set-Location D:\\works\\akaproposal
    git pull
    Set-Location $cwd;
}
                                                 
function enableproxy {
    $env:http_proxy = "http://127.0.0.1:54113"
    $env:https_proxy = "http://127.0.0.1:54113"
}

function disableproxy {
    $env:http_proxy = $null
    $env:https_proxy = $null
}

function gpull {
    git pull    
}

function gpush {
    git push    
}

function gcommit() {
    git commit $args
}

function gstash {
    git pull    
}

function gstatus {
    git status    
}

function gadd {
    git add $args    
}

function greset {
    git reset $args   
}

$script:localPs = "$PSScriptRoot/local.ps1";

if (Test-Path $script:localPs) {
    . $script:localPs
}
