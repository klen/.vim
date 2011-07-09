-module(app).
-behaviour(application).
-export([
    start/2,
    stop/1
]).

%% @spec start(Type, StartArgs) -> {ok, Pid} | Error
%% @doc This function is called whenever an application
%%      is started using application:start/1,2, and should start the processes
%%      of the application.
start(_Type, StartArgs) ->
    case 'TopSupervisor':start_link(StartArgs) of
        {ok, Pid} -> 
            {ok, Pid};
        Error ->
            Error
    end.

%% @spec stop(State) -> ok
%% @doc This function is called whenever an application
%%      has stopped.
stop(_State) ->
    ok.
