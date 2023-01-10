# Regionalatlas API

API zum [Regionalatlas Deutschland](https://regionalatlas.statistikportal.de/#) der statistischen Ämter des Bundes und der Länder. 

Der Regionalatlas Deutschland der Statistischen Ämter des Bundes und der Länder visualisiert aktuell laut [statistischem Bundesamt](https://www.destatis.de/DE/Service/Statistik-Visualisiert/_inhalt.html) mehr als 160 Indikatoren aus 20 Themenbereichen für Bundesländer, Regierungsbezirke, Kreisfreie Städte und Landkreise. Grundlage des Regionalatlas ist die Regionaldatenbank Deutschland.

## query

**URL:** https://www.gis-idmz.nrw.de/arcgis/rest/services/stba/regionalatlas/MapServer/dynamicLayer/query

Die gewünschten Daten lassen sich über GET-Parameter im Query-String spezifizieren.


### Parameter

Die Werte aller Parameter müssen URL-codiert sein wie im Beispiel unten verdeutlicht (also z.B. "where=1%3D1" statt "where=1=1").


**layer:** 

Komplexer Parameter, der im JSON-Format Details der Anfrage spezifiziert.
In der Regel stellt enthält der layer-Parameter ein Objekt (in geschweiften Klammern), das seinerseits ein Objekt namens "source" enthält. Das source-Objekt wiederum enthält ein Objekt, das zum einen das Objekt "dataSource" und zum anderen ein Datum namens "type" mit dem Wert "dataLayer" enthält. In dataSource wird die gewünschte Tabelle spezifiziert (z.B. für Angaben zur Bevölkerungsdichte "ai002_1_5") - im Folgenden mit dem Platzhalter *tableName* gekennzeichnet.

dataSource kann unterschiedlich aufgebaut sein und enthält entweder (a) Daten namens "dataSourceName" (mit einem Wert wie z.B. "regionalatlas.*tableName*"), "workspaceId (z.B.  "gdb") und "type" (z.B. "table") oder (b) Daten namens "geometryType" (z.B. "esriGeometryPolygon"), "workspaceId" (z.B. "gdb"), "query" (mit einem SQL-Query, z.B. "SELECT * FROM verwaltungsgrenzen_gesamt LEFT OUTER JOIN *tableName* ON ags = ags2 and jahr = jahr2 WHERE typ = 3 AND jahr = 2020 AND (jahr2 = 2020 OR jahr2 IS NULL)"), "oidFields" (z.B. "id"), "spatialReference" (mit einem Objekt, das wiederum das Datum "wkid" mit einem Wert wie 25832 umfasst), und "type":"queryTable".

Der SQL-Query dürfte für Nutzer*innen des Regionalatlas Deutschland weitgehend selbsterklärend sein, wobei man wissen muss dass die Variable *typ* die gewünschte regionale Ebene spezifiziert: 
- 1=Bundesländer, 
- 2=Regierungsbezirke und Statistische Regionen, 
- 3=Kreise und kreisfreie Städte.

Gültige Einträge für die *tableName* werden im Folgenden auszugsweise dargestellt (jeweils mit den enthaltenen Variablen/fields)

- Bevölkerungsdichte: ai002_1_5
-- ai0201: Bevölkerungsdichte (EW je qkm)
- - ai0202: Bevölkerungsentwicklung im Jahr je 10.000 EW
- - ai0208: Anteil der ausländischen Bevölkerung an der Gesamtbevölkerung
- - ai0209: Lebendgeborene je 10.000 EW
- - ai0210: Gestorbene je 10.000 EW
- - ai0211: Geburten-/Gestorbenenüberschuss je 10.000 EW
- - ai0212: Wanderungssaldo je 10.000 EW

- Altersdurchschnitt: ai002_4_5 
- - ai0218: Durchschnittsalter der Bevölkerung 
- - ai0219: das Durchschnittsalter der Mutter bei der Geburt des 1. Kindes)

- Arbeitslosenquote: ai008_1_5 
- - ai0801: Arbeitslosenquote
- - ai0806: Anteil Arbeitslose 15-24 Jahre an Arbeitslosen insgesamt
- - ai0807: Anteil Arbeitslose 55-64 Jahre an Arbeitslosen insgesamt
- - ai0808: Anteil Langzeitarbeitslose an Arbeitslosen insgesamt
- - ai0809: Anteil der ausl. Arbeitslosen an Arbeitslosen insgesamt 

- Verfügbares Einkommen je EW: ai_s_01
- SGB2-Quote: ai_s_04
- BIP je Erwerbstätigem: ai017_1
- Wahlergebnisse Bundestagswahl: ai005


**f:**

Output-Format (z.B. "json" oder "html").


**outFields:**

Auszugebende Variablen/fields (z.B. "*").


**returnGeometry:**
Boolsche Angabe, ob Angaben zur Geometrie gesendet werden sollen (z.B. "false").


**spatialRel:**

spational relation (z.B. "esriSpatialRelIntersects").


**where**

Spezifikation einer gewünschten Teilmenge der Daten (z.B."1=1"" für alle Daten oder "ags2 = 'DG' and jahr2 =  2020")


### Beispiel

```bash
bevoelkerungsdichteJeBundesland=$(curl https://www.gis-idmz.nrw.de/arcgis/rest/services/stba/regionalatlas/MapServer/dynamicLayer/query?layer=%7B%22source%22%3A%7B%22dataSource%22%3A%7B%22geometryType%22%3A%22esriGeometryPolygon%22%2C%22workspaceId%22%3A%22gdb%22%2C%22query%22%3A%22SELECT%20*%20FROM%20verwaltungsgrenzen_gesamt%20LEFT%20OUTER%20JOIN%20ai002_1_5%20ON%20ags%20%3D%20ags2%20and%20jahr%20%3D%20jahr2%20WHERE%20typ%20%3D%201%20AND%20jahr%20%3D%202020%20AND%20(jahr2%20%3D%202020%20OR%20jahr2%20IS%20NULL)%22%2C%22oidFields%22%3A%22id%22%2C%22spatialReference%22%3A%7B%22wkid%22%3A25832%7D%2C%22type%22%3A%22queryTable%22%7D%2C%22type%22%3A%22dataLayer%22%7D%7D&f=json&outFields=*&returnGeometry=false&spatialRel=esriSpatialRelIntersects&where=1%3D1)
```
