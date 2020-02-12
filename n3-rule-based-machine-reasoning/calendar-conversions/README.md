## Calendar conversions:

See also the repository on [N3-rule based machine reasoning](https://github.com/nie-ine/N3-rule-based_machine-reasoning).

In Humanities the need for having time expressions being comparable through time and place is quite esstial.
This implies comparibility of these expressions from different calendars.

Although a calendar starts at a certain moment, but can also end, it does not mean that it is used by all people.

Through history a whole series of calendars are introduces at different times in different places.

An established calendar can be replaced by another one. E.g. the Julian calendar, de facto started in the year 4 AD and used until October 4 1582, was then replaced by the Gregorian calendar, skipping a few days and recalculating leap years, and used by the majority of people.
But some groups decided to further use the Julian calendar.

Before the existande of a certain calendar other calendars already existed, but one can use e.g. the Julian calendar to go back in time before the year 4 AD, called the 'proleptic' Julian calendar.

Besides those 3 mentioned calendars, sprouting from a certain part of the world, other ones exist, e.g. the Islamic calendar, started on 16 July 622, or the Hebrew, the Persian, and other calendars.

To calculate with time expressions coming from different calendars can get quite cumbersome quickly for a human being.
For a computer, this is standard, given all the funtionality is implemented.

Using SWT to unify semantics cross databases and models also implies unification of time expressions in the form of the Julian Day Number, also being an integer easier to calculate with. Other time expressions in different calendars can be converted to Julian Day Number, in a way that a machine can calculate with them simultaneausly by addition or subtraction.

The onset of implementation covers Gregorian, Julian and proleptic Julian calendars.
Other will follow.

The semantic entities for time and calendrical expressions are in the [time-](https://github.com/nie-ine/Ontologies/blob/master/Nie-ontologies/Generic-ontologies/time-ontology.ttl) and [calendar-ontology](https://github.com/nie-ine/Ontologies/blob/master/Nie-ontologies/Generic-ontologies/calendar-ontology.ttl) respectively.

The ontologies not only provide elements to RDF-ize data, but also to declare rules for temporal reasoning and calendar conversion.

In this use case there is a mock-up data-graph from projectx as a 1-1 translation from e.g. XML to RDF.
It covers the possible cases for the 3 implemented calendars. 
In the file *data-source-to-domain-conversion-rules.n3* there are the N3-rules declared for conversion of the 'data source semantics' of a project to 'domain semantics' expressed using our ontologies, enabling data-interoperability and re-usability.
In those rules also the conversions of literal time expressions to typed literals are invoked.
The file *calendar-conversion-rules.n3* contains the N3-rules for the actual conversion to date typed literals and Julian Day Numbers. Partial time expressions, i.e. 'year' and 'year-month', are first converted to a period for which the start and end calendar-specific dates and the start and end Julian Day Numbers are calculated for interval calculus. Optionally other information can be inferred, e.g. being a leap year or not.
The 'query' file is a filter on the deductive closure of the machine reasoning session.
The 'result' file is an example of conversion of the mock-up data.

Note: the XML Schema datatypes are only applicable to the Gregorian calendar. For the other calendars the data types have to be created as instances of rdfs:Datatype.

In the example I chose for exclusion of inconsistent data and giving an error message, instead of stopping the reasoning process and returning a 'false' conclusion in the terminal. In a production environment the messages can be given in different languages, here French as an example.

### References:
https://en.wikipedia.org/wiki/Gregorian_calendar  
https://en.wikipedia.org/wiki/Julian_calendar  
https://en.wikipedia.org/wiki/Proleptic_Julian_calendar  
https://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar  
https://en.wikipedia.org/wiki/Talk%3AProleptic_Gregorian_calendar  
https://www.fourmilab.ch/documents/calendar/  
https://keisan.casio.com/exec/system/1227779487  
https://keisan.casio.com/exec/system/1227780009
https://bowie.gsfc.nasa.gov/time/julian.html  