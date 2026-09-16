# Sistema de Gestão de Alunos e Avaliações

Projeto completo de referência para uma UC de **Programação Funcional em Haskell**.
Foi concebido para mostrar, num único exemplo, a utilização articulada de tipos algébricos,
listas, funções puras, funções de ordem superior, `Maybe`, `Either`, IO e ficheiros.

## Funcionalidades

- leitura de alunos a partir de `data/alunos.csv`;
- leitura e validação de avaliações a partir de `data/avaliacoes.csv`;
- validação de referências entre avaliações e alunos;
- cálculo da classificação final ponderada por UC;
- deteção de avaliações incompletas quando a soma dos pesos não é 1;
- classificação em Aprovado/Reprovado/Incompleto;
- consulta de um aluno;
- listagem de resultados finais;
- estatísticas por UC;
- geração de um relatório global em `relatorio.txt`;
- conjunto simples de testes sem bibliotecas externas.

## Estrutura

```text
Sistema_Gestao_Alunos_Haskell/
├── app/
│   └── Main.hs
├── src/
│   ├── Model.hs
│   ├── Parsing.hs
│   ├── Domain.hs
│   └── Report.hs
├── test/
│   └── TestMain.hs
├── data/
│   ├── alunos.csv
│   └── avaliacoes.csv
├── cabal.project
├── functional-student-management.cabal
└── README.md
```

## Separação funcional

O projeto segue a ideia de **functional core / imperative shell**:

```text
ficheiros CSV
     ↓
     IO
     ↓
   parsing
     ↓
 validação
     ↓
modelo de domínio
     ↓
funções puras
     ↓
 resultados / estatísticas / relatórios
     ↓
     IO
```

- `Model.hs`: tipos do domínio;
- `Parsing.hs`: transformação de texto em valores do domínio e validação sintática;
- `Domain.hs`: regras de negócio puras;
- `Report.hs`: transformação dos resultados em texto;
- `Main.hs`: interação com o utilizador e ficheiros.

## Compilar e executar com GHC

Na raiz do projeto:

```bash
ghc -isrc app/Main.hs -o student-manager
./student-manager
```

Em Windows:

```powershell
ghc -isrc app/Main.hs -o student-manager.exe
.\student-manager.exe
```

## Executar com Cabal

```bash
cabal run student-manager
```

## Executar os testes

Com GHC:

```bash
ghc -isrc test/TestMain.hs -o tests
./tests
```

ou:

```bash
cabal test
```

## Formato de `alunos.csv`

```text
id;nome;curso
1;Ana Silva;Engenharia Informática
```

## Formato de `avaliacoes.csv`

```text
aluno_id;uc;componente;nota;peso
1;Programação Funcional;Exame;17;0.40
```

Regras:

- a nota deve estar entre 0 e 20;
- o peso deve estar em `]0,1]`;
- para uma classificação final completa, a soma dos pesos das componentes da UC deve ser 1;
- uma classificação final >= 10 corresponde a aprovação.

## Conceitos da UC ilustrados

1. **Tipos e funções** — assinaturas explícitas em todos os módulos.
2. **Listas e pattern matching** — parsing e processamento de coleções.
3. **Recursão** — `splitOn` e decomposição estrutural de texto.
4. **Funções de ordem superior** — `map`, `filter`, `find`, `sortOn`, composição.
5. **Folds/agregação** — `sum` e cálculos agregados.
6. **Tipos algébricos** — `Student`, `Evaluation`, `ResultStatus`, `Result`.
7. **Polimorfismo** — `collect`, `assertEqual`, listas e funções genéricas.
8. **Maybe** — pesquisa de alunos e nota final potencialmente inexistente.
9. **Either** — parsing e mensagens explícitas de erro.
10. **IO** — leitura/escrita de ficheiros e menu interativo.
11. **Composição funcional** — separação entre parsing, domínio e apresentação.

## Possíveis extensões para os estudantes

- adicionar inscrição em várias UCs;
- guardar novos alunos e avaliações;
- importar dados com vírgulas/aspas de CSV real;
- adicionar época normal e recurso;
- definir regras de nota mínima por componente;
- calcular ranking por UC;
- gerar um relatório por curso;
- substituir listas por `Data.Map`;
- criar uma interface web mantendo o núcleo funcional puro.

## Referência pedagógica

Miran Lipovača, *Learn You a Haskell for Great Good! — A Beginner's Guide to Haskell*.
