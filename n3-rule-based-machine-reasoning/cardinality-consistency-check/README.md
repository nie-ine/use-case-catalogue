## Consistency check:
User-defined restrictions can be checked upon for consistency.  
For example a [cardinality restriction](https://github.com/nie-ine/N3-rule-based_machine-reasoning/tree/master/machineReasoning_cardinality) can be set on a certain property for its object, for a certain subject.  
If the machine reasoner detects an inconsistency, it will infer a *false* conclusion, and the RDF data graph will be rejected and has to be corrected manually.
