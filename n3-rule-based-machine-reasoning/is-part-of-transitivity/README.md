This use case for machine reasoning illustrates the application of several basic logical elements of the model theroy of W3C's standard languages RDF, RDFS, and OWL.

###1. Sub-class of:
E.g. if *verse1* is an instance of the class *Verse* and *Verse* is a subclass of the class *Prosodic structure* then *verse1* is also a *Prosodic structure*, being a new subsumed statement, or inferred via the subclass relation.

In the example all available ontologies are asserted in the reasoning session, to show the complete subsumption tree, also implying the external ontologies CIDOC-CRM and FRBROO we base on.

###2. Sub-property of:
E.g. if *verse1 has number number1* and *has number* is a subproperty of *has identifier* then one can infer that *verse1 has identifier number1*.

###3. Transitivity of the abstract *is-part-of* relation between textual entities:
E.g. if the abstract *is part of* property is an instance of the class *Transitive property* and if a *verse1 is part of strophe1* and *strophe1 is part of poem1*, then one can infer that *verse1 is part of poem1*.

Such relation is very useful at searching in textual entities with structural parts such as pages, columns, lines, sections, paragraphs, sentences and words.
The [reasoning example on transitivity](https://github.com/nie-ine/N3-rule-based_machine-reasoning/tree/master/machineReasoning_transitive)