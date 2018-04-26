# Prolog-Natural-Language-to-UNIX
A natural language parser created in Prolog to parse basic inputs into equivalent UNIX commands. 


The system parses the following commands and variants:

|Input                                                     |Output
|----------------------------------------------------------|--
|[a,very,short,command,listing,the, current, directory]    |ls   
|[the, current,directory,viewed,in,more,fine, detail]      |ls -la  
|[a,command,moving,to,a,higher,directory]                  |cd ..  
|[a,command,moves,to,a,parent,directory]                   |cd ..  
|[the,command,prints,the,current, directory]               |pwd  
|[the,command,types,the,file,08226txt]                     |cat 08226.txt


## Grammar Rules
Inputs must follow the below Context Free Grammer:

* S -> NP VP 
* S -> VP /
* NP -> Det NP2
* NP -> NP2
* NP -> NP PP
* NP2 -> Noun
* NP2 -> Adj NP2
* PP -> Prep NP
* VP -> Verb
* VP -> Verb Adverb NP
* VP -> Verb Adverb
* VP -> Verb PP
* VP -> Verb NP  




Created as part of the University of Hull Artificial Intelligence Module
