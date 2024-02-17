## Prerequisites
- ruby-3.0.3
- postgresql

## Steps to run in local

Navigate to backend directory

### `rails db:setup`

This will create your database and seed the needed data in order to start user and doorkpeer functionalities.

Check `/oo-parking-lot/backend/db/seeds/development.rb` to see the user for initial login.

### `rails s`
Navigate browser to `http://localhost:3000`

You will see the needed credentials to run frontend.
Something like this.
```
{
"name"=>"Sample Client",
"client_id"=>"xxxxxxxxxxxxXXXxxxxxxxxxXXxXXxxxxXXxX",
"client_aecret"=>"xxxxxxxxxxxxXXXxxxxxxxxxXXxXXxxxxXXxX"
}
```