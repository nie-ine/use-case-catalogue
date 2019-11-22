### Various functionalities and calculations:
Also for this type of N3-rules an large set of [built-ins](https://raw.githubusercontent.com/josd/eye/master/eye-builtins.n3) is available, dealing with e.g. logical and mathematical operators, lists, and strings.
For example string manipulation, e.g. parsing using regular expressions, is possible with formal expressions, offering the advantage of staying in the formal N3/RDF environment until a fully reasoned upon data set or deductive closure is obtained, which can be stored in an RDF database and queried with SPARQL, or which can be transformed to JSON(-LD) for GUI application.  

The repository contains a reasoning example on sequence numbers derived from entity identifiers, using following properties declared in the respective ontology
<div align="center">

	math:hasSequenceLiteral  
	math:hasSequenceNumeral  
</div>
and a set of rules that can be made as general as possible, but very likely only within a certain project, considering the numerous possible combinations in creating alphanumeric identifiers.
