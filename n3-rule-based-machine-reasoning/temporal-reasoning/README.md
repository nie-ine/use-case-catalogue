# Temporal reasoning:
Generally, time indicators are uniformly converted to intervals to calculate with.
For this process the machine reasoner provides an extensive set of [Time and RIF Built-ins](https://raw.githubusercontent.com/josd/eye/master/eye-builtins.n3) based on W3C standards [RIF Datatypes and Built-Ins 1.0](https://www.w3.org/TR/2013/REC-rif-dtb-20130205/), using for instance literals typed with e.g. xs:dateTime, and xs:duration from the <http://www.w3.org/2001/XMLSchema#> namespace.  
Further functionality is provided by the [time-ontology](https://raw.githubusercontent.com/nie-ine/Ontologies/master/Nie-ontologies/Generic-ontologies/time-ontology.ttl) declaring the properties used in N3-rules.

A temporal reasoning example is given in the repository, considering an event without a start or end date, with a specific example of missing birth- or death date.
