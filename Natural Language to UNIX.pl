/*agent*/
agent:-
	perceive(Percepts),
	action(Percepts).

/*Perceive
 *Parses a sentence*/
perceive(Percepts):-
	write('Enter a command'),nl,nl,
	read(Percepts).

/*Action
 *Responds accordingly*/
action(Percepts):-
	synonymToBase(Percepts,UpdatedPercepts),
	sentence(UpdatedPercepts,sentence(Noun_Phrase,Verb_Phrase)),
	formatsentence(Noun_Phrase,Verb_Phrase,NP,Verb,NP2),
	rule(_,NP,Verb,NP2,Output),
	write(Output).

formatsentence(Noun_Phrase,Verb_Phrase,NP,Verb,NP2):-
	Noun_Phrase = np(_,NP),
	Verb_Phrase = vp(verb(Verb),Rest),
	removehead(Rest,NP2).

/*removehead */
removehead(Sentence,Output):-
	Sentence = pp(_,Rest),
	removehead(Rest,Output);

	Sentence = np(_,Rest),
	removehead(Rest,Output).

removehead(Sentence,Output):-
	Output = Sentence.

/*rule1*/
rule(Rule,Noun_Phrase,Verb,Noun_Phrase2,Output):-
	Rule = r1,
	Noun_Phrase = np2(adj(very),np2(adj(short),np2(noun(command)))),
	Verb = listing,
	Noun_Phrase2 = np2(adj(current),np2(noun(directory))),
	Output = 'ls',!.

/*rule2*/
rule(Rule,Noun_Phrase,Verb,Noun_Phrase2,Output):-
	Rule = r2,
	Noun_Phrase = np2(adj(current),np2(noun(directory))),
	Verb = viewed,
	Noun_Phrase2 = np2(adj(more),np2(adj(fine),np2(noun(detail)))),
	Output = 'ls -la',!.

/*rule3*/
rule(Rule,Noun_Phrase,Verb,Noun_Phrase2,Output):-
	Rule = r3,
	Noun_Phrase = np2(noun(command)),
	Verb = moving,
	Noun_Phrase2 = np2(adj(higher),np2(noun(directory))),
	Output = 'cd..',!.

/*rule4*/
rule(Rule,Noun_Phrase,Verb,Noun_Phrase2,Output):-
	Rule = r4,
	Noun_Phrase = np2(noun(command)),
	Verb = prints,
	Noun_Phrase2 = np2(adj(current),np2(noun(directory))),
	Output = 'pwd',!.

/*rule5*/
rule(Rule,Noun_Phrase,Verb,Noun_Phrase2,Output):-
	Rule = r5,
	Noun_Phrase = np2(noun(command)),
	Verb = types,
	Noun_Phrase2 = np2(adj(file), np2(noun('08226txt'))),
	Output = 'cat 08226.txt'.

/*Sentence*/
sentence(Sentence,sentence(Noun_Phrase,Verb_Phrase)):-
	np(Sentence,Noun_Phrase,Rem),
	vp(Rem,Verb_Phrase).
sentence(Sentence,sentence(vp(Verb_Phrase))):-
	vp(Sentence,Verb_Phrase).

/*Noun Phrase*/
np([X|T],np(det(X),NP2),Rem):-
	det(X),
	np2(T,NP2,Rem).
np(Sentence,Parse,Rem):-
	np2(Sentence,Parse,Rem).
np(Sentence,np(NP,PP),Rem):-
	np(Sentence,NP,Rem1),
	pp(Rem1,PP,Rem).

/*Noun Phrase 2*/
np2([H|T],np2(noun(H)),T):-
	noun(H).
np2([H|T],np2(adj(H),Rest),Rem):-
	adj(H),np2(T,Rest,Rem).

/*Prepositional Phrase*/
pp([H|T],pp(prep(H),Parse),Rem):-
   prep(H),
   np(T,Parse,Rem).

/*Verb Phrase*/
vp([H|[]],verb(H)):-
	verb(H).
vp([H|T],vp(verb(H),adverb(T))):-
	verb(H),
	adverb(T).
vp([H,S|T],vp(verb(H),adverb(S),RestParsed)):-
	verb(H),
	adverb(S),
	np(T,RestParsed,[]).
vp([H|Rest],vp(verb(H),RestParsed)):-
	verb(H),
	pp(Rest,RestParsed,[]).
vp([H|Rest],vp(verb(H),RestParsed)):-
	verb(H),
	np(Rest,RestParsed,[]).

synonymToBase([],[]).
synonymToBase([Head|Tail], [UpdatedHead|Rest]):-
	synonym([Root|List]),

	(member(Head, [Root|List]), UpdatedHead = Root, synonymToBase(Tail, Rest));
	UpdatedHead = Head, synonymToBase(Tail,Rest).


synonym([moving,moves]).
synonym([command,instruction]).
synonym([higher,parent]).
synonym([directory,folder]).
synonym([types,views,cats]).


/*Determiner*/
det(the).
det(a).

/*Noun*/
noun(command).
noun(directory).
noun(folder).
noun(detail).
noun('08226txt').


/*Verb*/
verb(listing).
verb(viewed).
verb(prints).
verb(moving).
verb(moves).
verb(types).

/*Adverb*/
adverb(very).

/*Adverb*/
adj(current).
adj(very).
adj(short).
adj(more).
adj(fine).
adj(higher).
adj(parent).
adj(file).

/*Preposition*/
prep(in).
prep(to).




























