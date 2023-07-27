# README

## how to try

run seeds to create the roles:
```bash
rails db:seed
```

## Authorization

Is handled by pundit gem, taking into account that the chat has three roles: `member` `admin` `owner`

- an `owner` is the highest level
- an `admin` is an owner with some restrictions
- a `member` is every workspace user
