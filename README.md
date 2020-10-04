# YEGRB - Edmonton's Ruby Meetup

This site is dedicated to all things ruby in the Edmonton area.
Future features will include user accounts, a mailing list, and a job board.

## Getting Started

1. Clone this repository with `git clone git@github.com:yegrb/yegrb.com.git`
2. Use rbenv or RVM to install correct version of Ruby (see .ruby-version)
3. Make sure to have Postgres installed and configured on system (See below for Mac OSX instructions)
4. Copy `.env.example` and rename it `.env`.
5. Fill `.env` environment variables with the administrator details.
6. Run `bundle install` to install gems
7. Run `bin/rails db:setup` to create databases
8. Run `bin/rails db:seed` to create administrator account
9. You can optionally run `bin/rails db:fill` to fill the site with hilarious fake data.
10. Create a new branch with `git checkout -b new_branch`
11. Make modifications and push code with:

```bash
git add .
git commit -m 'Describe your changes'
git push
```

12. And open up a pull request on GitHub!

## Enable caching in development

The Meetup API is slow when a lot of separate requests are made, so in-memory caching is used. It is turned on in production automatically but will need to be toggled on in development using `rails dev:cache` if you want to utilize it.

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

Drop us a line at: contact@mail.yegrb.com
