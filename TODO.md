# Promise ToDo list

## Before

- [x] Add Credo and Dialyxir
- [x] Add OpenAPI spec library
- [x] Fix possible Credo warnings
- [x] Add auth
  - [x] Add users table
  - [x] Add Guardian module
  - [x] Edit users paths according to auth
    - [x] Add `/api/tokens/` for token creation
    - [x] Add auth plug to user's `put` and `delete`
    - [x] Move user's `put` and `delete` over auth plug
  - [x] Enable CORS
  - [x] Add docs for paths
  - [x] Use build in guardian plugs
- [x] Use SecretVault for storing secrets
- [x] Add dockerfile and docker-compose for developing
- [x] Response tokens in cookies

# Databaes

- [x] Add goals
- [x] Add goal_joins
- [x] Add goal_subscribers
- [ ] Add goal_reactions
- [ ] Add goal_posts

# FIXMEs

- [ ] Can't delete account, when you're author of some goal
