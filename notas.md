# Caronas Universitárias - Notas do Projeto

## Páginas principais

- Login: Formulário de email e senha para login de usuário;
- Home: Lista de caronas disponíveis com filtros;
- Cadastro Carona: Formulário para publicar uma nova carona;
- Perfil Usuário: Informações do usuário e suas caronas publicadas ou recentes (permite avaliar);
- Perfil usuário externo: informações da conta e corridas criadas pelo usuário e avaliação média
- Informações corrida: Expande a exibição dos detalhes da corrida_id

## Descrição projeto

- Irá funcionar como um sistema de classificados de caronas universitárias.
- Os motoristas criam corridas com origem, destino, data e horário de partida, quantidade de bancos disponíveis e preço.
- Os motoristas também podem adicionar paradas intermediárias com preço adicional.
- Os perfis de usuários irão conter informações de contato e chave pix. Irá exibir corridas recentes que o usuário participou e permitir avaliar elas.
- É possível solicitar para participar de uma corrida.
- Não irá possuir sistema de pagamentos ou mensageria integrado, o contato e pagamento deve ocorrer por fora pelos meios de contato definidos no perfil.
-

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
  bancos_livres integer [not null]
  descricao_corrida text
  status enum('active', 'completed', 'cancelled') [default: 'active']
  data_criacao timestamp [default: `CURRENT_TIMESTAMP`]            
}

Table avaliacao {
  id integer [primary key]
  id_avaliador integer [ref: > usuario.id]
  id_avaliado integer [ref: > usuario.id]
  corrida_id integer [ref: > corrida.id]
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
  cidade_origem_id integer [ref: > cidade.id]
  cidade_destino_id integer [ref: > cidade.id]
  preco decimal(10, 2) [not null]
  ordem integer
}

Table passageiro_corrida {
  corrida_id integer [ref: > corrida.id]
  id_usuario integer [ref: > usuario.id]
  status enum('confirmed', 'cancelled', 'pending') [default: 'pending']
  primary key (corrida_id, id_usuario)
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
