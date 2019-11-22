### Consistency checking:
User-defined restrictions can be checked upon, e.g. a cardinality restriction for the object value of a certain property of a certain subject class instance. Figure 1 shows part of the 'human' class declaration in Turtle with a cardinality restriction of maximum 1 on the property 'has biological sex', IOW a human can only have exactly 1 biological sex, i.e. female, male or intersexual (see [human-ontology](https://github.com/nie-ine/Ontologies/blob/master/Nie-ontologies/Generic-ontologies/human-ontology.ttl)).

	human:Human rdfs:subClassOf [
		a owl:Restriction;
		owl:onProperty human:hasBiologicalSex;
		owl:maxCardinality "1"^^xs:nonNegativeInteger].

<div align="center">
