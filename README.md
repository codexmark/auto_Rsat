![screenshoot](https://github.com/user-attachments/assets/185912c2-2d3a-448f-add5-16ad452f8e3b)

---

# Instalação de Ferramentas RSAT via PowerShell

Este repositório contém um script PowerShell para instalar as ferramentas RSAT (Remote Server Administration Tools) no Windows. O script também cria um atalho para o `dsac.exe`.

## Requisitos

- **Windows 10 ou superior**: Certifique-se de que o seu sistema operacional está atualizado, pois isso pode afetar a disponibilidade das ferramentas RSAT.
- **Execução como administrador**: O script deve ser executado com privilégios de administrador.


## Execução do Script

1. **Abrir PowerShell como administrador**:
    - Pressione `Win + X` e selecione "Windows PowerShell (Admin)" ou "Windows Terminal (Admin)".
2. **Executar o script com política de execução RemoteSigned**:

```powershell
powershell -ExecutionPolicy RemoteSigned -File .\core.ps1
```

**Nota**: Se a política de execução estiver configurada como `Restricted`, você precisará alterá-la temporariamente para executar o script. O script solicitará permissão para fazer isso se necessário.

## Funcionalidades do Script

- **Verificação de privilégios de administrador**: O script verifica se está sendo executado com privilégios de administrador.
- **Alteração da política de execução (se necessário)**: Se a política de execução estiver configurada como `Restricted`, o script solicitará permissão para alterá-la temporariamente para `RemoteSigned`.
- **Instalação das ferramentas RSAT**: O script instala as ferramentas RSAT necessárias.
- **Criação de atalho para o dsac.exe**: Um atalho para o `dsac.exe` é criado para facilitar o acesso.
- **Verificação da instalação**: Após a instalação, o script exibe o status das ferramentas RSAT.
- **Reversão das alterações (se necessário)**: Se a política de execução foi alterada durante a execução, o script tentará reverter para o estado original ao final.


## Dicas Adicionais

- **Atualização do Windows**: Certifique-se de que o seu Windows está atualizado para garantir a disponibilidade das ferramentas RSAT.
- **Reinicialização do computador**: Se encontrar problemas durante a instalação, tente reiniciar o computador e executar o script novamente.

Este script é projetado para ajudar na instalação das ferramentas RSAT de forma eficiente e segura. Se você encontrar problemas ou tiver sugestões, por favor, abra uma issue no repositório.

<div style="text-align: center">⁂</div>


