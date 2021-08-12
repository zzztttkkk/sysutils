& $HOME/.pyvenv/Scripts/activate.ps1

function ensuredockerengine() {
    $ErrorActionPreference = 'SilentlyContinue';
    $docker_pid = get-process "Docker Desktop" | Select-Object -expand id;
    if ($docker_pid) {
        return;
    }

    start-process "C:/Program Files/Docker/Docker/Docker Desktop.exe" -NoNewWindow;
    while (1) {
        $msg = (docker version | grep Server) 2>$null;
        if ($msg) {
            return;
        }
        start-sleep 1;
    }
}

function rundockerservice() {
    param(
        [string] $name
    )
    
    if ($name -eq "ssh") {
        wsl -u root service ssh restart
        return
    }

    ensuredockerengine | out-null;

    docker start $name
}

function runalldockerservices() {
    rundockerservice("redisdb");
    rundockerservice("postgresdb");
    rundockerservice("postgresdbs");
    rundockerservice("mysqldb");
    rundockerservice("ssh");
}

function mcli() {
    param(
        [string] $dbname
    )

    rundockerservice("mysqldb");

    if (!$dbname) {
        $dbname = "mysql"
    }
    mycli mysql://root:123456@127.0.0.1:13306/$dbname
}

function pcli() {
    param(
        [string] $dbname
    )

    rundockerservice("postgresdb");
    rundockerservice("postgresdbs");

    if (!$dbname) {
        $dbname = "postgres"
    }
    pgcli postgres://postgres:123456@127.0.0.1:15432/$dbname
}

function rcli() {
    rundockerservice("redisdb");
    docker exec -it redisdb redis-cli
}

function mgcli(){
    param(
        [string] $dbname
    )

    if (!$dbname) {
        $dbname = "admin"
    }
    rundockerservice("mongo");
    docker exec -it mongo mongosh $dbname -u root -p example
}

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
    $env:http_proxy = "http://127.0.0.1:50212"
    $env:https_proxy = "http://127.0.0.1:50212"
}


function pullall {
    param (
        [string] $dir
    )

    $cwd = Get-Location

    if ($dir -eq "") {
        $dir = "~/codes"
    }

    foreach ($item in Get-ChildItem $dir) {
        if ($item.PSIsContainer) {
            if (Test-Path "$item/.git") {
                Write-Host "git pull $item"
                Set-Location $item
                git pull
            }
        }
    }
    Set-Location $cwd
}
