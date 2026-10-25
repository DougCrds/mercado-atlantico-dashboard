# Mercado Atlântico | Dashboard de Análise de Dados

## Sobre o projeto

Desenvolvi do zero um dashboard interativo no Power BI para apoiar a análise de dados e o acompanhamento de indicadores operacionais e financeiros no varejo supermercadista.

O projeto evoluiu de uma ferramenta de visualização de indicadores para uma solução de apoio à tomada de decisão, reunindo informações relevantes para o acompanhamento das filiais, a análise de produtos e o gerenciamento de estoque.

## Relatórios desenvolvidos

### 1. Desempenho Geral

Visão consolidada dos indicadores financeiros das filiais, permitindo acompanhar os resultados e comparar o desempenho entre unidades.

### 2. Desempenho de Produtos

Análise de indicadores como estoque atual, situação do estoque, margem, faturamento, venda média diária, produtos mais vendidos e evolução das vendas ao longo do tempo.

### 3. Gestão de Estoque

Monitoramento de níveis de estoque, identificação de possíveis rupturas e sugestões de reposição com base no histórico de vendas, apoiando o planejamento de compras.

## Fontes de dados e integração

Os dados utilizados no projeto foram obtidos de um banco de dados Firebird e integrados ao Power BI por meio de conexão ODBC e do Power Query.

Foram utilizadas tabelas e visões relacionadas a vendas, cadastro de produtos, estoque, recebimentos e seções de produtos.

A extração foi realizada por meio de consultas SQL e da importação de tabelas pelo Power Query, conforme a necessidade de cada análise. A tabela `secoes`, por exemplo, foi importada diretamente do banco de dados e utilizada para complementar a identificação das seções às quais os produtos pertencem.

## Tecnologias utilizadas

- Power BI
- SQL
- Power Query
- Firebird
- ODBC
As consultas utilizadas no projeto podem ser encontradas na pasta ['sql'](sql/)
## Objetivo

Aplicar análise de dados para transformar informações operacionais em indicadores úteis, facilitar a identificação de oportunidades e apoiar decisões relacionadas ao desempenho das filiais e à gestão de estoque.

## Observação

Projeto desenvolvido com dados empresariais para fins de análise e melhoria de processos. Os materiais disponibilizados neste repositório devem respeitar a confidencialidade das informações da empresa. Dados sensíveis, credenciais e informações comerciais restritas não devem ser divulgados.
