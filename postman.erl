-module(postman).

-export([
         start/0,
         stop/0,
         status/0,
         send/1,
         kill/0
        ]).

start() ->
    case whereis(postman) of
        undefined ->
            Pid = spawn_link(fun loop/0),
            true = register(postman, Pid),
            ok;
        Pid ->
            {error, {already_running, Pid}}
    end.

stop() ->
    case whereis(postman) of
        undefined ->
            {error, not_running};
        Pid ->
            unregister(postman),
            unlink(Pid),
            Pid ! {quit, self()},
            receive Ret -> Ret end
    end.

status() ->
    case whereis(postman) of
        undefined ->
            {ok, not_running};
        Pid ->
            {ok, {already_running, Pid}}
    end.

send(Msg) ->
    postman ! {message, self(), Msg}.

kill() ->
    postman ! {kill, self()}.

loop() ->
    receive
        {quit, From} ->
            From ! ok;
        {message, From, Msg} ->
            io:format("message from ~p: ~p~n", [From, Msg]),
            loop();
        {kill, From} ->
            io:format("killed by ~p~n", [From]),
            exit({killed, From});
        Input ->
            io:format("unhandled input: ~p~n", [Input]),
            loop()
    end.
