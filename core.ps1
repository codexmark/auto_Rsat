<#
.SYNOPSIS
   Script para automatizar a instalacao das Ferramentas de Administracao de Servidor Remoto (RSAT) no Windows 10.

.DESCRIPTION
   Este script instala as ferramentas RSAT para Active Directory Domain Services e Lightweight Directory Services Tools.
   Ele tambem oferece a opcao de instalacao manual via download do site da Microsoft e cria um atalho para o dsac.exe na area de trabalho.

.NOTES
   Autor: Mark Mesquita
   Data: 18/03/2025
   Versao: 1.0

.LINK
   Link para download manual: https://www.microsoft.com/pt-BR/download/details.aspx?id=45520&msockid=34309377fe6e6ea7179e8633ff7a6f88
#>

# Funcao para exibir mensagens formatadas
function Write-CustomMessage {
    param (
        [string]$Message,
        [string]$Type = "Info"
    )

    switch ($Type) {
        "Info" {
            Write-Host "INFO: $Message" -ForegroundColor Cyan
        }
        "Warning" {
            Write-Host "WARNING: $Message" -ForegroundColor Yellow
        }
        "Error" {
            Write-Host "ERROR: $Message" -ForegroundColor Red
        }
        default {
            Write-Host $Message
        }
    }
}

# Apresentar informações do script
Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-CustomMessage "Script de instalacao das Ferramentas de Administracao de Servidor Remoto (RSAT)"
Write-CustomMessage "Autor: Mark Mesquita"
Write-CustomMessage "Data de criacao: 18/03/2025"
Write-CustomMessage "Versao: 1.0"
Write-Host "--------------------------------------------------------" -ForegroundColor Cyan

# Passo 1: Verificar se o script esta sendo executado como administrador
Write-CustomMessage "Verificando se o script esta sendo executado como administrador..."
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-CustomMessage "Este script precisa ser executado como administrador. Reinicie o PowerShell como administrador e execute o script novamente." -Type "Error"
    exit
}

# Passo 2: Apresentar a sinopse
Write-Host "Sinopse:" -ForegroundColor Cyan
Write-Host "Este script instala as ferramentas RSAT para Active Directory Domain Services e Lightweight Directory Services Tools." -ForegroundColor Yellow
Write-Host "Ele tambem oferece a opcao de instalacao manual via download do site da Microsoft e cria um atalho para o dsac.exe na area de trabalho." -ForegroundColor Yellow

# Passo 3: Instalar as Ferramentas de Administracao de Servidor Remoto para Active Directory
Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-CustomMessage "Iniciando a instalacao das Ferramentas de Administracao de Servidor Remoto para Active Directory..."
Write-Host "Instalando RSAT..." -ForegroundColor Cyan
for ($i = 0; $i -le 100; $i++) {
    Write-Progress -Activity "Instalacao RSAT" -Status "$i%" -PercentComplete $i
    Start-Sleep -Milliseconds 20
}
try {
    Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -ErrorAction Stop
    Write-CustomMessage "Ferramentas de Administracao de Servidor Remoto para Active Directory instaladas com sucesso."
}
catch {
    Write-CustomMessage "Falha ao instalar as Ferramentas de Administracao de Servidor Remoto para Active Directory. Erro: $($_.Exception.Message)" -Type "Error"
}

# Passo 4: Exibir o estado das ferramentas RSAT
Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-CustomMessage "Verificando se as ferramentas foram instaladas com sucesso..."
$RSATFeatures = Get-WindowsCapability -Online | Where-Object { $_.Name -like "Rsat.*" } | Select-Object -Property Name, State
Write-Host "Estado das ferramentas RSAT:" -ForegroundColor Cyan
$RSATFeatures | Format-Table -AutoSize

# Passo 5: Criar um atalho para o dsac.exe na area de trabalho
Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-CustomMessage "Criando um atalho para o dsac.exe na area de trabalho..."
try {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\dsac.lnk")
    $Shortcut.TargetPath = "C:\Windows\System32\dsac.exe"
    $Shortcut.Save()
    Write-CustomMessage "Atalho criado com sucesso."
} catch {
    Write-CustomMessage "Falha ao criar o atalho. Erro: $($_.Exception.Message)" -Type "Error"
}

Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-CustomMessage "Script de instalacao das Ferramentas de Administracao de Servidor Remoto (RSAT) concluido."
