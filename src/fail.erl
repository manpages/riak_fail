-module(fail).
-include_lib("riak_core/include/riak_core_vnode.hrl").

-define(N, 5).

-export([ ping/0
         ,start_session/2 % Starts a simple user/password session at fail_sessions_vnode
         ,get/2           % Gets a value under a key if the user/password tuple is correct
         ,set/3           % Sets a value under a key if the user/password tuple is correct
       ]).

%% api

ping() ->
  [{Node, _Type} | _] = preference_list({<<"ping">>, term_to_binary(os:timestamp())}, fail),
  riak_core_vnode_master:sync_spawn_command(Node, ping, rts_vnode_master).

%% internal functions

preference_list(Key, Service) ->
  DocIdx = riak_core_util:chash_key(Key, Service),
  PreferenceList = riak_core_apl:get_apl(DocIdx, ?N, Service).
