# README

YEGRB - Edmonton's Ruby Meetup

This site will be dedicated to all things ruby in the Edmonton area. 
Future features will include user accounts, a mailing list, and a job board. 

First thing's first, and that involves installing Postgres: 

Mac OSX

  First, you need to remove previous versions of PostgreSQL
  
  <code>
  brew uninstall --force postgresql
  </code>
  
  Next up, delete all Postgres files
  
  <code>rm -rf /usr/local/var/postgres</code>
  
  Install Postgres with homebrew 
  
  <code>brew install postgres</code>
  
  Fire up new PostgreSQL server 
  <code>pg_ctl -D /usr/local/var/postgres start</code>
  
  Create Database 
  <code>initdb /usr/local/var/postgres</code>
  
  And that should do it. Any issues can be forwarded to alan@alanvardy.com 

