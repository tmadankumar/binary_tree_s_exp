-module(binary_tree_s_exp).
-export([start/1]).

start(BTList) ->
	case check_exceptions(BTList) of
		ok ->
			start_process(BTList);
		{error,ECode} ->
			ECode
	end.

check_exceptions(BTList) ->
	check_exceptions_(BTList,[],[]).

check_exceptions_([],_LL,_RL) ->
	ok;
check_exceptions_([{L,L}|_T],_LL,_RL) ->
	{error,"E5"};
check_exceptions_([{L,R}=H|T],LL,RL) ->
	case lists:keyfind(L, 1, LL) of
		false ->
			NewLL = [{L,1}|LL],
			case lists:keyfind(R,1,RL) of
				false ->
					NewRL = [{R,1}|RL],
					check_exceptions_(T,NewLL,NewRL);
				{_,_}->
					{error,"E3"}
			end;
		{L,N}->
			if (N > 1) ->
				{error,"E1"};
			true ->
				case lists:member(H,T) of
					false ->					
						NewLL = lists:keyreplace(L, 1, LL, {L,N+1}),
						case lists:keyfind(R,1,RL) of
							false ->
								NewRL = [{R,1}|RL],
								check_exceptions_(T,NewLL,NewRL);
							{_,_}->
								{error,"E3"}
						end;
					true->
						{error,"E2"}
				end
			end
	end.	

start_process([{X,Y}|T]) ->
    S = ["("],
    E = [")"],
    L = [X],
    R = [Y],
    FLBTree = S++L++S++R++E++E,
	start_process_(T,FLBTree).

start_process_([],LBTree) ->
	lists:flatten(LBTree);
start_process_([{X,Y}|T],LBTree)->
    S = ["("],
    E = [")"],
    L = [X],
    R = [Y],
    {NewLBTree} = check_node(S,E,L,R,LBTree),
	start_process_(T,NewLBTree).

check_node(S,E,L,R,LBTree)->
	case get_index(L,LBTree) of
		not_found ->
			case get_index(R,LBTree) of
				not_found ->
					NewLBTree = LBTree++S++L++S++R++E++E,
                    {NewLBTree};
				 Index ->
					{List1,List2}=lists:split(Index-2,LBTree),
					NewLBTree = S++L++List1++List2++E,
    				{NewLBTree}
			end;
		Index ->
			case get_index(R,LBTree) of
				not_found ->
					{List1,List2}=lists:split(Index,LBTree),
					NewLBTree = List1++S++R++E++List2,
					{NewLBTree};
				_Index1 ->
					NewLBTree = get_node(L,R,LBTree),
					{NewLBTree}
			end
	end.

get_node(L,R,LBTree)->
	Index = get_index(R,LBTree),
    {_List1,List2}=lists:split(Index-2,LBTree),
    N = check_node_end_position(List2,1,0,0),
	{List3,_List4}=lists:split(N-1,List2),
    LIndex = get_index(L,LBTree),
    {List5,List6}=lists:split(LIndex,LBTree),
    {List7,_List8}=lists:split(Index-4,List6),
	List5++List3++List7.
		
check_node_end_position([],_Index,_LB,_RB) ->
	0;
check_node_end_position([H|T],Index,LB,RB)->
	case H of
		"(" ->
			LB1 = LB+1,
			check_node_end_position(T,Index+1,LB1,RB);
		")"	->
            RB1 = RB+1,
			if (LB == RB1) ->
				Index+1;
			true ->
				check_node_end_position(T,Index+1,LB,RB1)
			end;
		_Other ->
			check_node_end_position(T,Index+1,LB,RB)
	end.

get_index([Key], List) -> 
	get_index(Key, List, 1).

get_index(_, [], _)  -> 
	not_found;
get_index(Key, [Key|_], Index) -> 
	Index;
get_index(Key, [_|TList], Index) -> 
	get_index(Key, TList, Index+1).

