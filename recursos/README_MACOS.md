# Setup de Haskell no macOS

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

## 2. Preparar o sistema

Abre o **Terminal**.

Se ainda não tiveres as ferramentas de desenvolvimento da Apple instaladas, executa:

```bash
xcode-select --install
```

---

## 3. Instalar Haskell com GHCup

Executa como utilizador normal, sem `sudo`:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

Durante a instalação, escolhe as opções recomendadas/default e garante que são instalados:

- GHC;
- Cabal;
- Haskell Language Server (HLS).

Quando terminar, fecha o Terminal e abre-o novamente.

---

## 4. Confirmar a instalação

Executa:

```bash
ghc --version
ghci --version
cabal --version
```

Se os três comandos mostrarem informação de versão, a instalação de Haskell está concluída.

---

## 5. Instalar o Visual Studio Code

Descarrega e instala o VS Code a partir de:

https://code.visualstudio.com/

Depois, no VS Code:

1. abre **Extensions** (`Command + Shift + X`);
2. procura por **Haskell**;
3. instala a extensão **Haskell** (`haskell.haskell`).

---

## 6. Verificação final

Abre um terminal no VS Code e executa:

```bash
ghc --version
ghci --version
```

Se os comandos forem reconhecidos, o ambiente está pronto.

## Ligações úteis

- Haskell: https://www.haskell.org/
- GHCup: https://www.haskell.org/ghcup/
- Instalação do GHCup: https://www.haskell.org/ghcup/install/
- Visual Studio Code: https://code.visualstudio.com/
