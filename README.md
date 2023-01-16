# Regionalatlas API

API zum [Regionalatlas Deutschland](https://regionalatlas.statistikportal.de/#) der statistischen Ämter des Bundes und der Länder. 

Der Regionalatlas Deutschland der Statistischen Ämter des Bundes und der Länder visualisiert aktuell laut [statistischem Bundesamt](https://www.destatis.de/DE/Service/Statistik-Visualisiert/_inhalt.html) mehr als 160 Indikatoren aus 20 Themenbereichen für Bundesländer, Regierungsbezirke, Kreisfreie Städte und Landkreise. Grundlage des Regionalatlas ist die Regionaldatenbank Deutschland.

## query

**URL:** https://www.gis-idmz.nrw.de/arcgis/rest/services/stba/regionalatlas/MapServer/dynamicLayer/query

Die gewünschten Daten lassen sich über GET-Parameter im Query-String spezifizieren.


### Parameter

Die Werte aller Parameter müssen URL-codiert sein wie im Beispiel unten verdeutlicht (also z.B. "where=1%3D1" statt "where=1=1").


**Parameter** *layer* 

Komplexer Parameter, der im JSON-Format Details der Anfrage spezifiziert.
In der Regel stellt enthält der layer-Parameter ein Objekt (in geschweiften Klammern), das seinerseits ein Objekt namens "source" enthält. Das source-Objekt wiederum enthält ein Objekt, das zum einen das Objekt "dataSource" und zum anderen ein Datum namens "type" mit dem Wert "dataLayer" enthält. In dataSource wird die gewünschte Tabelle spezifiziert (z.B. für Angaben zur Bevölkerungsdichte "ai002_1_5") - im Folgenden mit dem Platzhalter *tableName* gekennzeichnet.

dataSource kann unterschiedlich aufgebaut sein und enthält entweder (a) Daten namens "dataSourceName" (mit einem Wert wie z.B. "regionalatlas.*tableName*"), "workspaceId (z.B.  "gdb") und "type" (z.B. "table") oder (b) Daten namens "geometryType" (z.B. "esriGeometryPolygon"), "workspaceId" (z.B. "gdb"), "query" (mit einem SQL-Query, z.B. "SELECT * FROM verwaltungsgrenzen_gesamt LEFT OUTER JOIN *tableName* ON ags = ags2 and jahr = jahr2 WHERE typ = 3 AND jahr = 2020 AND (jahr2 = 2020 OR jahr2 IS NULL)"), "oidFields" (z.B. "id"), "spatialReference" (mit einem Objekt, das wiederum das Datum "wkid" mit einem Wert wie 25832 umfasst), und "type":"queryTable".

Der SQL-Query dürfte für Nutzer*innen des Regionalatlas Deutschland weitgehend selbsterklärend sein, wobei man wissen muss dass die Variable *typ* die gewünschte regionale Ebene spezifiziert: 
- 1=Bundesländer, 
- 2=Regierungsbezirke und Statistische Regionen, 
- 3=Kreise und kreisfreie Städte.

Hier ein Beispiel für den Layer-Parameter:

```
layer={"source":{"dataSource":{"geometryType":"esriGeometryPolygon","workspaceId":"gdb","query":"SELECT * FROM verwaltungsgrenzen_gesamt LEFT OUTER JOIN ai002_1_5 ON ags = ags2 and jahr = jahr2 WHERE typ = 1 AND jahr = 2020 AND (jahr2 = 2020 OR jahr2 IS NULL)","oidFields":"id","spatialReference":{"wkid":25832},"type":"queryTable"},"type":"dataLayer"}}
```

Bzw. nach URL-Codierung:

```
layer=%7B%22source%22%3A%7B%22dataSource%22%3A%7B%22geometryType%22%3A%22esriGeometryPolygon%22%2C%22workspaceId%22%3A%22gdb%22%2C%22query%22%3A%22SELECT%20*%20FROM%20verwaltungsgrenzen_gesamt%20LEFT%20OUTER%20JOIN%20ai002_1_5%20ON%20ags%20%3D%20ags2%20and%20jahr%20%3D%20jahr2%20WHERE%20typ%20%3D%201%20AND%20jahr%20%3D%202020%20AND%20(jahr2%20%3D%202020%20OR%20jahr2%20IS%20NULL)%22%2C%22oidFields%22%3A%22id%22%2C%22spatialReference%22%3A%7B%22wkid%22%3A25832%7D%2C%22type%22%3A%22queryTable%22%7D%2C%22type%22%3A%22dataLayer%22%7D%7D
```

Gültige Einträge für die *tableName* werden im Folgenden auszugsweise dargestellt (jeweils mit den enthaltenen Variablen/fields, vgl. Parameter *outFields*)

- Bevölkerungsstand: ai002_1_5
- - ai0201: Bevölkerungsdichte (EW je qkm)
- - ai0202: Bevölkerungsentwicklung im Jahr je 10.000 EW
- - ai0208: Anteil der ausländischen Bevölkerung an der Gesamtbevölkerung
- - ai0209: Lebendgeborene je 10.000 EW
- - ai0210: Gestorbene je 10.000 EW
- - ai0211: Geburten-/Gestorbenenüberschuss je 10.000 EW
- - ai0212: Wanderungssaldo je 10.000 EW

- Bevölkerung nach Alter: ai002_2_5

- - ai0203: Bevölkerung 0 bis 17 Jahre
- - ai0204: Bevölkerung 18 bis 24 Jahre
- - ai0205: Bevölkerung 25 bis 44 Jahre
- - ai0206: Bevölkerung 45 bis 64 Jahre
- - ai0207: Bevölkerung 65 Jahre und älter

- Bevölkerung - Durchschnittsalter: ai002_4_5 
- - ai0218: Durchschnittsalter der Bevölkerung 
- - ai0219: das Durchschnittsalter der Mutter bei der Geburt des 1. Kindes)

- Wanderungen nach Geschlecht und- Alter: ai002_3
- - ai0213: Wanderungssaldo je 10 000: Männer 18 bis 29 Jahre
- - ai0214: Wanderungssaldo je 10.000: Frauen 18 bis 29 Jahre

- Einbürgerungen: ai002_5
- - ai0220: Einbürgerungsquote

- Arbeitslosenquote: ai008_1_5 
- - ai0801: Arbeitslosenquote
- - ai0806: Anteil Arbeitslose 15-24 Jahre an Arbeitslosen insgesamt
- - ai0807: Anteil Arbeitslose 55-64 Jahre an Arbeitslosen insgesamt
- - ai0808: Anteil Langzeitarbeitslose an Arbeitslosen insgesamt
- - ai0809: Anteil der ausl. Arbeitslosen an Arbeitslosen insgesamt 

- Bruttoinlandsprodukt ai017_1
- - ai1701 BIP je Erwerbstätigen
- - ai1702 Veränderung des BIP zum Vorjahr
- - ai1703 BIP je EW

- Erwerbstätige (ET) nach Wirtschaftsbereichen ai007_1
- - ai0701: Arbeitsplatzdichte
- - ai0702: Anteil ET Land- u. Forstwirtschaft, Fischerei
- - ai0703: Anteil ET Produzierendes Gewerbe
- - ai0704: Anteil ET Verarbeitendes Gewerbe
- - ai0705: Anteil ET Baugewerbe
- - ai0706: Anteil ET Dienstleistungsbereiche
    ai0707: Anteil ET Handel, Verkehr, Gastgewerbe, Informat., Kommun.
    ai0708: Anteil ET Finanz-, Versich.-, Unt.-dl., Grundst.-, Wohnungsw.
    ai0709: Anteil ET Öffentl. u. sonst. Dienstl., Erziehung, Gesundh.

- Betreute Kinder in Tagespflege/Tageseinrichtungen: ai003_1
- - ai0301: Anteil betreute Kinder 0-2 Jahre in Tageseinrichtungen am 01.03.
- - ai0302: Anteil betreute Kinder 0-2 Jahre in Tagespflege am 01.03.
- - ai0303: Anteil betreute Kinder 3-5 Jahre in Tageseinrichtungen am 01.03.

- Schulabgänger/-innen ai003_2
- - ai0304: Anteil Schulabgänger/-innen mit allgem. Hochschulreife
- - ai0305: Anteil Schulabgänger/-innen ohne Hauptschulabschluss

- Betreuungsquote ai003_3
- - ai0306: Betreuungsquote 0 bis 2 Jahre am 01.03.
- - ai0307: Betreuungsquote 3 bis 5 Jahre am 01.03.

- Erwerbstätige (ET) nach Wirtschaftsbereichen ai007_1
- - ai0701: Arbeitsplatzdichte
- - ai0702: Anteil ET Land- u. Forstwirtschaft, Fischerei
- - ai0703: Anteil ET Produzierendes Gewerbe
- - ai0704: Anteil ET Verarbeitendes Gewerbe
- - ai0705: Anteil ET Baugewerbe
- - ai0706: Anteil ET Dienstleistungsbereiche
- - ai077: Anteil ET Handel, Verkehr, Gastgewerbe, Informat., Kommun.
- - ai0708: Anteil ET Finanz-, Versich.-, Unt.-dl., Grundst.-, Wohnungsw.
- - ai0709: Anteil ET Öffentl. u. sonst. Dienstl., Erziehung, Gesundh.

- Arbeitslosenquote ausgewählte Personengruppen: ai008_2
- - ai0802: Arbeitslosenquote Männer
- - ai0803: Arbeitslosenquote Frauen
- - ai0804: Arbeitslosenquote 15 bis 24 Jahre
- - ai0805: Arbeitslosenquote Ausländerinnen und Ausländer

- Flächennutzung nach ALKIS: ai001_2_5
- - ai006: Anteil der Fläche für Siedlung an Gesamtfläche
- - ai007: Anteil der Fläche für Verkehr an Gesamtfläche
- - ai008: Anteil der Fläche für Landwirtschaft an Gesamtfläche
- - ai009: Anteil der Fläche für Wald an Gesamtfläche
- - ai010: Anteil Sport-, Freizeit-, Erholungsfläche an Gesamtfläche
- - ai011: Anteil Siedlungs- und Verkehrsfläche an Gesamtfläche
- - ai013: Siedlungs- und Verkehrsfläche je EW
- - ai014: Freiraumfläche je EW

- Flächennutzung nach ALB: ai001_5
- - ai0101: Anteil Siedlungs- und Verkehrsfläche an Gesamtfläche
- - ai0102: Anteil Erholungsfläche an Gesamtfläche
- - ai0103: Anteil Landwirtschaftsfläche an Gesamtfläche
- - ai0104: Anteil Waldfläche an Gesamtfläche

- Elterngeldbezug: aig_018
- - ai1801: Elterngeldbezug Vater

- Krankenhäuser: ai014_1
- - ai1401: Krankenhausbettendichte (Betten je 1.000 EW)

- Pflege und Personal: ai014_2
- - ai1402: Pflegebedürftige je 1.000 EW ab 65 Jahre
- - ai1403: Personal je 100 Pflegebedürftige in vollstationären Pflege
- - ai1404: Personal je 100 Pflegebedürftige in ambulanter Pflege
- - ai1405: Plätze in Pflegeheimen je 1.000 EW ab 65 Jahre

- Investitionen: ai010_1
- - ai1001: Investitionen je Beschäftigten

- Bruttoentgelte: ai010_2_5
- - ai1002: Bruttoentgelte je Beschäftigten

- Landwirtschaftl. Betriebe - Viehhaltung: ai009
- - ai0901: Durchschnittliche Betriebsgröße
- - ai0902: Rinder je 100 ha landwirtschaftlich genutzter Fläche 
- - ai0903: Schweine je 100 ha landwirtschaftlich genutzter Fläche 

- Pkw-Dichte: ai_n_08_01 oder ai013_1
- - ai1301: Pkw-Bestand je 1.000 EW am 01.01.

- Beschäftigte im öffentlichen Bereich: ai015
- - ai1501: Beschäftigte Bund, Länder, Gemeinden/-verbände je 1.000 EW

- Verfügbares Einkommen je EW: ai_s_01
- - ai1601: Verfügbares Einkommen je EW

- Armutsgefährdung: ai_s_02
- - ai2301: Armutsgefährdungsquote (Bundesmedian)
- - ai2302: Armutsgefährdungsquote (regionaler Median)

- Grundsicherung für Arbeitssuchende (SGB II): ai_s_04
- - ai2102: SGB II-Quote bis Altersgrenze
- - ai2108:  Quote erwerbsfähige SGB II-Leistungsberechtigte
- - ai2109:  Quote erwerbsfähige SGB II-Leistungsberechtigte Frauen
- - ai2110:  Quote erwerbsfähige SGB II-Leistungsberechtigte Männer
- - ai2105:  Anteil Empfänger/-innen Arbeitslosengeld II bis 24 Jahre
- - ai2106:  Anteil Empfänger/-innen Arbeitslosengeld II ab 55 Jahre
- - ai2107: Anteil Kinder mit Bezug von Sozialgeld

- Beherbergung: ai012_5
- - ai1201: Durchschnittliche Aufenthaltsdauer
- - ai1202: Übernachtungen je EW

- Wasserversorgung, Wasserabgabe: ai019_2
- - 1908: Wasserabgabe je EW und Tag (in Liter)

- Wasserentgelt: ai019_1_5
- - 1906: verbrauchsabhängig. Entgelt Trinkwasserversorgung pro m³
- - 1907: verbrauchsunabhängig. Entgelt für Trinkwasserversorgung

- Haushaltsabfälle: ai019
- - ai1901: Haushaltsabfälle je EW
- - ai1902: Haus- und Sperrmüll je EW
- - ai1903: Getrennt erfasste Wertstoffe je EW
- - ai1904: Abfälle aus der Biotonne je EW
- - ai1905: Biologisch abbaubare Garten- und Parkabfälle je EW

- Gewerbeanmeldungen: ai004_1
- - ai0401: Gewerbeanmeldungen je 10.000 EW

- Unternehmensinsolvenzen: ai004_2	
- - ai0402: Unternehmensinsolvenzen je 10.000 steruerpfl. Unternehmen

- Verfügbares Einkommen: ai016_1
- - ai1601: Verfügbares Einkommen je EW

- Einkünfte: ai016_2_5
- - ai1602: Gesamtbetrag der Einkünfte je Steuerpflichtigen

- Straßenverkehrsunfälle bezogen auf EW: ai013_2
- - ai1302: Straßenverkehrsunfälle je 10.000 EW
- - ai1304: Getötete bei Straßenverkehrsunfällen je 100.000 EW
- - ai1305: Verletzte bei Straßenverkehrsunfällen je 100.000 EW

- Bundestagswahl: ai005
- - ai0501: Zweitstimmenanteil CDU/CSU, Bundestagswahl
- - ai0502: Zweitstimmenanteil SPD, Bundestagswahl
- - ai0503: Zweitstimmenanteil FDP, Bundestagswahl
- - ai0504: Zweitstimmenanteil GRÜNE, Bundestagswahl
- - ai0505: Zweitstimmenanteil DIE LINKE, Bundestagswahl
- - ai0507: Zweitstimmenanteil AfD, Bundestagswahl
- - ai0506: Wahlbeteiligung, Bundestagswahl

- Europawahl: ai006
- - ai0601: Stimmenanteil CDU/CSU, Europawahl
- - ai0602: Stimmenanteil SPD, Europawahl
- - ai0603: Stimmenanteil FDP, Europawahl
- - ai0604: Stimmenanteil GRÜNE, Europawahl
- - ai0605: Stimmenanteil DIE LINKE, Europawahl
- - ai0607: Stimmenanteil AfD, Europawahl
- - ai0606: Wahlbeteiligung, Europawahl

- Erwerbstätigkeit: ai_z2_2011
- - ai_z08: Erwerbslosenquote
- - ai_z09: Erwerbstätigenquote
- - ai_z10: Erwerbstätigenquote Frauen
- - ai_z11: Erwerbstätigenquote Männer

- Wohn- und Gebäudezählung: ai_z4_2011
- - ai_z15: Wohnungen je Wohngebäude
- - ai_z16: Eigentümerquote
- - ai_z17: Leerstandsquote
- - ai_z18: Durchschnittliche Wohnfläche je EW
- - ai_z19: Durchschnittliche Wohnfläche je Wohnung




**Parameter** *f*

Output-Format (z.B. "json" oder "html").


**Parameter** *outFields*

Auszugebende Variablen/fields (z.B. "*").


**Parameter** *returnGeometry*
Boolsche Angabe, ob Angaben zur Geometrie gesendet werden sollen (z.B. "false").


**Parameter** *spatialRel*

spational relation (z.B. "esriSpatialRelIntersects").


**Parameter** *where*

Spezifikation einer gewünschten Teilmenge der Daten (z.B."1=1"" für alle Daten oder "ags2 = 'DG' and jahr2 =  2020")


### Beispiel

```bash
bevoelkerungsdichteJeBundesland=$(curl https://www.gis-idmz.nrw.de/arcgis/rest/services/stba/regionalatlas/MapServer/dynamicLayer/query?layer=%7B%22source%22%3A%7B%22dataSource%22%3A%7B%22geometryType%22%3A%22esriGeometryPolygon%22%2C%22workspaceId%22%3A%22gdb%22%2C%22query%22%3A%22SELECT%20*%20FROM%20verwaltungsgrenzen_gesamt%20LEFT%20OUTER%20JOIN%20ai002_1_5%20ON%20ags%20%3D%20ags2%20and%20jahr%20%3D%20jahr2%20WHERE%20typ%20%3D%201%20AND%20jahr%20%3D%202020%20AND%20(jahr2%20%3D%202020%20OR%20jahr2%20IS%20NULL)%22%2C%22oidFields%22%3A%22id%22%2C%22spatialReference%22%3A%7B%22wkid%22%3A25832%7D%2C%22type%22%3A%22queryTable%22%7D%2C%22type%22%3A%22dataLayer%22%7D%7D&f=json&outFields=*&returnGeometry=false&spatialRel=esriSpatialRelIntersects&where=1%3D1)
```
