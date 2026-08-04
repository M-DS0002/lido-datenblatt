<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lido="http://www.lido-schema.org">
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:template match="/">
		<html lang="de">
			<head>
				<title>LIDO-Datenblatt</title>
				<style type="text/css">
body {
    font-family: Arial, sans-serif;
}

.display, .structured {
    margin-left: 20px;
}

img {
    max-width: 250px;
}

fieldset {
    margin-bottom: 20px;
}

.uri {
    font-size: 90%;
    color: #666;
}
</style>
			</head>
			<body>
				<h1>LIDO-Datenblatt</h1>
				<p>
   Dieses Datenblatt stellt die Inhalte eines LIDO-1.0-Datensatzes anhand der Minimaldatensatz-Empfehlung für Museen und Sammlungen übersichtlich und menschenlesbar dar. Die in Klammern angegebenen XPath-Ausdrücke erleichtern die Zuordnung zu den entsprechenden LIDO-Elementen. LIDO-Pflichtelemente sind mit einem * markiert. 
				</p>
				<h2>Datenfelder Erfassung</h2>
				<p>
					<strong>*Objekttitel</strong>
					<small> (lido:titleSet/lido:appellationValue): </small>
					<xsl:for-each select="//lido:titleSet[lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]]">
						<xsl:variable name="title" select="lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
						<xsl:value-of select="$title"/>
						<xsl:if test="position() != last()">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</p>
				<p>
					<strong>*Objekttyp oder -bezeichnung</strong>
					<small> (lido:objectWorkType): </small>
					<xsl:for-each select="//lido:objectWorkType[lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)] or lido:conceptID]">
						<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
						<xsl:if test="$term">
							<xsl:value-of select="$term"/>
						</xsl:if>
						<xsl:if test="lido:conceptID">
							<xsl:choose>
								<xsl:when test="count(lido:conceptID)=1">
									<xsl:text>, URI: </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>, URIs: </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:for-each select="lido:conceptID">
								<span class="uri">
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="."/>
										</xsl:attribute>
										<xsl:attribute name="target">_blank</xsl:attribute>
										<xsl:value-of select="."/>
									</a>
								</span>
								<xsl:if test="position()!=last()">
									<xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="position()!=last()">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</p>
				<xsl:if test="//lido:classification[lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)] or lido:conceptID]">
					<p>
						<strong>Klassifikation</strong>
						<small> (lido:classification): </small>
						<xsl:for-each select="//lido:classification[lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)] or lido:conceptID]">
							<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
							<xsl:if test="$term">
								<xsl:value-of select="$term"/>
							</xsl:if>
							<xsl:if test="@lido:type">
								<xsl:text> (</xsl:text>
								<xsl:choose>
									<xsl:when test="@lido:type='http://terminology.lido-schema.org/lido00853'">
										<xsl:text>Objektgattung [http://terminology.lido-schema.org/lido00853]</xsl:text>
									</xsl:when>
									<xsl:when test="@lido:type='http://terminology.lido-schema.org/lido00932'">
										<xsl:text>Themenkategorie [http://terminology.lido-schema.org/lido00932]</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@lido:type"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>)</xsl:text>
							</xsl:if>
							<xsl:if test="lido:conceptID">
								<xsl:choose>
									<xsl:when test="count(lido:conceptID) = 1">
										<xsl:text>, URI: </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>, URIs: </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="lido:conceptID">
									<span class="uri">
										<a>
											<xsl:attribute name="href">
												<xsl:value-of select="."/>
											</xsl:attribute>
											<xsl:attribute name="target">_blank</xsl:attribute>
											<xsl:value-of select="."/>
										</a>
									</span>
									<xsl:if test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
				<xsl:if test="//lido:workID">
					<p>
						<strong>Inventarnummer</strong>
						<small> (lido:workID): </small>
						<xsl:for-each select="//lido:workID">
							<xsl:value-of select="."/>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
				<xsl:if test="//lido:objectDescriptionSet/lido:descriptiveNoteValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]">
					<p>
						<strong>Objektbeschreibung</strong>
						<small> (lido:objectDescriptionSet): </small>
						<xsl:for-each select="//lido:objectDescriptionSet/lido:descriptiveNoteValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]">
							<xsl:value-of select="."/>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
				<xsl:if test="//lido:displayMaterialsTech[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)] or //lido:termMaterialsTech">
					<p>
						<strong>Material und Technik</strong>
						<small> (lido:eventMaterialsTech | lido:objectMaterialsTech): </small>
						<xsl:variable name="display" select="//lido:displayMaterialsTech[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]"/>
						<xsl:variable name="structured" select="//lido:termMaterialsTech[lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)] or lido:conceptID]"/>
						<!-- Display-Angaben -->
						<xsl:if test="$display">
							<xsl:if test="$structured">
								<div class="display">
									<strong>Anzeigewert</strong>
									<br/>
								</div>
							</xsl:if>
							<xsl:for-each select="$display">
								<xsl:value-of select="."/>
								<xsl:if test="position() != last()">
									<xsl:text>; </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="$display and $structured">
							<div class="structured">
								<strong>Strukturierte Angaben</strong>
								<br/>
							</div>
						</xsl:if>
						<!-- Strukturierte Angaben -->
						<xsl:for-each select="$structured">
							<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
							<xsl:if test="$term">
								<xsl:value-of select="$term"/>
							</xsl:if>
							<xsl:if test="@lido:type">
								<xsl:text> (</xsl:text>
								<xsl:choose>
									<xsl:when test="@lido:type='http://terminology.lido-schema.org/lido00132'">
										<xsl:text>Material [http://terminology.lido-schema.org/lido00132]</xsl:text>
									</xsl:when>
									<xsl:when test="@lido:type='http://terminology.lido-schema.org/lido00131'">
										<xsl:text>Technik [http://terminology.lido-schema.org/lido00131]</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@lido:type"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>)</xsl:text>
							</xsl:if>
							<xsl:if test="lido:conceptID">
								<xsl:choose>
									<xsl:when test="count(lido:conceptID) = 1">
										<xsl:text>, URI: </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>, URIs: </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="lido:conceptID">
									<span class="uri">
										<a>
											<xsl:attribute name="href">
												<xsl:value-of select="."/>
											</xsl:attribute>
											<xsl:attribute name="target">_blank</xsl:attribute>
											<xsl:value-of select="."/>
										</a>
									</span>
									<xsl:if test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
				<xsl:if test="//lido:displayObjectMeasurements[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]">
					<p>
						<strong>Maße</strong>
						<small> (lido:objectMeasurementsSet | lido:eventObjectMeasurements): </small>
						<xsl:variable name="display" select="//lido:displayObjectMeasurements[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]"/>
						<xsl:variable name="structured" select="//lido:objectMeasurements/lido:measurementsSet"/>
						<!-- Display-Angaben -->
						<xsl:if test="$display">
							<xsl:if test="$structured">
								<div class="display">
									<strong>Anzeigewert</strong>
									<br/>
								</div>
							</xsl:if>
							<xsl:for-each select="$display">
								<xsl:value-of select="."/>
								<xsl:if test="position() != last()">
									<xsl:text>; </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="$display and $structured">
							<div class="structured">
								<strong>Strukturierte Angaben</strong>
								<br/>
							</div>
						</xsl:if>
						<!-- Strukturierte Angaben -->
						<xsl:for-each select="$structured">
							<xsl:if test="lido:measurementType">
								<xsl:value-of select="lido:measurementType[
                @xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)
            ][1]"/>
								<xsl:text>: </xsl:text>
							</xsl:if>
							<xsl:value-of select="lido:measurementValue"/>
							<xsl:if test="lido:measurementUnit">
								<xsl:text> </xsl:text>
								<xsl:value-of select="lido:measurementUnit"/>
							</xsl:if>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
				<h3>Ereignisse in der Objektgeschichte (lido:eventWrap)</h3>
				<xsl:for-each select="//lido:event">
					<xsl:sort select="../@lido:sortorder" data-type="number"/>
					<fieldset>
						<legend>
							<strong>Ereignis</strong>
							<small> (lido:eventSet)</small>
						</legend>
						<!-- Ereignistyp -->
						<p>
							<strong>Ereignistyp</strong>
							<small> (lido:eventType): </small>
							<xsl:variable name="display" select="lido:displayEvent[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]"/>
							<xsl:variable name="structured" select="lido:eventType[lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]or lido:conceptID]"/>
							<!-- Display -->
							<xsl:if test="$display">
								<xsl:if test="$structured">
									<div class="display">
										<strong>Anzeigewert</strong>
										<br/>
									</div>
								</xsl:if>
								<xsl:for-each select="$display">
									<xsl:value-of select="."/>
									<xsl:if test="position() != last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="$display and $structured">
								<div class="structured">
									<strong>Strukturierte Angaben</strong>
									<br/>
								</div>
							</xsl:if>
							<!-- Strukturierte Angaben -->
							<xsl:for-each select="$structured">
								<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
								<xsl:if test="$term">
									<xsl:value-of select="$term"/>
								</xsl:if>
								<xsl:if test="lido:conceptID">
									<xsl:choose>
										<xsl:when test="count(lido:conceptID) = 1">
											<xsl:text>, URI: </xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>, URIs: </xsl:text>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:for-each select="lido:conceptID">
										<span class="uri">
											<a>
												<xsl:attribute name="href">
													<xsl:value-of select="."/>
												</xsl:attribute>
												<xsl:attribute name="target">_blank</xsl:attribute>
												<xsl:value-of select="."/>
											</a>
										</span>
										<xsl:if test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:if>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="position() != last()">
									<xsl:text>; </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</p>
						<!-- Person/Körperschaft -->
						<xsl:if test="lido:eventActor">
							<p>
								<strong>Person/Körperschaft</strong>
								<small> (lido:eventActor): </small>
								<xsl:for-each select="lido:eventActor">
									<xsl:variable name="display" select="lido:displayActor[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]"/>
									<xsl:variable name="actor" select="lido:actorInRole/lido:actor"/>
									<xsl:variable name="structured" select="$actor[lido:nameActorSet/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]or lido:actorID]"/>
									<xsl:variable name="role" select="lido:actorInRole/lido:roleActor/lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
									<!-- Display -->
									<xsl:if test="$display">
										<xsl:if test="$structured">
											<div class="display">
												<strong>Anzeigewert</strong>
												<br/>
											</div>
										</xsl:if>
										<xsl:for-each select="$display">
											<xsl:value-of select="."/>
											<xsl:if test="position() != last()">
												<xsl:text>; </xsl:text>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="$display and $structured">
										<div class="structured">
											<strong>Strukturierte Angaben</strong>
											<br/>
										</div>
									</xsl:if>
									<!-- Strukturierter Akteur -->
									<xsl:if test="$structured">
										<xsl:variable name="name" select="$actor/lido:nameActorSet/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
										<xsl:if test="$name">
											<xsl:value-of select="$name"/>
										</xsl:if>
										<xsl:if test="$role">
											<xsl:text> (</xsl:text>
											<xsl:value-of select="$role"/>
											<xsl:text>)</xsl:text>
										</xsl:if>
										<xsl:if test="$actor/lido:actorID">
											<xsl:choose>
												<xsl:when test="count($actor/lido:actorID) = 1">
													<xsl:text>, URI: </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>, URIs: </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:for-each select="$actor/lido:actorID">
												<span class="uri">
													<a>
														<xsl:attribute name="href">
															<xsl:value-of select="."/>
														</xsl:attribute>
														<xsl:attribute name="target">_blank</xsl:attribute>
														<xsl:value-of select="."/>
													</a>
												</span>
												<xsl:if test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
									</xsl:if>
									<!-- Trennung mehrerer eventActor -->
									<xsl:if test="position() != last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</p>
						</xsl:if>
						<!-- Datierung -->
						<xsl:if test="lido:eventDate">
							<p>
								<strong>Datierung (lido:eventDate): </strong>
								<small> (lido:eventDate): </small>
								<xsl:for-each select="lido:eventDate">
									<xsl:variable name="display" select="lido:displayDate[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]"/>
									<xsl:variable name="earliest" select="lido:date/lido:earliestDate"/>
									<xsl:variable name="latest" select="lido:date/lido:latestDate"/>
									<xsl:variable name="structured" select="$earliest | $latest"/>
									<xsl:if test="$display">
										<xsl:if test="$structured">
											<div class="display">
												<strong>Anzeigewert</strong>
												<br/>
											</div>
										</xsl:if>
										<xsl:value-of select="$display[1]"/>
									</xsl:if>
									<xsl:if test="$display and $structured">
										<div class="structured">
											<strong>Strukturierte Angaben</strong>
											<br/>
										</div>
									</xsl:if>
									<xsl:if test="$structured">
										<xsl:if test="$earliest">
											<xsl:value-of select="$earliest"/>
										</xsl:if>
										<xsl:if test="$earliest and $latest">
											<xsl:text>–</xsl:text>
										</xsl:if>
										<xsl:if test="$latest">
											<xsl:value-of select="$latest"/>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</p>
						</xsl:if>
						<!-- Ort -->
						<xsl:if test="lido:eventPlace">
							<p>
								<strong>Ort</strong>
								<small> (lido:eventPlace): </small>
								<xsl:for-each select="lido:eventPlace">
									<xsl:variable name="display" select="lido:displayPlace[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]"/>
									<xsl:variable name="place" select="lido:place"/>
									<xsl:variable name="structured" select="$place[lido:namePlaceSet/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]or lido:placeID]"/>
									<xsl:if test="$display">
										<xsl:if test="$structured">
											<div class="display">
												<strong>Anzeigewert</strong>
												<br/>
											</div>
										</xsl:if>
										<xsl:for-each select="$display">
											<xsl:value-of select="."/>
											<xsl:if test="position() != last()">
												<xsl:text>; </xsl:text>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="$display and $structured">
										<div class="structured">
											<strong>Strukturierte Angaben</strong>
											<br/>
										</div>
									</xsl:if>
									<xsl:if test="$structured">
										<xsl:variable name="name" select="$place/lido:namePlaceSet/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
										<xsl:if test="$name">
											<xsl:value-of select="$name"/>
										</xsl:if>
										<xsl:if test="$place/lido:placeID">
											<xsl:choose>
												<xsl:when test="count($place/lido:placeID) = 1">
													<xsl:text>, URI: </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>, URIs: </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:for-each select="$place/lido:placeID">
												<span class="uri">
													<a>
														<xsl:attribute name="href">
															<xsl:value-of select="."/>
														</xsl:attribute>
														<xsl:attribute name="target">_blank</xsl:attribute>
														<xsl:value-of select="."/>
													</a>
												</span>
												<xsl:if test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
									</xsl:if>
									<xsl:if test="position() != last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</p>
						</xsl:if>
					</fieldset>
				</xsl:for-each>
				<xsl:if test="//lido:subject">
					<p>
						<strong>Inhaltsschlagwort</strong>
						<small> (//lido:subject): </small>
						<xsl:for-each select="//lido:subjectSet">
							<xsl:variable name="display" select="lido:displaySubject[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]"/>
							<xsl:variable name="structured" select="lido:subject/lido:subjectConcept | lido:subject/lido:subjectActor | lido:subject/lido:subjectPlace"/>
							<xsl:if test="$display">
								<xsl:if test="$structured">
									<div class="display">
										<strong>Anzeigewert</strong>
										<br/>
									</div>
								</xsl:if>
								<xsl:for-each select="$display">
									<xsl:value-of select="."/>
									<xsl:if test="position() != last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="$display and $structured">
								<div class="structured">
									<strong>Strukturierte Angaben</strong>
									<br/>
								</div>
							</xsl:if>
							<xsl:for-each select="$structured">
								<xsl:choose>
									<xsl:when test="self::lido:subjectConcept">
										<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
										<xsl:if test="$term">
											<xsl:value-of select="$term"/>
										</xsl:if>
										<xsl:if test="lido:conceptID">
											<xsl:choose>
												<xsl:when test="count(lido:conceptID) = 1">
													<xsl:text>, URI: </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>, URIs: </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:for-each select="lido:conceptID">
												<span class="uri">
													<a>
														<xsl:attribute name="href">
															<xsl:value-of select="."/>
														</xsl:attribute>
														<xsl:attribute name="target">_blank</xsl:attribute>
														<xsl:value-of select="."/>
													</a>
												</span>
												<xsl:if test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
									</xsl:when>
									<xsl:when test="self::lido:subjectActor">
										<xsl:variable name="name" select="lido:actor/lido:nameActorSet/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
										<xsl:if test="$name">
											<xsl:value-of select="$name"/>
										</xsl:if>
										<xsl:text> (Dargestellte Person/Körperschaft)</xsl:text>
										<xsl:if test="lido:actor/lido:actorID">
											<xsl:choose>
												<xsl:when test="count(lido:actor/lido:actorID) = 1">
													<xsl:text>, URI: </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>, URIs: </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:for-each select="lido:actor/lido:actorID">
												<span class="uri">
													<a>
														<xsl:attribute name="href">
															<xsl:value-of select="."/>
														</xsl:attribute>
														<xsl:attribute name="target">_blank</xsl:attribute>
														<xsl:value-of select="."/>
													</a>
												</span>
												<xsl:if test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
									</xsl:when>
									<xsl:when test="self::lido:subjectPlace">
										<xsl:variable name="name" select="lido:place/lido:namePlaceSet/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
										<xsl:if test="$name">
											<xsl:value-of select="$name"/>
										</xsl:if>
										<xsl:text> (Dargestellter Ort)</xsl:text>
										<xsl:if test="lido:place/lido:placeID">
											<xsl:choose>
												<xsl:when test="count(lido:place/lido:placeID) = 1">
													<xsl:text>, URI: </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>, URIs: </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:for-each select="lido:place/lido:placeID">
												<span class="uri">
													<a>
														<xsl:attribute name="href">
															<xsl:value-of select="."/>
														</xsl:attribute>
														<xsl:attribute name="target">_blank</xsl:attribute>
														<xsl:value-of select="."/>
													</a>
												</span>
												<xsl:if test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
									</xsl:when>
								</xsl:choose>
								<xsl:if test="position() != last()">
									<xsl:text>; </xsl:text>
								</xsl:if>
							</xsl:for-each>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
				<h3>Mediendateien (lido:resourceWrap)</h3>
				<xsl:if test="//lido:resourceSet">
					<xsl:for-each select="//lido:resourceSet">
						<xsl:sort select="@lido:sortorder" data-type="number"/>
						<fieldset>
							<legend>
								<strong>Mediendatei</strong>
								<small> (lido:resourceSet)</small>
							</legend>
							<p>
								<strong>Link zur Mediendatei</strong>
								<small> (lido:linkResource): </small>
								<xsl:for-each select=".//lido:linkResource">
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="."/>
										</xsl:attribute>
										<xsl:attribute name="target">_blank</xsl:attribute>
										<xsl:value-of select="."/>
									</a>
									<xsl:if test="../@lido:type">
										<xsl:text> (</xsl:text>
										<xsl:choose>
											<xsl:when test="../@lido:type='http://terminology.lido-schema.org/lido00464'">
												<xsl:text>geliefertes Bild</xsl:text>
											</xsl:when>
											<xsl:when test="../@lido:type='http://terminology.lido-schema.org/lido00451'">
												<xsl:text>Vorschaubild</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="../@lido:type"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>)</xsl:text>
									</xsl:if>
									<xsl:if test="position() != last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</p>
							<p>
								<img style="max-width:100px; max-height:100px;">
									<xsl:attribute name="src">
										<xsl:value-of select="lido:resourceRepresentation/lido:linkResource"/>
									</xsl:attribute>
								</img>
							</p>
							<p>
								<strong>Nutzungsrechte Mediendatei</strong>
								<small> (lido:rightsResource/lido:rightsType): </small>
								<xsl:for-each select="lido:rightsResource/lido:rightsType[lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]or lido:conceptID]">
									<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
									<xsl:if test="$term">
										<xsl:value-of select="$term"/>
									</xsl:if>
									<xsl:if test="lido:conceptID">
										<xsl:text>, Lizenz-URI: </xsl:text>
										<xsl:for-each select="lido:conceptID">
											<span class="uri">
												<a>
													<xsl:attribute name="href">
														<xsl:value-of select="."/>
													</xsl:attribute>
													<xsl:attribute name="target">_blank</xsl:attribute>
													<xsl:value-of select="."/>
												</a>
											</span>
											<xsl:if test="position()!=last()">
												<xsl:text>, </xsl:text>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="position()!=last()">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</p>
							<xsl:if test="lido:rightsResource/lido:rightsHolder or lido:resourceSource">
								<p>
									<xsl:if test="lido:rightsResource/lido:rightsHolder">
										<strong>Rechtewahrnehmung</strong>
										<small> (lido:rightsResource/lido:rightsHolder): </small>
										<xsl:for-each select="lido:rightsResource/lido:rightsHolder">
											<!-- Dein bisheriger rightsHolder-Code unverändert -->
										</xsl:for-each>
									</xsl:if>
									<xsl:if test="lido:rightsResource/lido:rightsHolder and lido:resourceSource">
										<br/>
									</xsl:if>
									<xsl:if test="lido:resourceSource">
										<text>Fotograf*in/Digitalisierung</text>
										<small> (lido:resourceSource): </small>
										<xsl:for-each select="lido:resourceSource">
											<xsl:variable name="name" select="lido:legalBodyName/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
											<xsl:value-of select="$name"/>
											<xsl:if test="lido:legalBodyID">
												<xsl:choose>
													<xsl:when test="count(lido:legalBodyID)=1">
														<xsl:text>, URI: </xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>, URIs: </xsl:text>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:for-each select="lido:legalBodyID">
													<span class="uri">
														<a href="{.}" target="_blank">
															<xsl:value-of select="."/>
														</a>
													</span>
													<xsl:if test="position()!=last()">
														<xsl:text>, </xsl:text>
													</xsl:if>
												</xsl:for-each>
											</xsl:if>
											<xsl:if test="position()!=last()">
												<xsl:text>; </xsl:text>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</p>
							</xsl:if>
							<xsl:if test="lido:resourceDescription[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]">
								<p>
									<strong>Bildbeschreibung oder Alternativtext</strong>
									<small> (lido:resourceDescription): </small>
									<xsl:for-each select="lido:resourceDescription[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]">
										<xsl:value-of select="."/>
										<xsl:if test="position() != last()">
											<xsl:text>; </xsl:text>
										</xsl:if>
									</xsl:for-each>
								</p>
							</xsl:if>
							<xsl:if test="lido:resourceType">
								<p>
									<strong>Medientyp</strong>
									<small> (lido:resourceType): </small>
									<xsl:for-each select="lido:resourceType">
										<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
										<xsl:if test="$term">
											<xsl:value-of select="$term"/>
										</xsl:if>
										<xsl:if test="lido:conceptID">
											<xsl:choose>
												<xsl:when test="count(lido:conceptID) = 1">
													<xsl:text>, URI: </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>, URIs: </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:for-each select="lido:conceptID">
												<span class="uri">
													<a>
														<xsl:attribute name="href">
															<xsl:value-of select="."/>
														</xsl:attribute>
														<xsl:attribute name="target">_blank</xsl:attribute>
														<xsl:value-of select="."/>
													</a>
												</span>
												<xsl:if test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
										<xsl:if test="position() != last()">
											<xsl:text>; </xsl:text>
										</xsl:if>
									</xsl:for-each>
								</p>
							</xsl:if>
						</fieldset>
					</xsl:for-each>
				</xsl:if>
				<h2>Datenfelder Export</h2>
				<p>
					<strong>*ID Datensatz einrichtungsübergreifend</strong>
					<small> (lido:lidoRecID): </small>
					<xsl:value-of select="//lido:lidoRecID"/>
				</p>
				<p>
					<strong>*ID Datensatz lokal</strong>
					<small> (lido:recordID): </small>
					<xsl:value-of select="//lido:recordWrap/lido:recordID"/>
				</p>
				<p>
					<strong>*Sprache des Datensatzes</strong>
					<small> (lido:descriptiveMetadata@xml:lang): </small>
					<xsl:value-of select="//lido:descriptiveMetadata/@xml:lang"/>
				</p>
				<p>
					<strong>*Datensatzart (lido:recordType):</strong>
					<small> (lido:recordType): </small>
					<xsl:variable name="term" select="//lido:recordType/lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
					<xsl:if test="$term">
						<xsl:value-of select="$term"/>
					</xsl:if>
					<xsl:if test="//lido:recordType/lido:conceptID">
						<xsl:choose>
							<xsl:when test="count(//lido:recordType/lido:conceptID)=1">
								<xsl:text>, URI: </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>, URIs: </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:for-each select="//lido:recordType/lido:conceptID">
							<span class="uri">
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="."/>
									</xsl:attribute>
									<xsl:attribute name="target">_blank</xsl:attribute>
									<xsl:value-of select="."/>
								</a>
							</span>
							<xsl:if test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
				</p>
				<p>
					<strong>Verwahrende Einrichtung (lido:repositoryName): </strong>
					<small> (lido:repositoryName): </small>
					<xsl:variable name="name" select="//lido:repositoryName/lido:legalBodyName/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
					<xsl:value-of select="$name"/>
					<xsl:if test="//lido:repositoryName/lido:legalBodyID">
						<xsl:choose>
							<xsl:when test="count(//lido:repositoryName/lido:legalBodyID) = 1">
								<xsl:text>, URI: </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>, URIs: </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:for-each select="//lido:repositoryName/lido:legalBodyID">
							<span class="uri">
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="."/>
									</xsl:attribute>
									<xsl:attribute name="target">_blank</xsl:attribute>
									<xsl:value-of select="."/>
								</a>
							</span>
							<xsl:if test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
				</p>
				<p>
					<strong>*Datensatzerstellende Einrichtung (lido:recordSource): </strong>
					<small> (lido:recordSource): </small>
					<xsl:for-each select="//lido:recordSource">
						<xsl:variable name="name" select="lido:legalBodyName/lido:appellationValue[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
						<xsl:value-of select="$name"/>
						<xsl:if test="@lido:type">
							<xsl:text> (</xsl:text>
							<xsl:value-of select="@lido:type"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:if test="lido:legalBodyID">
							<xsl:choose>
								<xsl:when test="count(lido:legalBodyID) = 1">
									<xsl:text>, URI: </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>, URIs: </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:for-each select="lido:legalBodyID">
								<span class="uri">
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="."/>
										</xsl:attribute>
										<xsl:attribute name="target">_blank</xsl:attribute>
										<xsl:value-of select="."/>
									</a>
								</span>
								<xsl:if test="position() != last()">
									<xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="position() != last()">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</p>
				<p>
					<strong>Nutzungsrechte Datensatz</strong>
					<small> (lido:recordRights/lido:rightsType): </small>
					<xsl:for-each select="//lido:recordRights/lido:rightsType[lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)]or lido:conceptID]">
						<xsl:variable name="term" select="lido:term[@xml:lang='de' or @xml:lang='deu' or @xml:lang='ger' or not(@xml:lang)][1]"/>
						<xsl:if test="$term">
							<xsl:value-of select="$term"/>
						</xsl:if>
						<xsl:if test="lido:conceptID">
							<xsl:text>, Lizenz-URI: </xsl:text>
							<xsl:for-each select="lido:conceptID">
								<span class="uri">
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="."/>
										</xsl:attribute>
										<xsl:attribute name="target">_blank</xsl:attribute>
										<xsl:value-of select="."/>
									</a>
								</span>
								<xsl:if test="position() != last()">
									<xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="position() != last()">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</p>
				<xsl:if test="//lido:recordInfoLink">
					<p>
						<strong>Link zum veröffentlichten Metadatensatz</strong>
						<small> (lido:recordInfoLink): </small>
						<xsl:for-each select="//lido:recordInfoLink">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="."/>
								</xsl:attribute>
								<xsl:attribute name="target">_blank</xsl:attribute>
								<xsl:value-of select="."/>
							</a>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
				<xsl:if test="//lido:recordMetadataDate">
					<p>
						<strong>Datierung des Datensatzes</strong>
						<small> (lido:recordMetadataDate): </small>
						<xsl:for-each select="//lido:recordMetadataDate">
							<xsl:value-of select="."/>
							<xsl:if test="@lido:type">
								<xsl:text> (</xsl:text>
								<xsl:choose>
									<xsl:when test="@lido:type='http://terminology.lido-schema.org/lido00472'">
										<xsl:text>Erstellungsdatum [http://terminology.lido-schema.org/lido00472]</xsl:text>
									</xsl:when>
									<xsl:when test="@lido:type='http://terminology.lido-schema.org/lido00932'">
										<xsl:text>Änderungsdatum [http://terminology.lido-schema.org/lido00473]</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@lido:type"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>)</xsl:text>
							</xsl:if>
							<xsl:if test="position() != last()">
								<xsl:text>; </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</p>
				</xsl:if>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
