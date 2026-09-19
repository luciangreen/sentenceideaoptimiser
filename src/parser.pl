:- module(parser, [sentence_idea/2]).

:- use_module(library(dcg/basics)).

sentence_idea(Sentence, Idea) :-
    string_lower(Sentence, Lower),
    split_string(Lower, " ,.!?;:\n\t", "", Tokens0),
    include(nonempty, Tokens0, Tokens1),
    maplist(normalize_token, Tokens1, Tokens),
    phrase(idea(Idea), Tokens), !.
sentence_idea(Sentence, idea(unknown, unknown_concepts(Unknown))) :-
    string_lower(Sentence, Lower),
    split_string(Lower, " ,.!?;:\n\t", "", Tokens0),
    include(nonempty, Tokens0, Unknown).

nonempty(S) :- S \= "".

normalize_token(Token, Normalized) :-
    atom_string(AtomToken, Token),
    Normalized = AtomToken.

idea(idea(operation(find_positions), item(a), source(input), property(position), quantifier(all), result(positions))) -->
    [find,the,position,of,every,a,in,the,input,and,return,the,positions].
idea(sequence([reverse(list,input,reversed), first(reversed,output)])) -->
    [reverse,the,list,and,take,the,first,item].
idea(sequence([reverse(input,reversed), first(reversed,output)])) -->
    [reverse,a,'non-empty',list,and,return,the,first,item].
idea(pipeline([apply(p), apply(q)])) --> [apply,p,and,then,q].
idea(sequence([for_every(character), return(index)])) -->
    [for,every,character,return,its,index].
idea(code(member_collect)) -->
    [call,member,on,the,list,and,collect,every,successful,x].
