# Temporal reasoning:
This type of reasoning is crucial for formal data to be reusable and interchangeable, because its first step is a unification of time expressions in different calendars and/or with different accuracy.

Time expressions with the accuracy of a day (date) from different calendars are converted to the respective Julian Day Numbers, and in this way comparable. 

A time expression with less accuracy than a day, i.e. a year or year-month, is converted to the period with the start and and date of the specific calendar, and with the start and end Julian Day Number.

See the [calendar unification example of N3-rule-based_machine-reasoning](https://github.com/nie-ine/N3-rule-based_machine-reasoning/tree/master/temporalReasoning). 

Another temporal reasoning use case concerns an [event without a start or end date](https://github.com/nie-ine/N3-rule-based_machine-reasoning/tree/master/temporalReasoning_missing-start-or-end), with a specific example of missing birth- or death date.
