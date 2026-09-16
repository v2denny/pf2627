# Setup de Haskell no Windows

> **Site oficial do Haskell:** https://www.haskell.org/
>
> **Instalador oficial recomendado (GHCup):** https://www.haskell.org/ghcup/

## 1. O que vamos instalar?

Para trabalhar com Haskell vamos usar:

- **GHC** — compilador de Haskell;
- **GHCi** — interpretador interativo;
- **Cabal** — ferramenta para projetos e dependências;
- **HLS (Haskell Language Server)** — suporte de Haskell no editor;
- **GHCup** — instalador e gestor destas ferramentas;
- **Visual Studio Code** — editor que vamos utilizar.

---

## 2. Instalar Haskell com GHCup

Abre o **PowerShell** como utilizador normal, sem executar como Administrador.

Acede a:

https://www.haskell.org/ghcup/

Na secção **Windows**, copia o comando de instalação apresentado no site, cola-o no PowerShell e carrega em **Enter**.

Durante a instalação, escolhe as opções recomendadas/default e garante que são instalados:

- GHC;
- Cabal;
- Haskell Language Server (HLS).

Quando terminar, fecha o PowerShell e abre-o novamente.

---

## 3. Confirmar a instalação

Executa:

```powershell
ghc --version
ghci --version
cabal --version
```

Se os três comandos mostrarem informação de versão, a instalação de Haskell está concluída.

---

## 4. Instalar o Visual Studio Code

Descarrega e instala o VS Code a partir de:

https://code.visualstudio.com/

Depois, no VS Code:

1. abre **Extensions** (`Ctrl + Shift + X`);
2. procura por **Haskell**;
3. instala a extensão **Haskell** (`haskell.haskell`).

---

## 5. Verificação final

Abre um terminal no VS Code e executa:

```powershell
ghc --version
ghci --version
```

Se os comandos forem reconhecidos, o ambiente está pronto.

## Ligações úteis

- Haskell: https://www.haskell.org/
- GHCup: https://www.haskell.org/ghcup/
- Instalação do GHCup: https://www.haskell.org/ghcup/install/
- Visual Studio Code: https://code.visualstudio.com/
