# My Sinatra / Heroku Template

## Run Locally

```
$ cp .env.sample .env
$ bundle install
$ bundle install
Using daemons (1.1.8) 
Using eventmachine (0.12.10) 
Using rack (1.4.1) 
Using rack-protection (1.2.0) 
Using shotgun (0.9) 
Using tilt (1.3.3) 
Using sinatra (1.3.3) 
Using thin (1.4.1) 
Using bundler (1.2.0.pre.1) 
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
$ ./dev.sh
== Shotgun/Thin on http://127.0.0.1:5000/
>> Thin web server (v1.4.1 codename Chromeo)
>> Maximum connections set to 1024
>> Listening on 127.0.0.1:5000, CTRL+C to stop
```

## Run on Heroku

```
$ heroku create
Creating floating-depths-3547... done, stack is cedar
http://floating-depths-3547.herokuapp.com/ | git@heroku.com:floating-depths-3547.git
Git remote heroku added
$ git push heroku master
Counting objects: 11, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (7/7), done.
Writing objects: 100% (11/11), 1.41 KiB, done.
Total 11 (delta 0), reused 0 (delta 0)

-----> Heroku receiving push
-----> Ruby/Rack app detected
-----> Installing dependencies using Bundler version 1.2.1
       Running: bundle install --without development:test --path vendor/bundle --binstubs bin/ --deployment
       Fetching gem metadata from http://rubygems.org/.......
       Installing daemons (1.1.8)
       Installing eventmachine (0.12.10) with native extensions
       Installing rack (1.4.1)
       Installing rack-protection (1.2.0)
       Installing shotgun (0.9)
       Installing tilt (1.3.3)
       Installing sinatra (1.3.3)
       Installing thin (1.4.1) with native extensions
       Using bundler (1.2.1)
       Your bundle is complete! It was installed into ./vendor/bundle
       Cleaning up the bundler cache.
-----> Discovering process types
       Procfile declares types     -> web
       Default types for Ruby/Rack -> console, rake
-----> Compiled slug size: 2.1MB
-----> Launching... done, v3
       http://floating-depths-3547.herokuapp.com deployed to Heroku

To git@heroku.com:floating-depths-3547.git
 * [new branch]      master -> master
```
