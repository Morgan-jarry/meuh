READMEUH
========

Meuh is a very low artificial intelligence for a very stupid IRC channel bot
companion.

Example conversation
--------------------

    <quelquun> lu
    <Meuh> stucru
    <quelquun> lol
    <Meuh> mdr
    <quelquun> t'es nouvelle Meuh?
    <Meuh> euh ouais
    <quelquun> cool
    <quelquun> où est-ce que t'habite ?
    <Meuh> dtc
    <quelquun> …
    <quelquun> je déteste les gens.
    <quelquun> s/gens/bots/
    <Meuh> je déteste les bots.


Usage
-----

You can use the robot with `Cinch`. Checkout out `examples/cinch_bot.rb` for
an example of how to start it.


If you want to integrate Meuh's brain in another messaging system, you can:

```rb
require "meuh"

bot = Meuh::Brain.new(botname: "TODO")
bot.message(nickname: "TODO", message: "TODO", nicknames: ["TODO", "TODO"]) do |response|
  puts response
end
```

Development
-----------

You will need git, Ruby and the bundler gem. Then you should:

```sh
$ git clone https://github.com/sunny/meuh
$ cd meuh
$ bundle
```

Launch tests to make sure the brain still functions:

```sh
$ bundle exec rspec
```


Contributing
------------

Feel free to contribute by adding more stupidity to this bot. Please send
patches through Github pull requests and submit bugs through Github issues

https://github.com/sunny/meuh
