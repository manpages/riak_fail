-module(fail).
-include_lib("riak_core/include/riak_core_vnode.hrl").

-export([ ping/0
         ,start_session/2 % Starts a simple user/password session at fail_sessions_vnode
         ,get/2           % Gets a value under a key if the user/password tuple is correct
         ,set/3           % Sets a value under a key if the user/password tuple is correct
       ]).

%% api

%% internal functions
