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

function sshc {
    param (
        [String] $name
    )
    $m = @{
        "18" = "sjserver02@192.168.20.18";
    };
    ssh $m[$name];
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

function pull {
    git pull    
}

function push {
    git push    
}

function commit {
    git commit 
}

function stash {
    git pull    
}
