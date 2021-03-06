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
    mycli mysql://root:123456@127.0.0.1:3306/mysql
}

function pcli {
    pgcli postgres://postgres:123456@127.0.0.1:5432/postgres
}
function rcli {
    wsl -u root docker exec -it redis redis-cli    
}

function mgcli {
    wsl -u root docker exec -it mongo mongosh -u root -p 123456
}

function gs() {
    git status
}

function gam() {
    param (
        [String] $msg
    )
    if($msg.length -eq 0){
        $msg = "-";
    }
    git add *
    git commit -am $msg
}

function grh(){
    git reset --hard
}

function pulla(){
    param (
        [String] $branch
    )

    if($branch.length -eq 0){
        $branch = &git rev-parse --abbrev-ref HEAD
    }
    git submodule foreach --recursive "git pull origin $branch"
    git pull origin $branch
}

function gsa(){
    git status
    git submodule foreach --recursive "git status"
}

function pushc(){
    param (
        [String] $branch
    )
    if($branch.length -eq 0){
        $branch = &git rev-parse --abbrev-ref HEAD
    }
    git push origin $branch
}

function wslip(){
	wsl hostname -I
}

function service(){
    wsl -u root service $args
}

function dev(){
    wsl -d Ubuntu-20.04 -u root service docker start
}

$local = "$PSScriptRoot/local.ps1"
if (Test-Path -Path $local) {
    . $local
}
