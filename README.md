# binary_tree_s_exp
Binary tree String Expression Refresentation
-------------------------------------------------------------------------------------
BINARY TREE STRING REPRESENTATION PROGRAM
--------------------------------------------------------------------------------------

USEAGE:

> c(binary_tree_s_exp).                                                                                
Result:  {ok,binary_tree_s_exp} 


> binary_tree_s_exp:start([{"A","B"} ,{"A","C"}, {"B","D"} ,{"D","C"}]).
Result: "E3"


> binary_tree_s_exp:start([{"A","B"}, {"A","C"}, {"B","G"}, {"C","E"},{"C","H"}, {"E","F"}, {"B","D"}]).
Result: "(A(C(H)(E(F)))(B(D)(G)))"
