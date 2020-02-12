#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"
echo "# Execution date" $(date) > $DIR/calendarConversion_input/result.ttl
./eye.sh --nope $DIR/calendarConversion_input/data.ttl /home/changeme/NIE_GitHub/Ontologies/Nie-ontologies/Generic-ontologies/calendar-ontology.ttl $DIR/rules/rdfs-subClassOf.n3 $DIR/calendarConversion_input/data-source-to-domain-conversion-rules.n3 $DIR/calendarConversion_input/calendar-conversion-rules.n3 --query $DIR/calendarConversion_input/query.n3 |cwm >> $DIR/calendarConversion_input/result.ttl


# 1. Description of the input for the reasoner:
# ---------------------------------------------
# OWL ontology
# RDF data
# N3-rules


# 2. Description of the output of the reasoner:
# ---------------------------------------------
# Cf. query file


# 3. Changeables for the command:
# -------------------------------
# query $DIR/calendarConversion_input/query.n3
# pass-all
# $DIR/rules/rdfs-subPropertyOf.n3 $DIR/rules/rdfs-domain.n3 $DIR/rules/rdfs-range.n3 $DIR/rules/rdfs-subClassOf.n3
# data_performance-test
# |cwm >> $DIR/calendarConversion_input/result.ttl