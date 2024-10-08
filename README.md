# 🛢️ Projeto de Banco de Dados - Posto de Gasolina ⛽

> Submetido como CheckPoint 5 da disciplina MASTERING RELATIONAL AND NON-RELATIONAL DATABASE. 📚

## 📖 Descrição do Projeto
Este projeto é um sistema de banco de dados para um posto de gasolina, desenvolvido como parte do CP5 da disciplina de Banco de Dados. O objetivo é gerenciar informações sobre combustíveis, vendas, funcionários, produtos e serviços oferecidos no posto. O banco de dados foi criado utilizando **SQL Oracle**.

## 🏗️ Estrutura do Banco de Dados

### 📋 Tabelas Criadas
Aqui estão as principais tabelas que compõem o banco de dados:

1. **Bomba** 🛠️
   - Armazena informações sobre as bombas de combustível.
  
2. **Combustível** ⛽
   - Contém os tipos de combustíveis e seus preços por litro.

3. **Forma de Pagamento** 💳
   - Detalha as diferentes formas de pagamento aceitas.

4. **Funcionário** 👷
   - Informações sobre os funcionários do posto.

5. **Nota de Pagamento** 🧾
   - Relaciona as formas de pagamento com as notas fiscais.

6. **Nota Fiscal** 📑
   - Armazena as informações sobre as vendas realizadas.

7. **Posto** 🏪
   - Informações sobre os postos de gasolina.

8. **Produto** 🛒
   - Detalhes dos produtos disponíveis para venda.

9. **Serviço** ⚙️
   - Serviços oferecidos no posto, como troca de óleo.

10. **Tanque** 🛢️
    - Detalhes sobre os tanques de armazenamento de combustíveis.

11. **Venda** 💰
    - Registros de vendas realizadas no posto.

### 🔗 Relacionamentos
O banco de dados inclui diversas **chaves estrangeiras** para garantir a integridade referencial entre as tabelas, conectando bombas a combustíveis, vendas a postos, e muito mais.

## 📊 Diagramas

### Diagrama Entidade-Relacionamento Lógico
![Diagrama Entidade-Relacionamento Lógico](https://github.com/user-attachments/assets/82bf8478-0993-4f25-b74f-4da44d93de57)


### Diagrama Entidade-Relacionamento Relacional
![Diagrama Entidade-Relacionamento Relacional](https://github.com/user-attachments/assets/5f51c6ad-22e7-41cf-b5e1-61e107dec0ad)


## 📅 Exemplos de Uso
- **Registrar uma venda** 💵
- **Consultar preços de combustíveis** 🔍
- **Gerenciar estoque de produtos** 📦

## 🛠️ Tecnologias Utilizadas
- **Banco de Dados**: Oracle SQL
- **SQL**: Para manipulação e consulta de dados.

## 🫂 Integrantes

Aqui estão os membros do grupo que participaram durante desenvolvimento desta SPRINT.

* **RM 552267 - Bianca Leticia Román Caldeira**
  - Turma: 2TDSPH

* **RM 552258 - Laís Alves da Silva Cruz**
  - Turma: 2TDSPH

* **RM 552252 – Charlene Aparecida Estevam Mendes Fialho**
  - Turma: 2TDSPH

<table>
  <tr>
        <td align="center">
      <a href="https://github.com/biancaroman">
        <img src="https://avatars.githubusercontent.com/u/128830935?v=4" width="100px;" border-radius='50%' alt="Bianca Román's photo on GitHub"/><br>
        <sub>
          <b>Bianca Román</b>
        </sub>
      </a>
    </td>
     <td align="center">
      <a href="https://github.com/laiscrz">
        <img src="https://avatars.githubusercontent.com/u/133046134?v=4" width="100px;" alt="Lais Alves's photo on GitHub"/><br>
        <sub>
          <b>Lais Alves</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/charlenefialho">
        <img src="https://avatars.githubusercontent.com/u/94643076?v=4" width="100px;" border-radius='50%' alt="Charlene Aparecida's photo on GitHub"/><br>
        <sub>
          <b>Charlene Aparecida</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
