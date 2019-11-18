XML to RDF conversion
=====================

## Use case

This use case demonstrates how data in XML (with metadata and mixed content, including specifications like TEI) can be converted to RDF/XML data via XSLT. These RDF/XML data can then be imported into a triplestore or converted to formats like Turtle. The data can then be visualized with tools like Protégé or queried with SPARQL.

## Input data

The input is a valid XML. For this example we are going to use `orte.xml`.

## Stylesheet

The XSL stylesheet `register.xsl` matches the right elements in the input file and writes them into RDF data as declared in the stylesheet. The transformation can be done with any XSLT processor supporting the used version of XSLT. We are using `xsltproc` for this example:

    xsltproc register.xsl orte.xml > orte.rdf
    
The output of the conversion comes through the standard output but we are redirecting it into an RDF/XML file, `orte.rdf` in this example.

## Example query

The following query looks for all pe:EarthPlaces and gives the IRI and the rdfs:label of those resources:

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX pe: <http://www.knora.org/ontology/shared/physical-entity#>
SELECT ?subject ?object ?label
	WHERE { ?subject a pe:EarthPlace.
           ?subject rdfs:label ?label }
```

The output looks like this (shortened):

```
subject     label
<http://data.cfmeyer.ch/mbw/register/orte#Niedernau>    "Niedernau"@
<http://data.cfmeyer.ch/mbw/register/orte#Mantua>   "Mantua"@
<http://data.cfmeyer.ch/mbw/register/orte#Rueschlikon>  "Rüschlikon"@
<http://data.cfmeyer.ch/mbw/register/orte#Niederlande>  "Niederlande"@
<http://data.cfmeyer.ch/mbw/register/orte#Gruesch>  "Grüsch"@
<http://data.cfmeyer.ch/mbw/register/orte#Sumatra>  "Sumatra"@
<http://data.cfmeyer.ch/mbw/register/orte#Vicosoprano>  "Vicosoprano"@
<http://data.cfmeyer.ch/mbw/register/orte#Prag> "Prag"@
<http://data.cfmeyer.ch/mbw/register/orte#Parma>    "Parma"@
<http://data.cfmeyer.ch/mbw/register/orte#Korsika>  "Korsika"@
<http://data.cfmeyer.ch/mbw/register/orte#Zuoz> "Zuoz"@
<http://data.cfmeyer.ch/mbw/register/orte#Mammern>  "Mammern"@
<http://data.cfmeyer.ch/mbw/register/orte#Raetien>  "Rätien"@
```

In combination with the letter data and external sources, more complicated queries can be make, for example queries for letters from a specific region that contains the sending locations.

