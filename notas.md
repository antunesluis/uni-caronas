# Caronas Universitárias - Notas do Projeto

## Descrição Geral

Este projeto é uma aplicação web de caronas universitárias que conecta estudantes de diferentes universidades, permitindo que motoristas ofereçam caronas para determinadas rotas e que passageiros possam reservar um lugar na carona. A aplicação não inclui um sistema de pagamentos interno ou de mensagens. As caronas são publicadas com informações de contato e chave Pix para pagamento direto entre as partes.

### Funcionalidades Principais

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

5. **Reservas (Bookings)**:
   - Passageiros podem reservar um lugar em uma carona específica para um destino específico.
   - O status da reserva pode ser `pending`, `confirmed` ou `cancelled`.

### Estrutura do Banco de Dados (PostgreSQL)

- A estrutura de banco de dados foi projetada para garantir integridade referencial e consistência, usando relações entre as tabelas `users`, `universities`, `rides`, `ride_destinations` e `bookings`.
- Índices foram criados para melhorar a performance de consultas frequentes, como busca por caronas e reservas.

### Tabelas Principais

1. **Tabela `users`**:
   - Armazena informações dos usuários cadastrados (motoristas e passageiros).
   - Inclui campos para nome, email, telefone e chave Pix.

2. **Tabela `universities`**:
   - Armazena os dados das universidades cadastradas, incluindo cidade e estado.

3. **Tabela `rides`**:
   - Registra as caronas publicadas pelos motoristas.
   - Contém informações como data e hora de partida, universidade de origem e número de assentos disponíveis.

4. **Tabela `ride_destinations`**:
   - Registra os destinos da carona, incluindo cidade, estado, preço e ordem das paradas.

5. **Tabela `bookings`**:
   - Armazena as reservas de passageiros para as caronas.
   - Cada reserva está associada a uma carona e a um destino específico.

### Índices

- **Índices de performance** foram criados para as seguintes consultas:
  - Busca por data de partida da carona.
  - Busca por universidade de origem.
  - Busca por destinos e reservas de caronas.

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

## Imagem tabelas: 


