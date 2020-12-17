Erlang Remote Shell Example
===========================

A minimalistic example of connecting to remote Erlang shell.

How To Use
----------

In shell #1:

    $ make sh1

Then, in shell #2:

    $ make sh2

In both shells, try:

    > postman:status().
    > postman:send("hello world").

and you'll see the same result.

While doing all of above, try running [Erlang Top](https://erlang.org/doc/apps/observer/etop_ug.html) in shell #3 by:

    $ make etop
