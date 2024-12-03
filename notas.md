# Caronas Universitárias - Notas do Projeto

## Páginas principais

- Login: Formulário de email e senha para login de usuário;
- Home: Lista de ultimas caronas criadas;
- Cadastro Carona: Formulário para publicar uma nova carona;
- Perfil Usuário: Informações do usuário e suas caronas criadas;
- Perfil usuário externo: informações da conta e corridas criadas pelo usuário e avaliação média (permite avaliar usuário);
- Informações corrida: Expande a exibição dos detalhes da corrida_id

## Descrição projeto

Irá funcionar como um sistema de classificados de caronas universitárias.

Os motoristas criam corridas com origem, destino, data e horário de partida, quantidade de bancos disponíveis e preço.

Os motoristas também podem adicionar paradas intermediárias com preço adicional.

Os usuários interessados na corrida entram em contato com o motorista através dos dadas de contato disponibilizados no
perfil do motorista e organiza pagamento e detalhes.

Não existe ligação entre motoristas e passageiros em uma corrida a nível de sistema, apenas
corridas criadas pelo motoristas e os usuários interessados que entram em
contato por meios externos.

Os perfis de usuários irão conter informações de contato e chave pix. Irá exibir corridas criadas pelo usuário

Qualquer usuário pode avaliar um perfil externo de 0 a 5 estrelas.

Não irá possuir sistema de pagamentos ou mensageria integrado, o contato e pagamento deve ocorrer por fora pelos meios
de contato definidos no perfil.

## Esquema do banco de dados

```dbml
Table usuario {
  id integer [primary key]
  nome varchar(100) [not null]
  email varchar(100) [not null, unique]
  senha varchar(255) [not null]
  telefone varchar(20)
  chave_pix varchar(100)
  avaliacao_media decimal(3, 2) [default: 0.0, not null]
  data_criacao timestamp [default: `CURRENT_TIMESTAMP`]
}

Table corrida {
  id integer [primary key]
  id_motorista integer [ref: > usuario.id]
  origem integer [ref: > cidade.id]
  destino integer [ref: > cidade.id]
  data_partida timestamp [not null]
  preco decimal(10, 2) [not null]
  bancos_totais integer [not null]
  descricao_corrida text
  data_criacao timestamp [default: `CURRENT_TIMESTAMP`]            
}

Table avaliacao {
  id integer [primary key]
  id_avaliador integer [ref: > usuario.id]
  id_avaliado integer [ref: > usuario.id]
  nota decimal(3,2) [not null]
}

Table cidade {
  id integer [primary key]
  nome varchar(100) [not null]
  estado varchar(2) [not null] 
}

Table parada {
  id integer [primary key]
  corrida_id integer [ref: > corrida.id] 
  cidade_parada integer [ref: > cidade.id]
  preco decimal(10, 2) [not null]
  ordem integer
}
```

## Tecnologias

- Frontend:
  - React.js (criação da interface).
  - React Router (navegação entre páginas).
  - Axios (requisições HTTP para backend).
  - CSS Framework: Tailwind CSS ou Material UI para estilização.

- Backend:
  - Node.js com Express (API REST).
  - PostgreSQL (banco de dados)
  - JWT para autenticação.
