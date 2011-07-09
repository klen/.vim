-module(eb_sup).
-behaviour(supervisor).
-export([
    start_link/0
]).
-export([
    init/1
]).

-define(SERVER, ?MODULE).

%% @spec start_link() -> {ok,Pid} | ignore | {error,Error}
%% @doc Starts the supervisor
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% @spec init(Args) -> {ok,  {SupFlags,  [ChildSpec]}} |
%%                     ignore                          |
%%                     {error, Reason}
%% @doc Whenever a supervisor is started using
%%      supervisor:start_link/[2,3], this function is called by the new process
%%      to find out about restart strategy, maximum restart frequency and child
%%      specifications.
init([]) ->
    Child = { name,
                { module, start_link, [] },
                permanent, 2000, worker, [ module ]},
    Children = [ Child ],
    RestartStrategy = { one_for_one, 0, 0},
    {ok, { RestartStrategy, Children } }.
