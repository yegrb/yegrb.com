# YEGRB - Edmonton's Ruby Meetup

This site is dedicated to all things ruby in the Edmonton area.
Future features will include user accounts, a mailing list, and a job board.

## Getting Started

1. Clone this repository with `git clone git@github.com:yegrb/yegrb.com.git`
2. Use rbenv or RVM to install correct version of Ruby (see .ruby-version)
3. Make sure to have Postgres installed and configured on system (See below for Mac OSX instructions)
4. Rename .env.example to .env and fill in the environment variables
5. Run `bundle install` to install gems
6. Run `bin/rails db:setup` to create databases
7. Run `bin/rails db:seed` to create administrator account
8. Create a new branch with `git checkout -b new_branch`
9. Make modifications and push code with:

```bash
git add .
git commit -m 'Describe your changes'
git push
```

10. And open up a pull request on GitHub!

## Installing Postgresql on Mac OSX

First, you need to remove previous versions of PostgreSQL

`brew uninstall --force postgresql`

Next up, delete all Postgres files

`rm -rf /usr/local/var/postgres`

Install Postgres with homebrew

`brew install postgres`

Fire up new PostgreSQL server

`pg_ctl -D /usr/local/var/postgres start`

Create Database

`initdb /usr/local/var/postgres`

## Contact

Drop me a line at: alan@alanvardy.com
