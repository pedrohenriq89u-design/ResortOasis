Resort Oasis --- Sistema de Gestão de Hospedagem

Projeto acadêmico de banco de dados relacional para organizar a operação
de um resort fictício, desde o cadastro de hóspedes e acomodações até
reservas, pagamentos e consumo de serviços adicionais.

> **SGBD:** MySQL\
> **Modelagem:** MySQL Workbench\
> **Banco de dados:** `resort_oasis`

------------------------------------------------------------------------

## 📌 Sumário

-   [1. Domínio do banco de dados](#1-domínio-do-banco-de-dados)
-   [2. Contextualização](#2-contextualização)
-   [3. Proposta de melhoria](#3-proposta-de-melhoria)
-   [4. Modelagem lógica](#4-modelagem-lógica)
-   [5. Relacionamentos e
    cardinalidades](#5-relacionamentos-e-cardinalidades)
-   [6. Formas normais](#6-formas-normais)
-   [7. Requisitos e implementação](#7-requisitos-e-implementação)
-   [8. Consultas SQL](#8-consultas-sql)
-   [9. Testes](#9-testes)
-   [10. Exportação e restauração do
    dump](#10-exportação-e-restauração-do-dump)
-   [11. Como executar o projeto](#11-como-executar-o-projeto)
-   [12. Estrutura sugerida do
    repositório](#12-estrutura-sugerida-do-repositório)
-   [13. Entrega no Classroom](#13-entrega-no-classroom)

------------------------------------------------------------------------

## 1. Domínio do banco de dados

O domínio escolhido é a administração do **Resort Oasis**, uma empresa
fictícia do setor hoteleiro. O banco de dados organiza informações
sobre:

-   hóspedes;
-   acomodações;
-   reservas;
-   pagamentos;
-   serviços oferecidos;
-   consumo de serviços durante as hospedagens.

O objetivo é centralizar essas informações e permitir consultas
confiáveis sobre hospedagens, disponibilidade, pagamentos e serviços
utilizados.

## 2. Contextualização

Sem um SGBD relacional, o resort poderia manter seus registros em
planilhas, documentos e arquivos separados. Esse método pode causar:

-   **Duplicação:** os dados de um mesmo hóspede podem aparecer em
    vários arquivos.
-   **Inconsistência:** uma alteração pode ser feita em um arquivo e não
    nos demais.
-   **Consultas demoradas:** localizar reservas, pagamentos e consumos
    exige trabalho manual.
-   **Falhas de integridade:** podem surgir registros ligados a
    hóspedes, reservas ou serviços inexistentes.
-   **Dificuldade financeira:** somar receitas e identificar pagamentos
    aprovados pode ser trabalhoso.
-   **Conflitos de reserva:** controlar as datas e a ocupação das
    acomodações torna-se mais difícil.
-   **Manutenção complexa:** o crescimento da quantidade de informações
    dificulta a organização.

## 3. Proposta de melhoria

A solução proposta é utilizar o **MySQL** para centralizar os dados em
tabelas relacionadas. Chaves primárias identificam os registros e chaves
estrangeiras conectam as tabelas, ajudando a preservar a integridade
referencial.

### Benefícios esperados

-   Centralização das informações;
-   redução de redundâncias;
-   maior consistência dos registros;
-   facilidade para cadastrar, atualizar e consultar dados;
-   relatórios por meio de SQL;
-   melhor controle de reservas, acomodações, pagamentos e serviços;
-   possibilidade de criar cópias de segurança e restaurar o banco.

## 4. Modelagem lógica

O projeto utiliza seis tabelas.

### 4.1. `hospedes`

Armazena os dados cadastrais dos hóspedes.

  Campo               Tipo             Restrições/finalidade
  ------------------- ---------------- --------------------------
  `id_hospede`        `INT`            Chave primária
  `nome`              `VARCHAR(100)`   Nome do hóspede
  `cpf`               `CHAR(11)`       Único; CPF sem pontuação
  `email`             `VARCHAR(120)`   Único
  `telefone`          `VARCHAR(20)`    Telefone para contato
  `data_nascimento`   `DATE`           Data de nascimento
  `data_cadastro`     `DATE`           Data do cadastro

### 4.2. `acomodacoes`

Registra as acomodações disponíveis no resort.

  -----------------------------------------------------------------------
  Campo                   Tipo                    Restrições/finalidade
  ----------------------- ----------------------- -----------------------
  `id_acomodacao`         `INT`                   Chave primária

  `numero`                `VARCHAR(10)`           Único; identificação da
                                                  acomodação

  `tipo`                  `VARCHAR(40)`           Tipo de acomodação

  `capacidade`            `INT`                   Quantidade máxima de
                                                  hóspedes

  `diaria`                `DECIMAL(10,2)`         Valor da diária

  `status`                `ENUM`                  Situação da acomodação;
                                                  conferir as opções no
                                                  script SQL
  -----------------------------------------------------------------------

### 4.3. `reservas`

Registra as hospedagens reservadas.

  -----------------------------------------------------------------------------
  Campo                   Tipo                    Restrições/finalidade
  ----------------------- ----------------------- -----------------------------
  `id_reserva`            `INT`                   Chave primária

  `id_hospede`            `INT`                   Chave estrangeira para
                                                  `hospedes.id_hospede`

  `id_acomodacao`         `INT`                   Chave estrangeira para
                                                  `acomodacoes.id_acomodacao`

  `data_checkin`          `DATE`                  Data de entrada

  `data_checkout`         `DATE`                  Data de saída

  `quantidade_hospedes`   `INT`                   Quantidade de pessoas na
                                                  reserva

  `status`                `ENUM`                  Situação da reserva; conferir
                                                  as opções no script SQL
  -----------------------------------------------------------------------------

### 4.4. `pagamentos`

Armazena os pagamentos relacionados às reservas.

  -----------------------------------------------------------------------
  Campo                   Tipo                    Restrições/finalidade
  ----------------------- ----------------------- -----------------------
  `id_pagamento`          `INT`                   Chave primária

  `id_reserva`            `INT`                   Chave estrangeira para
                                                  `reservas.id_reserva`

  `data_pagamento`        `DATE`                  Data do pagamento

  `valor`                 `DECIMAL(10,2)`         Valor pago ou
                                                  registrado

  `forma_pagamento`       `ENUM`                  Forma de pagamento;
                                                  conferir as opções no
                                                  script SQL

  `status`                `ENUM`                  Situação do pagamento;
                                                  conferir as opções no
                                                  script SQL
  -----------------------------------------------------------------------

### 4.5. `servicos`

Registra os serviços adicionais oferecidos pelo resort.

  Campo          Tipo              Restrições/finalidade
  -------------- ----------------- ------------------------
  `id_servico`   `INT`             Chave primária
  `nome`         `VARCHAR(80)`     Único; nome do serviço
  `descricao`    `VARCHAR(200)`    Descrição do serviço
  `preco`        `DECIMAL(10,2)`   Preço do serviço

### 4.6. `consumo_servicos`

Registra os serviços utilizados em cada reserva.

  -----------------------------------------------------------------------
  Campo                   Tipo                    Restrições/finalidade
  ----------------------- ----------------------- -----------------------
  `id_consumo`            `INT`                   Chave primária

  `id_reserva`            `INT`                   Chave estrangeira para
                                                  `reservas.id_reserva`

  `id_servico`            `INT`                   Chave estrangeira para
                                                  `servicos.id_servico`

  `data_consumo`          `DATE`                  Data em que o serviço
                                                  foi utilizado

  `quantidade`            `INT`                   Quantidade consumida

  `valor_unitario`        `DECIMAL(10,2)`         Valor unitário
                                                  registrado no consumo
  -----------------------------------------------------------------------

> **Observação:** os campos `ENUM` são descritos no documento como tipo
> de dado, mas as opções permitidas devem ser conferidas no modelo do
> MySQL Workbench e no script SQL definitivo.

## 5. Relacionamentos e cardinalidades

  -----------------------------------------------------------------------
  Relacionamento          Cardinalidade           Explicação
  ----------------------- ----------------------- -----------------------
  `hospedes` → `reservas` 1:N                     Um hóspede pode fazer
                                                  várias reservas; cada
                                                  reserva está associada
                                                  a um hóspede.

  `acomodacoes` →         1:N                     Uma acomodação pode
  `reservas`                                      aparecer em várias
                                                  reservas ao longo do
                                                  tempo; cada reserva
                                                  referencia uma
                                                  acomodação.

  `reservas` →            1:N                     Uma reserva pode
  `pagamentos`                                    possuir vários
                                                  registros de pagamento;
                                                  cada pagamento pertence
                                                  a uma reserva.

  `reservas` →            1:N                     Uma reserva pode ter
  `consumo_servicos`                              vários registros de
                                                  consumo.

  `servicos` →            1:N                     Um serviço pode
  `consumo_servicos`                              aparecer em vários
                                                  registros de consumo.

  `reservas` ↔ `servicos` N:M                     Uma reserva pode
                                                  incluir vários serviços
                                                  e um serviço pode
                                                  aparecer em várias
                                                  reservas. A tabela
                                                  `consumo_servicos`
                                                  resolve esse
                                                  relacionamento.
  -----------------------------------------------------------------------

### Diagrama

O arquivo editável da modelagem é `OasisDiagrama.mwb`. Abra-o no MySQL
Workbench para visualizar o diagrama EER e gerar uma captura de tela
para a entrega.

**Captura da modelagem:** adicione ao repositório uma imagem exportada
do Workbench, por exemplo, `docs/modelagem-resort-oasis.png`.

## 6. Formas normais

A normalização organiza as tabelas para reduzir redundâncias e evitar
anomalias de inserção, atualização e exclusão.

### 1FN --- Primeira Forma Normal

Cada campo deve guardar um único valor, sem listas ou grupos repetidos.
No projeto, os serviços consumidos são registrados individualmente em
`consumo_servicos`, em vez de guardar vários serviços em uma única
coluna.

### 2FN --- Segunda Forma Normal

A tabela deve estar na 1FN e todos os atributos não-chave devem depender
da chave primária completa. As tabelas utilizam identificadores
próprios, como `id_hospede`, `id_reserva` e `id_servico`; em
`consumo_servicos`, `id_consumo` identifica cada ocorrência de consumo.

### 3FN --- Terceira Forma Normal

A tabela deve estar na 2FN e os atributos não-chave não devem depender
transitivamente da chave primária. Os dados dos hóspedes, das
acomodações e dos serviços ficam em suas próprias tabelas. A tabela
`reservas` guarda as referências por meio de chaves estrangeiras, sem
repetir nome do hóspede ou número da acomodação.

### 4FN --- Quarta Forma Normal

A 4FN trata dependências multivaloradas independentes que podem gerar
redundância. O projeto separa reservas, serviços e ocorrências de
consumo, usando `consumo_servicos` para relacioná-los. **A confirmação
formal da 4FN depende da análise das dependências multivaloradas
existentes nos dados**, conforme descrito na documentação do projeto.

## 7. Requisitos e implementação

-   MySQL Server;
-   MySQL Workbench (recomendado para executar os scripts e visualizar a
    modelagem);
-   arquivo de script SQL com a criação das tabelas, dados de exemplo e
    consultas.

O banco deve se chamar `resort_oasis` e conter as seis tabelas descritas
acima.

### Dados de exemplo

A documentação do projeto registra a seguinte quantidade de dados:

  Tabela                 Registros informados
  -------------------- ----------------------
  `hospedes`                                6
  `acomodacoes`                             6
  `reservas`                                7
  `pagamentos`                              7
  `servicos`                                6
  `consumo_servicos`                       10

Todas as tabelas possuem pelo menos cinco registros, conforme o
requisito da atividade.

## 8. Consultas SQL

O projeto prevê **15 consultas contextualizadas**, com comentários sobre
seus objetivos e resultados esperados. Elas devem demonstrar recursos
como:

-   `INNER JOIN` e `LEFT JOIN`;
-   `WHERE` e `LIKE`;
-   `BETWEEN`;
-   `GROUP BY` e `ORDER BY`;
-   `SUM` e `COUNT`;
-   `CASE` e `COALESCE`.

Exemplos de perguntas que as consultas podem responder:

1.  Quais hóspedes estão cadastrados?
2.  Quais acomodações estão dentro de uma faixa de diária?
3.  Quais reservas existem e quais hóspedes estão associados a elas?
4.  Quais pagamentos foram registrados para cada reserva?
5.  Qual é a soma dos pagamentos aprovados?
6.  Quantas reservas existem por situação?
7.  Quais serviços foram consumidos em cada reserva?
8.  Quais hóspedes têm nomes que correspondem a um padrão de busca?
9.  Quais reservas estão dentro de um intervalo de datas?
10. Quais serviços têm maior preço?
11. Quantas vezes cada serviço foi consumido?
12. Qual é o total registrado por serviço consumido?
13. Quais reservas ainda não possuem pagamento registrado?
14. Quais acomodações têm maior capacidade?
15. Qual é o histórico de consumo de uma reserva específica?

Os resultados exatos dependem dos registros existentes no script. Depois
de executar as consultas no MySQL Workbench, confira os resultados e
registre as respostas reais nos comentários ou na documentação. Não se
deve declarar um resultado sem verificá-lo no banco.

## 9. Testes

Após executar o script, verifique a criação das tabelas:

``` sql
USE resort_oasis;
SHOW TABLES;
```

Confira a quantidade de registros em cada tabela:

``` sql
SELECT 'hospedes' AS tabela, COUNT(*) AS total FROM hospedes
UNION ALL
SELECT 'acomodacoes', COUNT(*) FROM acomodacoes
UNION ALL
SELECT 'reservas', COUNT(*) FROM reservas
UNION ALL
SELECT 'pagamentos', COUNT(*) FROM pagamentos
UNION ALL
SELECT 'servicos', COUNT(*) FROM servicos
UNION ALL
SELECT 'consumo_servicos', COUNT(*) FROM consumo_servicos;
```

Verifique também:

-   se as seis tabelas foram criadas;
-   se todas possuem pelo menos cinco registros;
-   se as chaves primárias e estrangeiras funcionam;
-   se as 15 consultas são executadas sem erro;
-   se os relacionamentos retornam os registros esperados;
-   se uma reserva com `data_checkout` anterior ou igual à
    `data_checkin` é rejeitada, caso essa validação esteja definida no
    script;
-   se o dump pode ser restaurado em um banco de teste.

> O uso de `IF NOT EXISTS` evita recriar um banco ou uma tabela que já
> existe, mas não atualiza automaticamente uma estrutura antiga nem
> impede que os mesmos `INSERT` sejam executados novamente. Para repetir
> os testes, utilize uma base limpa ou uma rotina de reinicialização
> apropriada.

## 10. Exportação e restauração do dump

Um **dump** é um arquivo que contém a estrutura e os dados do banco e
pode ser usado para backup e restauração.

### Opção A --- MySQL Workbench

1.  Abra o MySQL Workbench e conecte-se ao servidor.
2.  Acesse **Server → Data Export**.
3.  Selecione o banco `resort_oasis`.
4.  Marque as seis tabelas.
5.  Escolha exportar a estrutura e os dados.
6.  Selecione a opção de arquivo SQL único.
7.  Defina o nome `resort_oasis_backup.sql`.
8.  Inicie a exportação e confirme que o arquivo foi criado.

### Opção B --- Terminal

Exportar a estrutura e os dados:

``` bash
mysqldump -u seu_usuario -p --databases resort_oasis > resort_oasis_backup.sql
```

Digite a senha quando for solicitado. Substitua `seu_usuario` pelo
usuário do MySQL.

Restaurar o dump:

``` bash
mysql -u seu_usuario -p < resort_oasis_backup.sql
```

Depois da restauração, confira as tabelas, as quantidades de registros e
a execução das consultas.

## 11. Como executar o projeto

1.  Clone ou baixe o repositório.
2.  Abra o MySQL Workbench e conecte-se ao MySQL Server.
3.  Abra o script SQL do projeto.
4.  Execute o script para criar o banco, as tabelas, inserir os dados e
    disponibilizar as consultas.
5.  Rode os comandos de teste desta documentação.
6.  Execute as 15 consultas e confira os resultados.
7.  Gere um dump com estrutura e dados.
8.  Abra `OasisDiagrama.mwb` no MySQL Workbench para visualizar a
    modelagem.

> Antes de entregar, confirme que o script SQL está no repositório e que
> contém todas as etapas acima. O arquivo de modelagem `.mwb` não
> substitui o script SQL executável.

## 12. Estrutura sugerida do repositório

``` text
resort-oasis/
├── README.md
├── OasisDiagrama.mwb
├── resort_oasis_if_not_exists.sql
├── resort_oasis_backup.sql
└── docs/
    └── modelagem-resort-oasis.png
```

-   `README.md`: documentação do projeto.
-   `OasisDiagrama.mwb`: modelo editável do MySQL Workbench.
-   `resort_oasis_if_not_exists.sql`: criação do banco e tabelas, dados
    de exemplo e consultas SQL.
-   `resort_oasis_backup.sql`: dump com estrutura e dados, se solicitado
    ou utilizado como evidência.
-   `docs/modelagem-resort-oasis.png`: captura de tela do diagrama para
    visualização rápida.

Ajuste os nomes da estrutura conforme os arquivos efetivamente enviados
ao GitHub.

## 13. Entrega no Classroom

Antes de enviar, confira:

-   [ ] Repositório público ou acessível ao professor.
-   [ ] Link do GitHub inserido no Classroom.
-   [ ] Script `.sql` com criação do banco e das seis tabelas.
-   [ ] Pelo menos cinco registros em cada tabela.
-   [ ] Quinze consultas contextualizadas, com resultados conferidos.
-   [ ] Arquivo de dump com estrutura e dados, quando solicitado.
-   [ ] Arquivo de modelagem `.mwb`.
-   [ ] Print legível da modelagem lógica.
-   [ ] README atualizado e instruções de execução testadas.

------------------------------------------------------------------------

**Projeto acadêmico:** Resort Oasis --- Sistema de Gestão de Hospedagem\
**Tecnologia principal:** MySQL\
**Finalidade:** organização, consulta e integridade dos dados de um
resort fictício.
