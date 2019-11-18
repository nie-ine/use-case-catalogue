<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cfm="http://www.cfmeyer.ch//schema"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:concept="http://ontologies.nie-ine.ch/shared/concept#"
                xmlns:human="http://ontologies.nie-ine.ch/shared/human#"
                xmlns:language="http://ontologies.nie-ine.ch/shared/language#"
                xmlns:physical-entity="http://ontologies.nie-ine.ch/shared/physical-entities#"
                xmlns:publishing="http://ontologies.nie-ine.ch/shared/publishing#"
                xmlns:text="http://ontologies.nie-ine.ch/shared/text#"
                xmlns:todo="http://ontologies.nie-ine.ch/shared/todo#"
                xmlns=""
                exclude-result-prefixes="cfm tei">
    <xsl:output indent="yes" method="xml"/>

    <!-- Variables for the namespaces of the data and their domain specific ontologies -->
    <xsl:variable name="meyerRegisterBase" select="'http://data.cfmeyer.ch/mbw/register/'"/>
    <xsl:variable name="nieShared" select="'http://ontologies.nie-ine.ch/shared/'"/>
    <xsl:variable name="nieMeyer" select="'http://ontologies.nie-ine.ch/project/meyer#'"/>

    <xsl:template match="cfm:register">
        <rdf:RDF>
            <xsl:for-each select="cfm:body/cfm:div[@xsi:type='Geografika']/cfm:entry">
                <xsl:call-template name="geografika-entry"/>
            </xsl:for-each>
            <xsl:for-each select="cfm:body/cfm:div[@xsi:type='Periodika']/cfm:entry">
                <xsl:call-template name="periodika-entry"/>
            </xsl:for-each>
            <xsl:for-each select="cfm:body/cfm:div[@xsi:type='Personen']/cfm:entry">
                <xsl:call-template name="person-entry"/>
            </xsl:for-each>
            <!-- Fully manual declaration of some resources as e.g. languages -->
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>lang#da</xsl:text>
                </xsl:attribute>
                <rdf:type rdf:resource="{$nieShared}language#Danish"/>
                <rdfs:label>Dänisch</rdfs:label>
            </rdf:Description>
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>lang#en</xsl:text>
                </xsl:attribute>
                <rdf:type rdf:resource="{$nieShared}language#English"/>
                <rdfs:label>Englisch</rdfs:label>
            </rdf:Description>
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>lang#fr</xsl:text>
                </xsl:attribute>
                <rdf:type rdf:resource="{$nieShared}language#English"/>
                <rdfs:label>Französisch</rdfs:label>
            </rdf:Description>
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>lang#it</xsl:text>
                </xsl:attribute>
                <rdf:type rdf:resource="{$nieShared}language#Italian"/>
                <rdfs:label>Italienisch</rdfs:label>
            </rdf:Description>
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>lang#nl</xsl:text>
                </xsl:attribute>
                <rdf:type rdf:resource="{$nieShared}language#Dutch"/>
                <rdfs:label>Niederländisch</rdfs:label>
            </rdf:Description>
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>lang#hu</xsl:text>
                </xsl:attribute>
                <rdf:type rdf:resource="{$nieShared}language#Hungarian"/>
                <rdfs:label>Ungarisch</rdfs:label>
            </rdf:Description>
        </rdf:RDF>
    </xsl:template>

    <!-- Matches main nodes of the place register -->
    <xsl:template name="geografika-entry">
        <rdf:Description>
            <xsl:variable name="edtext" select="cfm:ed"/>
            <xsl:variable name="shortname">
                <xsl:choose>
                    <xsl:when test="contains(cfm:ed/text(), ' (')">
                        <xsl:value-of select="substring-before(cfm:ed/text(), ' (')"/>
                    </xsl:when>
                    <xsl:when test="contains(cfm:ed/text(), ' → ')">
                        <xsl:value-of select="substring-before(cfm:ed/text(), ' → ')"/>
                    </xsl:when>
                    <xsl:when test="contains(cfm:ed/text(), '; ')">
                        <xsl:value-of select="substring-before(cfm:ed/text(), '; ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cfm:ed"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$meyerRegisterBase"/>
                <xsl:text>orte#</xsl:text>
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <rdf:type rdf:resource="{$nieShared}physical-entity#EarthPlace"/>
            <rdfs:label>
                <xsl:value-of select="$shortname"/>
            </rdfs:label>
            <physical-entity:hasSizeDescription rdf:datatype="http://www.w3.org/1999/02/22-rdf-syntax-ns#XMLLiteral">
                <xsl:apply-templates select="cfm:ed"/>
            </physical-entity:hasSizeDescription>
            <xsl:if test="./cfm:ed/cfm:siehe">
                <xsl:call-template name="siehe"/>
            </xsl:if>
        </rdf:Description>
    </xsl:template>

    <!-- Matches main nodes of the newspaper and magazine register -->
    <xsl:template name="periodika-entry">
        <rdf:Description>
            <xsl:variable name="edtext" select="cfm:ed"/>
            <xsl:variable name="shortname">
                <xsl:choose>
                    <xsl:when test="contains(cfm:ed/text(), ' → ')">
                        <xsl:value-of select="substring-before(cfm:ed/text(), ' → ')"/>
                    </xsl:when>
                    <xsl:when test="contains(cfm:ed/text(), '. ')">
                        <xsl:value-of select="substring-before(cfm:ed/text(), '. ')"/>
                    </xsl:when>
                    <xsl:when test="contains(cfm:ed/text(), ': ')">
                        <xsl:value-of select="substring-before(cfm:ed/text(), ': ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cfm:ed"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$meyerRegisterBase"/>
                <xsl:text>peri#</xsl:text>
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <rdf:type rdf:resource="{$nieShared}publishing#Serial"/>
            <rdfs:label>
                <xsl:value-of select="$shortname"/>
            </rdfs:label>
            <publishing:hasDescription rdf:datatype="http://www.w3.org/1999/02/22-rdf-syntax-ns#XMLLiteral">
                <xsl:apply-templates select="cfm:ed"/>
            </publishing:hasDescription>
            <xsl:if test="./cfm:ed/cfm:siehe">
                <xsl:call-template name="siehe"/>
            </xsl:if>
        </rdf:Description>
    </xsl:template>

    <!-- Matches main nodes of the person register (incl. literary works) -->
    <xsl:template name="person-entry">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$meyerRegisterBase"/>
                <xsl:text>pers#</xsl:text>
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <rdf:type rdf:resource="{$nieShared}human#Person"/>
            <rdfs:label>
                <xsl:value-of select="cfm:ed/cfm:name"/>
            </rdfs:label>
            <human:hasName>
                <xsl:value-of select="cfm:ed/cfm:name"/>
            </human:hasName>
            <xsl:if test="cfm:ed/cfm:dat">
                <human:hasBiography>
                    <xsl:value-of select="cfm:ed/cfm:dat"/>
                </human:hasBiography>
            </xsl:if>
            <human:hasDescription rdf:datatype="http://www.w3.org/1999/02/22-rdf-syntax-ns#XMLLiteral">
                <xsl:apply-templates select="cfm:ed/cfm:comment"/>
            </human:hasDescription>
            <xsl:if test="cfm:ed/cfm:gndIdentifier">
                <human:hasGNDIdentifier>
                    <xsl:value-of select="cfm:ed/cfm:gndIdentifier"/>
                </human:hasGNDIdentifier>
            </xsl:if>
            <xsl:if test="./cfm:ed/cfm:comment/cfm:siehe">
                <xsl:call-template name="siehe"/>
            </xsl:if>
        </rdf:Description>
        <xsl:apply-templates select=".//cfm:entry[@type='werk']"/>
        <xsl:apply-templates select=".//cfm:entry_group"/>
    </xsl:template>

    <xsl:template match="cfm:entry[@type='werk']">
        <rdf:Description>
            <xsl:variable name="shortname">
                <xsl:choose>
                    <xsl:when test="contains(cfm:ed/text(), '»')">
                        <xsl:value-of select="substring-before(substring-after(cfm:ed/text(), '«'), '»')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cfm:ed"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$meyerRegisterBase"/>
                <xsl:text>pers#</xsl:text>
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <rdf:type rdf:resource="{$nieShared}concept#Work"/>
            <rdfs:label>
                <xsl:value-of select="$shortname"/>
            </rdfs:label>
            <text:hasDescription rdf:datatype="http://www.w3.org/1999/02/22-rdf-syntax-ns#XMLLiteral">
                <xsl:apply-templates select="cfm:ed"/>
            </text:hasDescription>
            <human:hasCreator>
                <xsl:value-of select="$meyerRegisterBase"/>
                <xsl:text>pers#</xsl:text>
                <xsl:value-of select="ancestor::cfm:entry/@id"/>
            </human:hasCreator>
            <xsl:if test="./cfm:ed/cfm:siehe">
                <xsl:call-template name="siehe"/>
            </xsl:if>
            <xsl:if test="parent::cfm:entry_group">
                <todo:isInCollection>
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>pers#</xsl:text>
                    <xsl:value-of select="translate(parent::cfm:entry_group/@heading, ' ', '_')"/>
                </todo:isInCollection>
            </xsl:if>
            <xsl:for-each select="cfm:transl">
                <language:translatedIn>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:text>pers#</xsl:text>
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </language:translatedIn>
            </xsl:for-each>
        </rdf:Description>
        <xsl:apply-templates select="cfm:transl"/>
    </xsl:template>

    <xsl:template match="cfm:entry_group">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$meyerRegisterBase"/>
                <xsl:text>pers#</xsl:text>
                <xsl:value-of select="translate(@heading, ' ', '_')"/>
            </xsl:attribute>
            <rdf:type rdf:resource="{$nieShared}todo#Collection"/>
            <rdfs:label>
                <xsl:value-of select="@heading"/>
            </rdfs:label>
            <xsl:if test="parent::cfm:entry_group">
                <todo:isPartOfCollection>
                    <xsl:value-of select="$meyerRegisterBase"/>
                    <xsl:text>pers#</xsl:text>
                    <xsl:value-of select="translate(parent::cfm:entry_group/@heading, ' ', '_')"/>
                </todo:isPartOfCollection>
            </xsl:if>
        </rdf:Description>
    </xsl:template>

    <xsl:template match="cfm:transl">
        <rdf:Description>
            <xsl:variable name="shortname">
                <xsl:choose>
                    <xsl:when test="contains(cfm:ed/text(), '»')">
                        <xsl:value-of select="substring-before(substring-after(cfm:ed/text(), '«'), '»')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cfm:ed"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$meyerRegisterBase"/>
                <xsl:text>pers#</xsl:text>
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <rdf:type rdf:resource="{$nieShared}concept#Work"/>
            <rdf:type rdf:resource="{$nieShared}language#Translation"/>
            <rdfs:label>
                <xsl:value-of select="$shortname"/>
            </rdfs:label>
            <text:hasDescription rdf:datatype="http://www.w3.org/1999/02/22-rdf-syntax-ns#XMLLiteral">
                <xsl:apply-templates select="cfm:ed"/>
            </text:hasDescription>
            <language:expressedInNaturalLanguage>
                <xsl:choose>
                    <xsl:when test="cfm:lang/text() = '[dän.]'">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:text>lang#da</xsl:text>
                    </xsl:when>
                    <xsl:when test="cfm:lang/text() = '[engl.]'">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:text>lang#en</xsl:text>
                    </xsl:when>
                    <xsl:when test="cfm:lang/text() = '[franz.]'">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:text>lang#fr</xsl:text>
                    </xsl:when>
                    <xsl:when test="cfm:lang/text() = '[ital.]'">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:text>lang#it</xsl:text>
                    </xsl:when>
                    <xsl:when test="cfm:lang/text() = '[niederl.]'">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:text>lang#nl</xsl:text>
                    </xsl:when>
                    <xsl:when test="cfm:lang/text() = '[ungar.]'">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:text>lang#hu</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </language:expressedInNaturalLanguage>
            <xsl:if test="./cfm:ed/cfm:siehe">
                <xsl:call-template name="siehe"/>
            </xsl:if>
        </rdf:Description>
    </xsl:template>

    <xsl:template match="cfm:ed">
        <tei:text>
            <xsl:apply-templates/>
        </tei:text>
    </xsl:template>

    <xsl:template match="cfm:comment">
        <tei:text>
            <xsl:apply-templates/>
        </tei:text>
    </xsl:template>

    <xsl:template name="siehe">
        <xsl:choose>
            <xsl:when test="cfm:ed/cfm:siehe/@ref and contains(cfm:ed/text(), ' → ')">
                <owl:sameAs>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:choose>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Geografika']">
                                <xsl:text>orte#</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Periodika']">
                                <xsl:text>peri#</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Personen']">
                                <xsl:text>pers#</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:value-of select="cfm:ed/cfm:siehe/@ref"/>
                    </xsl:attribute>
                </owl:sameAs>
            </xsl:when>
            <xsl:when test="cfm:ed/cfm:siehe/@dest">
                <rdfs:seeAlso>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:value-of select="cfm:ed/cfm:siehe/@dest"/>
                    </xsl:attribute>
                </rdfs:seeAlso>
            </xsl:when>
            <xsl:when test="cfm:ed/cfm:comment/cfm:siehe/@ref">
                <rdfs:seeAlso>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:choose>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Geografika']">
                                <xsl:text>orte#</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Periodika']">
                                <xsl:text>peri#</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Personen']">
                                <xsl:text>pers#</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:value-of select="cfm:ed/cfm:comment/cfm:siehe/@ref"/>
                    </xsl:attribute>
                </rdfs:seeAlso>
            </xsl:when>
            <xsl:when test="cfm:ed/cfm:comment/cfm:siehe/@dest">
                <rdfs:seeAlso>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:value-of select="cfm:ed/cfm:comment/cfm:siehe/@dest"/>
                    </xsl:attribute>
                </rdfs:seeAlso>
            </xsl:when>
            <xsl:otherwise>
                <rdfs:seeAlso>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$meyerRegisterBase"/>
                        <xsl:choose>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Geografika']">
                                <xsl:text>orte#</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Periodika']">
                                <xsl:text>peri#</xsl:text>
                            </xsl:when>
                            <xsl:when test="ancestor::cfm:div[@xsi:type='Personen']">
                                <xsl:text>pers#</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:value-of select="cfm:ed/cfm:siehe/@ref"/>
                    </xsl:attribute>
                </rdfs:seeAlso>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
