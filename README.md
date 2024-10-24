# Uni Caronas

## Estrutura

```shell
uni-caronas/
├── client/                 # Frontend
│   ├── public/
│   ├── src/
│   │   ├── components/     # Componentes React
│   │   ├── pages/          # Páginas da aplicação
│   │   ├── services/       # Serviços de API
│   │   ├── context/        # Contextos React (se necessário)
│   │   ├── styles/         # Estilos globais
│   │   └── App.js
│   └── package.json
├── server/                 # Backend
│   ├── src/
│   │   ├── controllers/    # Controladores
│   │   ├── models/         # Modelos de dados
│   │   ├── routes/         # Rotas da API
│   │   ├── middleware/     # Middlewares
│   │   └── app.js
│   └── package.json
└── README.md
```

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
  - Adicionar descrição
