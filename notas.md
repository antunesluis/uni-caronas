# Caronas Universitárias - Notas do Projeto

## Páginas principais

- Login: Formulário de email e senha para login de usuário;
- Home: Lista de caronas disponíveis com filtros;
- Cadastro Carona: Formulário para publicar uma nova carona;
- Perfil Usuário: Informações do usuário e suas caronas publicadas;
- Informações corrida: Expande a exibição dos detalhes da corrida

## Diagrama UML

### Ator

- Usuário (realiza login)

  - Motoristas (cria corrida)
  - Passageiros. (entram em corridas)

- administrador/curador (excluir corridas ou usuários).

### Hierarquia de ações

- Menu inicial:
  - Realizar login.
  - Visualizar corridas adicionadas.
  - Visualizar minhas corridas recentes.
  - Pesquisar corridas.
  - Pesquisar usuários.
  - Abrir meu perfil.
  - Criar carona.
  - Expandir informações da corrida.
- Login:
  - Conectar usuário:
    - Adicionar email.
    - Adicionar senha.
  - Registrar usuário:
    - Adicionar nome completo.
    - Adicionar pix.
    - Adicionar numero de telefone.
    - Adicionar email.
    - Adicionar senha.
- Meu perfil:
  - Adicionar foto.
  - Modificar nome.
  - Modificar pix.
  - Modificar numero.
  - Histórico de corridas criadas.
- Pagina dos outros usuários:
  - Visualizar dados.
  - Visualizar histórico de corridas.
  - Avaliar usuário.
- Detalhes da corrida:
  - Visualizar dados usuário.
  - Visualizar preço.
  - Visualizar data de partida.
  - Visualizar origem.
  - Visualizar destino.
  - Visualizar paradas.
  - Visualizar descrição.
- Criação de corrida:
  - Adicionar paradas:
    - Adicionar destino.
    - Adicionar origem.
    - Adicionar valor.
  - Adicionar horário e data de partida.
  - Adicionar descrição.

## Esquema do banco de dados

```dbml
Table users {
  id integer [primary key]
  name varchar(100) [not null]
  email varchar(100) [not null, unique]
  password varchar(255) [not null]
  phone varchar(20)
  pix_key varchar(100)
  created_at timestamp [default: `CURRENT_TIMESTAMP`]
}

Table universities {
  id integer [primary key]
  name varchar(100) [not null]
  city varchar(100) [not null]
  state char(2) [not null]
}
Table rides {
  id integer [primary key]
  driver_id integer [ref: > users.id]

  university_origin_id integer [ref: > universities.id]
  departure_datetime timestamp [not null]
  available_seats integer [not null]
  route_description text
  status varchar(20) [default: 'active']
  created_at timestamp [default: `CURRENT_TIMESTAMP`]
}

Table ride_destinations {
  id integer [primary key]
  ride_id integer [ref: > rides.id]
  city varchar(100) [not null]
  state char(2) [not null]
  price decimal(10,2) [not null]
  order_num integer [not null]

  indexes {
    (ride_id, order_num) [unique]
  }
}

Table bookings {
  id integer [primary key]
  ride_id integer [ref: > rides.id]
  passenger_id integer [ref: > users.id]
  destination_id integer [ref: > ride_destinations.id]
  status varchar(20) [default: 'pending']
  booked_at timestamp [default: `CURRENT_TIMESTAMP`]
}

Indexes {
  (rides.departure_datetime)
  (rides.university_origin_id)
  (ride_destinations.ride_id)
  (bookings.ride_id)
  (bookings.destination_id)
}```

## Tabelas Principais

1. **Usuários (Users)**:
   - Cadastro de usuários com nome, email, telefone e chave Pix (opcional).

1. **Universidades (Universities)**:
   - Cada universidade tem um nome, cidade e estado.
   - Motoristas especificam a universidade de origem ao oferecer uma carona.

3. **Caronas (Rides)**:
   - Motoristas publicam suas caronas, especificando o horário de partida, a universidade de origem, assentos disponíveis, e a rota.
   - O status da carona pode ser `active`, `completed` ou `cancelled`.

4. **Destinos das Caronas (Ride Destinations)**:
   - Cada carona pode passar por várias cidades (destinos).
   - A ordem das paradas é registrada e os preços são definidos por destino.

1. **Reservas (Bookings)**:
   - Passageiros podem reservar um lugar em uma carona específica para um destino específico.
   - O status da reserva pode ser `pending`, `confirmed` ou `cancelled`.
   - Relaciona-se com caronas e usuarios (passageiro).


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
