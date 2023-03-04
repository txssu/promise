# MotivNation ToDo list
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
    - [x] Add token revoking
        - [x] Add GuardianDB
        - [x] Add path for token revoking
    - [x] Use build in guardian plugs
- [x] Use SecretVault for storing secrets
- [ ] Add dockerfile and docker-compose
