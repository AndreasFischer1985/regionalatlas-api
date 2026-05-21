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
In der Regel enthält der layer-Parameter ein Objekt (in geschweiften Klammern), das seinerseits ein Objekt namens "source" enthält. Das source-Objekt wiederum enthält ein Objekt, das zum einen das Objekt "dataSource" und zum anderen ein Datum namens "type" mit dem Wert "dataLayer" enthält. In dataSource wird die gewünschte Tabelle spezifiziert (z.B. für Angaben zur Bevölkerungsdichte "ai002_1_5") - im Folgenden auch mit dem Platzhalter *tableName* gekennzeichnet.

Hier ein Beispiel für den Layer-Parameter:

```
layer={"source":{"dataSource":{"geometryType":"esriGeometryPolygon","workspaceId":"gdb","query":"SELECT * FROM verwaltungsgrenzen_gesamt LEFT OUTER JOIN ai002_1_5 ON ags = ags2 and jahr = jahr2 WHERE typ = 1 AND jahr = 2020 AND (jahr2 = 2020 OR jahr2 IS NULL)","oidFields":"id","spatialReference":{"wkid":25832},"type":"queryTable"},"type":"dataLayer"}}
```

dataSource kann unterschiedlich aufgebaut sein und enthält entweder (a) Daten namens "dataSourceName" (mit einem Wert wie z.B. "regionalatlas.*tableName*"), "workspaceId (z.B.  "gdb") und "type" (z.B. "table") oder (b) Daten namens "geometryType" (z.B. "esriGeometryPolygon"), "workspaceId" (z.B. "gdb"), "query" (mit einem SQL-Query, z.B. "SELECT * FROM verwaltungsgrenzen_gesamt LEFT OUTER JOIN *tableName* ON ags = ags2 and jahr = jahr2 WHERE typ = 3 AND jahr = 2020 AND (jahr2 = 2020 OR jahr2 IS NULL)"), "oidFields" (z.B. "id"), "spatialReference" (mit einem Objekt, das wiederum das Datum "wkid" mit einem Wert wie 25832 umfasst), und "type":"queryTable".

Der SQL-Query dürfte für Nutzer*innen des Regionalatlas Deutschland weitgehend selbsterklärend sein, wobei man wissen muss dass die Variable *typ* die gewünschte regionale Ebene spezifiziert: 
- 1=Bundesländer, 
- 2=Regierungsbezirke und Statistische Regionen, 
- 3=Kreise und kreisfreie Städte,
- 5=Gemeinden/Verbandsgemeinden 

Bzw. nach URL-Codierung:

```
layer=%7B%22source%22%3A%7B%22dataSource%22%3A%7B%22geometryType%22%3A%22esriGeometryPolygon%22%2C%22workspaceId%22%3A%22gdb%22%2C%22query%22%3A%22SELECT%20*%20FROM%20verwaltungsgrenzen_gesamt%20LEFT%20OUTER%20JOIN%20ai002_1_5%20ON%20ags%20%3D%20ags2%20and%20jahr%20%3D%20jahr2%20WHERE%20typ%20%3D%201%20AND%20jahr%20%3D%202020%20AND%20(jahr2%20%3D%202020%20OR%20jahr2%20IS%20NULL)%22%2C%22oidFields%22%3A%22id%22%2C%22spatialReference%22%3A%7B%22wkid%22%3A25832%7D%2C%22type%22%3A%22queryTable%22%7D%2C%22type%22%3A%22dataLayer%22%7D%7D
```

Gültige Einträge für die *tableName* finden sich unter [https://regionalatlas.statistikportal.de/taskrunner/services.json](https://regionalatlas.statistikportal.de/taskrunner/services.json) und werden im Folgenden tabellarisch dargestellt (*tableName* findet sich in der Spalte "table-code", die enthaltenen Variablen/fields - vgl. Parameter *outFields* - in der Spalte "attribute-code").

|title|snippet|url|x|
|---|---|---|---|
|Basemap_light|Basemap_light|https://www.karto365.de/hosting/rest/services/Basemap_light/MapServer||
|erw_mini_HA2023|Anteil der ausschließlich geringfügig entlohnten Beschäftigten am Arbeitsort an allen Erwerbstätigen im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/erw_mini_HA2023/MapServer|erw_mini|
|pendel_b_HA2023|Durchschnittliche Pendeldistanzen aller SV_Beschäftigten am Wohnort 2021 in km|https://www.karto365.de/hosting/rest/services/pendel_b_HA2023/MapServer|pendel|
|p_nelade_r_HA2023|Pkw_Fahrzeit zur nächsten öffentlich zugänglichen Normalladestation für Elektroautos im Jahr 2023 in Minuten|https://www.karto365.de/hosting/rest/services/p_nelade_r_HA2023/MapServer||
|pendel_a_HA2023|Pendlerverflechtungen zwischen Gemeindeverbänden nach Anzahl der Pendler im Jahr 2021|https://www.karto365.de/hosting/rest/services/pendel_a_HA2023/MapServer|Pendler202|
|bev_u18_HA2023|Anteil der unter 18_Jährigen an der Gesamtbevölkerung im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/bev_u18_HA2023/MapServer|bev_u18|
|teilz_w_HA2023|Weibliche sozialversicherungspflichtig Beschäftigte in Teilzeit am Arbeitsort an den weiblichen sozialversicherungspflichtig Beschäftigten im Jahr 2022 in _%|https://www.karto365.de/hosting/rest/services/teilz_w_HA2023/MapServer|teilz_w|
|heiz_wohn_HA2023|Anteil fertiggestellter Wohnungen mit primär erneuerbarer Heizenergie an allen errichteten Wohnungen in neuen Wohngebäuden im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/heiz_wohn_HA2023/MapServer|heiz_wohn|
|schule_oabschl_HA2023|Anteil der Schulabgänger__innen ohne Hauptschulabschluss an allen Schulabgänger__innen allgemeinbildender Schulen im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/schule_oabschl_HA2023/MapServer|schule_oabschl|
|oenv_HA2023|Anteil der Bevölkerung_ die in maximal 600 m bzw_ bei Bahnhöfen 1_200 m Luftlinienentfernung um eine Haltestelle mit mindestens 20 Abfahrten im ÖV am Tag wohnt_ im Jahr 2022 in _%|https://www.karto365.de/hosting/rest/services/oenv_HA2023/MapServer|oenv|
|bev_ausl_HA2023|Anteil der Ausländer__innen an der Gesamtbevölkerung im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/bev_ausl_HA2023/MapServer|bev_ausl|
|preis_miet_HA2023|Wiedervermietungsmieten _Angebotsmieten nettokalt_ im Jahr 2022 in € je m²|https://www.karto365.de/hosting/rest/services/preis_miet_HA2023/MapServer||
|erw_minineben_HA2023|Anteil der geringfügig entlohnten Beschäftigten im Nebenjob am Arbeitsort an allen Erwerbstätigen im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/erw_minineben_HA2023/MapServer|erw_minineben|
|p_freibad_HA2022|Pkw_Fahrzeit zum nächsten Freibad oder Naturbad im Jahr 2020 in Minuten|https://www.karto365.de/hosting/rest/services/p_freibad_HA2022/MapServer|p_freibad|
|beschq_m_HA2023|Sozialversicherungspflichtig beschäftigte Männer am Wohnort je 100 Männer im erwerbsfähigen Alter im Jahr 2022|https://www.karto365.de/hosting/rest/services/beschq_m_HA2023/MapServer|beschq_m|
|fl_suv_HA2022|Anteil der Siedlungs_ und Verkehrsfläche an der Gesamtfläche im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/fl_suv_HA2022/MapServer|fl_suv|
|p_kh_gru_b|Pkw_Fahrzeit zum nächsten Krankenhaus mit Grundversorgung im Jahr 2016 in Minuten, K33, p_kh_gru_b, feature|https://www.karto365.de/hosting/rest/services/p_kh_gru_b/MapServer||
|st_einnkr_HA2021|Steuereinnahmekraft je Einwohner__in im Jahr 2018 in €; st_einnkr_HA2021|https://www.karto365.de/hosting/rest/services/st_einnkr_HA2021/MapServer|st_einnkr|
|teilz_m_HA2022|Männliche sozialversicherungspflichtig Beschäftigte in Teilzeit am Arbeitsort an den männlichen sozialversicherungspflichtig Beschäftigten im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/teilz_m_HA2022/MapServer|teilz_m|
|wohn_EFZH_HA2023|Fertiggestellte Wohnungen in neuen Ein_ und Zweifamilienhäusern je 10_000 Einwohner__innen im Jahr 2021|https://www.karto365.de/hosting/rest/services/wohn_EFZH_HA2023/MapServer|wohn_EZFH|
|VG250_Gemeinden1220_Punkt|VG250_Gemeinden1220_Punkt, feature to point, dann nur punktlayer beschriftet|https://www.karto365.de/hosting/rest/services/VG250_Gemeinden1220_Punkt/MapServer||
|p_selade_r_HA2023|Pkw_Fahrzeit zur nächsten öffentlich zugänglichen Schnellladestation für Elektroautos im Jahr 2023 in Minuten|https://www.karto365.de/hosting/rest/services/p_selade_r_HA2023/MapServer||
|p_elade_HA2022|Pkw_Fahrzeit zur nächsten Ladestation für Elektroautos im Jahr 2020 in Minuten|https://www.karto365.de/hosting/rest/services/p_elade_HA2022/MapServer|p_elade|
|teilz_w_HA2022|Weibliche sozialversicherungspflichtig Beschäftigte in Teilzeit am Arbeitsort an den weiblichen sozialversicherungspflichtig Beschäftigten im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/teilz_w_HA2022/MapServer|teilz_w|
|erw_vol_HA2022|Veränderung des Arbeitsvolumens am Arbeitsort 2014 zu 2019 in _|https://www.karto365.de/hosting/rest/services/erw_vol_HA2022/MapServer|erw_vol|
|ko_kasskred_HA2022|Kommunale Kassenkredite je Einwohner__in im Jahr 2020 in €|https://www.karto365.de/hosting/rest/services/ko_kasskred_HA2022/MapServer|ko_kasskred|
|p_markt_b|p_markt_b, feature|https://www.karto365.de/hosting/rest/services/p_markt_b/MapServer||
|v_lte_ZA2022|Mobile Breitbandverfügbarkeit mit LTE ab 2 Mbit_s in _ der Fläche im Jahr 2021|https://www.karto365.de/hosting/rest/services/v_lte_ZA2022/MapServer|v_lte|
|pfl_stat_wms|Anteil der Pflegebedürftigen in stationärer Pflege im Jahr 2019 an den Pflegebedürftigen insgesamt in _|https://www.karto365.de/hosting/rest/services/pfl_stat_wms/MapServer|pfl_stat|
|bev_ausw_HA2022|Saldo der Außenwanderungen pro 10_000 Einwohner__innen im Jahr 2020|https://www.karto365.de/hosting/rest/services/bev_ausw_HA2022/MapServer|bev_ausw|
|v_breitb1000_HA2023|Anteil der Haushalte_ die mit einer Internetgeschwindigkeit von ≥ 1_000 Mbit_s versorgt werden können_ im Juni 2022 in _%|https://www.karto365.de/hosting/rest/services/v_breitb1000_HA2023/MapServer|v_breitb1000|
|alq_HA2023|Arbeitslosenquote bezogen auf alle zivilen Erwerbspersonen im Jahr 2022 in _%|https://www.karto365.de/hosting/rest/services/alq_HA2023/MapServer|alq|
|kbetr_u3_ZA2022|Anteil der betreuten Kinder unter 3 Jahren in Kindertageseinrichtungen__tagespflege an der Altersgruppe im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/kbetr_u3_ZA2022/MapServer|kbetr_u3|
|VG250_Verbandsgemeinden1219_Punkt|VG250_Verbandsgemeinden1219_Punkt, |https://www.karto365.de/hosting/rest/services/VG250_Verbandsgemeinden1219_Punkt/MapServer||
|kbetr_u3_HA2023|Anteil der betreuten Kinder unter 3 Jahren in Kindertageseinrichtungen__tagespflege an der Altersgruppe im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/kbetr_u3_HA2023/MapServer|kbetr_u3|
|p_elade_f_HA2022|feature abfrage layer für p_elade|https://www.karto365.de/hosting/rest/services/p_elade_f_HA2022/MapServer||
|VG250_GEM1217_neu|VG250_GEM1217_neu|https://www.karto365.de/hosting/rest/services/VG250_GEM1217_neu/MapServer||
|kinder_bg_HA2022|Anteil der unter 15_Jährigen in SGB_II_Bedarfsgemeinschaften an der Altersgruppe im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/kinder_bg_HA2022/MapServer|kinder_bg|
|p_nelade_f_HA2023|Mittlere Pkw_Fahrzeit zur nächsten öffentlich zugänglichen Normalladestation für Elektroautos im Jahr 2023|https://www.karto365.de/hosting/rest/services/p_nelade_f_HA2023/MapServer||
|p_hbad_HA2022|Pkw_Fahrzeit zum nächsten Hallenbad im Jahr 2020 in Minuten|https://www.karto365.de/hosting/rest/services/p_hbad_HA2022/MapServer|p_hbad|
|fl_wald_HA2022|Anteil der Waldfläche an der Gesamtfläche im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/fl_wald_HA2022/MapServer|fl_wald|
|kbetr_ue3_ZA2022|Anteil der betreuten Kinder ab 3 bis unter 6 Jahren in Kindertageseinrichtungen__tagespflege an der Altersgruppe im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/kbetr_ue3_ZA2022/MapServer|kbetr_ue3|
|v_harzt_HA2023|Hausärzte__ärztinnen je 100_000 Einwohner__innen im Jahr 2020|https://www.karto365.de/hosting/rest/services/v_harzt_HA2023/MapServer|v_harzt|
|fl_suv_ZA2023|Anteil der Siedlungs_ und Verkehrsfläche an der Gesamtfläche im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/fl_suv_ZA2023/MapServer|fl_suv|
|erw_mini_ZA2022|Anteil der ausschließlich geringfügig entlohnten Beschäftigten am Arbeitsort an allen Erwerbstätigen im Jahr 2019 in _|https://www.karto365.de/hosting/rest/services/erw_mini_ZA2022/MapServer|erw_mini|
|grusi_wms|Anteil der Bevölkerung mit Grundsicherung im Alter an den 65_Jährigen und Älteren im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/grusi_wms/MapServer|grusi|
|pendel_a_HA2021|Durchschnittliche Pendeldistanzen aller SV_Beschäftigten am Wohnort 2019 in km, pendel_a_HA2021|https://www.karto365.de/hosting/rest/services/pendel_a_HA2021/MapServer|pendel|
|erw_vol_HA2023|Veränderung des Arbeitsvolumens am Arbeitsort 2014 zu 2020 in _%|https://www.karto365.de/hosting/rest/services/erw_vol_HA2023/MapServer|erw_vol|
|fl_landw_HA2022|Anteil der Landwirtschaftsfläche an der Gesamtfläche im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/fl_landw_HA2022/MapServer|fl_landw|
|elterng_v_HA2022|Anteil der Kinder_ deren Vater Elterngeld bezogen hat_ an allen anspruchsbegründeten Kindern im Jahr 2018 in _|https://www.karto365.de/hosting/rest/services/elterng_v_HA2022/MapServer|elterng_v|
|ko_kasskred_HA2021|Kommunale Kassenkredite je Einwohner__in im Jahr 2019 in €, ko_kasskred_HA2021|https://www.karto365.de/hosting/rest/services/ko_kasskred_HA2021/MapServer|ko_kasskred|
|wohn_MFH_HA2023|Fertiggestellte Wohnungen in neuen Mehrfamilienhäusern je 10_000 Einwohner__innen im Jahr 2021|https://www.karto365.de/hosting/rest/services/wohn_MFH_HA2023/MapServer|wohn_MFH|
|p_hbad_f_HA2022|feautre abfrage für p_hbad|https://www.karto365.de/hosting/rest/services/p_hbad_f_HA2022/MapServer||
|VG250_Kreise_1221_Punkte|VG250_Kreise_1221_Punkte, Feature to Point, dann Punktelayer beschriftet|https://www.karto365.de/hosting/rest/services/VG250_Kreise_1221_Punkte/MapServer||
|VG250_Verbandsgemeinden_1220_Punkt|VG250_Verbandsgemeinden_1220_Punkt, feature to point, dann punktelaer beschriftet|https://www.karto365.de/hosting/rest/services/VG250_Verbandsgemeinden_1220_Punkt/MapServer||
|erw_minineben_ZA2023|Anteil der geringfügig entlohnten Beschäftigten im Nebenjob am Arbeitsort an allen Erwerbstätigen im Jahr 2020 in _&|https://www.karto365.de/hosting/rest/services/erw_minineben_ZA2023/MapServer|erw_minineben|
|teilz_insg_HA2022|Anteil der sozialversicherungspflichtig Beschäftigten in Teilzeit am Arbeitsort an den sozialversicherungspflichtig Beschäftigten im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/teilz_insg_HA2022/MapServer|teilz_insg|
|elade_HA2022|Öffentlich zugängliche Ladepunkte für Elektrofahrzeuge im Jahr 2021 je 100_000 Einwohner__innen|https://www.karto365.de/hosting/rest/services/elade_HA2022/MapServer|elade|
|eauto_HA2022|Anteil von Pkw mit reinem Elektroantrieb _BEV_ an allen Pkw im Jahr 2022 in _|https://www.karto365.de/hosting/rest/services/eauto_HA2022/MapServer|eauto|
|bquali_oabschl_HA2022|Anteil sozialversicherungspflichtig Beschäftigter am Arbeitsort ohne einen Berufs__ akademischen Abschluss an allen sozialversicherungspflichtig Beschäftigten im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/bquali_oabschl_HA2022/MapServer|bquali_oabschl|
|wohn_MFH_ZA2022|Fertiggestellte Wohnungen in neuen Mehrfamilienhäusern je 10_000 Einwohner__innen im Jahr 2020|https://www.karto365.de/hosting/rest/services/wohn_MFH_ZA2022/MapServer|wohn_MFH|
|luftrtng_b|luftrtng, k36, feature|https://www.karto365.de/hosting/rest/services/luftrtng_b/MapServer||
|bev_ue65_ZA2022|Anteil der 65_Jährigen und Älteren an der Gesamtbevölkerung im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/bev_ue65_ZA2022/MapServer|bev_ue65|
|bev_dicht_HA2023|Einwohner__innen je km² im Jahr 2021|https://www.karto365.de/hosting/rest/services/bev_dicht_HA2023/MapServer|bev_dicht|
|p_kh_gru_a|Pkw_Fahrzeit zum nächsten Krankenhaus mit Grundversorgung im Jahr 2016 in Minuten; K33, p_kh_gru|https://www.karto365.de/hosting/rest/services/p_kh_gru_a/MapServer||
|ko_kasskred_HA2023|Kommunale Kassenkredite je Einwohner__in im Jahr 2021 in €|https://www.karto365.de/hosting/rest/services/ko_kasskred_HA2023/MapServer|ko_kasskred|
|hh_veink_ZA2022|Verfügbares Einkommen privater Haushalte je Einwohner__in im Jahr 2019 in 1_000 €|https://www.karto365.de/hosting/rest/services/hh_veink_ZA2022/MapServer|hh_veink|
|p_harzt_a|Pkw_Fahrzeit zur nächsten Hausärztin oder zum nächsten Hausarzt im Jahr 2016 in Minuten, K31, p_harzt_a|https://www.karto365.de/hosting/rest/services/p_harzt_a/MapServer||
|teilz_w_HA2021|Weibliche sozialversicherungspflichtig Beschäftigte in Teilzeit am Arbeitsort je 100 weibliche Einwohner im erwerbsfähigen Alter im Jahr 2020, teilz_w_HA2021|https://www.karto365.de/hosting/rest/services/teilz_w_HA2021/MapServer|teilz_w|
|p_sek_1_a|Pkw_Fahrzeit zur nächsten Schule der Sekundarstufe I im Jahr 2015_16_17 in Minuten, K41, p_sek_1|https://www.karto365.de/hosting/rest/services/p_sek_1_a/MapServer||
|wohn_EZFH_ZA2022|Fertiggestellte Wohnungen in neuen Ein_ und Zweifamilienhäusern je 10_000 Einwohner__innen im Jahr 2020|https://www.karto365.de/hosting/rest/services/wohn_EZFH_ZA2022/MapServer|wohn_EZFH|
|p_ozmz_a|Durchschnittliche bevölkerungsgewichtete Pkw_Fahrzeit zum Stadtzentrum des nächsten Ober_ oder Mittelzentrum 2019 in Minuten, K29, p_ozmz, raster|https://www.karto365.de/hosting/rest/services/p_ozmz_a/MapServer||
|p_harzt_b|K31, p_harzt_b, featureinfo|https://www.karto365.de/hosting/rest/services/p_harzt_b/MapServer||
|bev_entw_ZA2021|Gemittelte Entwicklung der Bevölkerungszahl zwischen 2014 und 2019 pro Jahr in %, k3, bev_entw_ZA2021|https://www.karto365.de/hosting/rest/services/bev_entw_ZA2021/MapServer|bev_entw|
|fl_landw_HA2021|Anteil der Landwirtschaftsfläche an der Gesamtfläche im Jahr 2019 in %, fl_landw_HA2021|https://www.karto365.de/hosting/rest/services/fl_landw_HA2021/MapServer|fl_landw|
|p_apo_b|p_apo, feature|https://www.karto365.de/hosting/rest/services/p_apo_b/MapServer||
|sozsich_ZA2023|Anteil der Personen in sozialer Mindestsicherung an allen Einwohnerinnen und Einwohnern im Jahr 2020 in _%|https://www.karto365.de/hosting/rest/services/sozsich_ZA2023/MapServer|sozsich|
|einbr_wms|Fälle von Wohnungseinbruchdiebstahl pro 100_000 Einwohner__innen im Jahr 2021|https://www.karto365.de/hosting/rest/services/einbr_wms/MapServer|einbr|
|p_ozmz_miv_f_HA2021|p_ozmz_miv_f_HA2021, Feature|https://www.karto365.de/hosting/rest/services/p_ozmz_miv_f_HA2021/MapServer||
|beschq_m_HA2022|Sozialversicherungspflichtig beschäftigte Männer am Wohnort je 100 Männer im erwerbsfähigen Alter im Jahr 2021|https://www.karto365.de/hosting/rest/services/beschq_m_HA2022/MapServer|beschq_m|
|kbtr_pers_wms|Plätze in Kindertageseinrichtungen je pädagogisch tätige Person im Jahr 2021|https://www.karto365.de/hosting/rest/services/kbtr_pers_wms/MapServer|kbtr_pers|
|wohn_leer_HA2021|Anteil leer stehender Wohnungen an allen Wohnungen 2018 in %, wohn_leer_HA2021|https://www.karto365.de/hosting/rest/services/wohn_leer_HA2021/MapServer||
|bev_18_65_HA2023|Anteil der 18_ bis unter 65_Jährigen an der Gesamtbevölkerung im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/bev_18_65_HA2023/MapServer|bev_18_65|
|st_einnkr_ZA2023|Steuereinnahmekraft je Einwohner__in im Jahr 2021 in €|https://www.karto365.de/hosting/rest/services/st_einnkr_ZA2023/MapServer|st_einnkr|
|bev_u18_HA2021|Anteil der unter 18_Jährigen an der Gesamtbevölkerung im Jahr 2019 in %, , bev_u18_HA2021|https://www.karto365.de/hosting/rest/services/bev_u18_HA2021/MapServer|bev_u18|
|kbetr_ue3_HA2023|Anteil der betreuten Kinder ab 3 bis unter 6 Jahren in Kindertageseinrichtungen_ _tagespflege an der Altersgruppe im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/kbetr_ue3_HA2023/MapServer|kbetr_ue3|
|erw_wachs_HA2023|Gemittelte Entwicklung der Erwerbstätigenzahl am Arbeitsort von 2011 bis 2021 pro Jahr in _%|https://www.karto365.de/hosting/rest/services/erw_wachs_HA2023/MapServer|erw_wachs|
|bev_entw_ZA2022|Gemittelte Entwicklung der Bevölkerungszahl zwischen 2015 und 2020 pro Jahr in _|https://www.karto365.de/hosting/rest/services/bev_entw_ZA2022/MapServer|bev_entw|
|v_breitb50_HA2021|Anteil der Haushalte, die mit einer Internetgeschwindigkeit von mindestens 1000 Mbit/s versorgt werden können im Jahr 2020 in %|https://www.karto365.de/hosting/rest/services/v_breitb50_HA2021/MapServer|v_breitb50|
|kbetr_ue6_ZA2022|Anteil der betreuten Kinder ab 6 bis unter 11 Jahren in Kindertageseinrichtungen__tagespflege an der Altersgruppe im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/kbetr_ue6_ZA2022/MapServer|kbetr_ue6|
|kbtr_pers_HA2021|Plätze in Kindertageseinrichtungen je pädagogisch tätige Person im Jahr 2019, kbtr_pers_HA2021|https://www.karto365.de/hosting/rest/services/kbtr_pers_HA2021/MapServer|kbtr_pers|
|wohn_EZFH_HA2021|Fertiggestellte Wohnungen in neuen Ein_ und Zweifamilienhäusern je 10_000 Einwohner__innen im Jahr 2019, wohn_EZFH_HA2021|https://www.karto365.de/hosting/rest/services/wohn_EZFH_HA2021/MapServer|wohn_EZFH|
|einbr_HA2022|Fälle von Wohnungseinbruchdiebstahl pro 100_000 Einwohner__innen im Jahr 2021|https://www.karto365.de/hosting/rest/services/einbr_HA2022/MapServer|einbr|
|bev_binw_HA2022|Saldo der Binnenwanderungen pro 10_000 Einwohner__innen im Jahr 2020|https://www.karto365.de/hosting/rest/services/bev_binw_HA2022/MapServer|bev_binw|
|wahl_beteil_wms|Bundestagswahlbeteiligung 2021 in Kreisen in _|https://www.karto365.de/hosting/rest/services/wahl_beteil_wms/MapServer|wahl_beteil|
|preis_miet_HA2021|Wiedervermietungsmieten in mittlerer_guter Wohnlage _Angebotsmieten nettokalt_ 2020 in € je m², preis_miet_HA2021|https://www.karto365.de/hosting/rest/services/preis_miet_HA2021/MapServer||
|v_lte_wms|Mobile Breitbandverfügbarkeit mit LTE ab 2 Mbit_s in _ der Fläche im Jahr 2021|https://www.karto365.de/hosting/rest/services/v_lte_wms/MapServer|v_lte|
|p_apo_f_ZA2022|Pkw_Fahrzeit zum nächsten öffentlichen Apotheke im Jahr 2020 in Minuten|https://www.karto365.de/hosting/rest/services/p_apo_f_ZA2022/MapServer||
|erw_vol_HA2021|Anteil der Pflegebedürftigen in ambulanter Pflege im Jahr 2017 an den Pflegebedürftigen insgesamt in _|https://www.karto365.de/hosting/rest/services/erw_vol_HA2021/MapServer|erw_vol|
|schulden_HA2023|Anteil überschuldeter Personen über 18 Jahre an der Altersgruppe im Jahr 2022 in _%|https://www.karto365.de/hosting/rest/services/schulden_HA2023/MapServer|schulden|
|p_ozmz_miv_r_HA2021|Pkw_Fahrzeit zum Stadtzentrum des nächsten Ober_ oder Mittelzentrum 2020 in Minuten, p_ozmz_miv_r_HA2021, Raster|https://www.karto365.de/hosting/rest/services/p_ozmz_miv_r_HA2021/MapServer||
|kinder_bg_wms|Anteil der unter 15_Jährigen in SGB_II_Bedarfsgemeinschaften an der Altersgruppe im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/kinder_bg_wms/MapServer|kinder_bg|
|kinder_bg_HA2021|Anteil der unter 15_Jährigen in SGB_II_Bedarfsgemeinschaften an der Altersgruppe im Jahr 2019 in %, kinder_bg_HA2021|https://www.karto365.de/hosting/rest/services/kinder_bg_HA2021/MapServer|kinder_bg|
|p_ozmz_oev_f_HA2021|p_ozmz_oev_f_HA2021, feature|https://www.karto365.de/hosting/rest/services/p_ozmz_oev_f_HA2021/MapServer||
|grusi_ZA2022|Anteil der Bevölkerung mit Grundsicherung im Alter an den 65_Jährigen und Älteren im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/grusi_ZA2022/MapServer|grusi|
|erw_wachs_ZA2023|Gemittelte Entwicklung der Erwerbstätigenzahl am Arbeitsort von 2010 bis 2020 pro Jahr in _|https://www.karto365.de/hosting/rest/services/erw_wachs_ZA2023/MapServer|erw_wachs|
|preis_miet_HA2022|Wiedervermietungsmieten _Angebotsmieten nettokalt_ im Jahr 2021 in € je m²|https://www.karto365.de/hosting/rest/services/preis_miet_HA2022/MapServer||
|grusi_HA2023|Anteil der Bevölkerung mit Grundsicherung im Alter an den 65_Jährigen und Älteren im Jahr 2022 in _%|https://www.karto365.de/hosting/rest/services/grusi_HA2023/MapServer|grusi|
|schule_oabschl_HA2022|Anteil der Schulabgänger__innen ohne Hauptschulabschluss an allen Schulabgänger__innen allgemeinbildender Schulen im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/schule_oabschl_HA2022/MapServer|schule_oabschl|
|beschq_insg_HA2021|Sozialversicherungspflichtig Beschäftigte am Wohnort je 100 Einwohner__innen im erwerbsfähigen Alter im Jahr 2020; beschq_insg_HA2021|https://www.karto365.de/hosting/rest/services/beschq_insg_HA2021/MapServer|beschq_insg|
|v_breitb50_HA2023|Anteil der Haushalte_ die mit einer Internetgeschwindigkeit von _ 50 Mbit_s versorgt werden können_ im Juni 2022 in _%|https://www.karto365.de/hosting/rest/services/v_breitb50_HA2023/MapServer|v_breitb50|
|beschq_insg_HA2022|Sozialversicherungspflichtig Beschäftigte am Wohnort je 100 Einwohner__innen im erwerbsfähigen Alter im Jahr 2021|https://www.karto365.de/hosting/rest/services/beschq_insg_HA2022/MapServer|beschq_insg|
|bev_ausl_HA2021|Anteil der Ausländer__innen an der Gesamtbevölkerung im Jahr 2019 in %, bev_ausl_HA2021|https://www.karto365.de/hosting/rest/services/bev_ausl_HA2021/MapServer|bev_ausl|
|bev_ue65_HA2021|Anteil der 65_Jährigen und Älteren an der Gesamtbevölkerung im Jahr 2019 in %, bev_ue65_HA2021|https://www.karto365.de/hosting/rest/services/bev_ue65_HA2021/MapServer|bev_ue65|
|v_harzt_HA2021|Hausärzte__ärztinnen im Jahr 2017 je 100_000 Einwohner__innen|https://www.karto365.de/hosting/rest/services/v_harzt_HA2021/MapServer|v_harzt|
|beschq_w_HA2022|Sozialversicherungspflichtig beschäftigte Frauen am Wohnort je 100 Frauen im erwerbsfähigen Alter im Jahr 2021|https://www.karto365.de/hosting/rest/services/beschq_w_HA2022/MapServer|beschq_w|
|schulden_HA2022|Anteil überschuldeter Personen über 18 Jahre an der Altersgruppe im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/schulden_HA2022/MapServer|schulden|
|erw_bip_HA2021|Bruttoinlandsprodukt je erwerbstätige Person im Jahr 2018 in 1_000 €, erw_bip_HA2021|https://www.karto365.de/hosting/rest/services/erw_bip_HA2021/MapServer|erw_bip|
|p_freibad_r_HA2022|Pkw_Fahrzeit zum nächsten Natur_ oder Freibad im Jahr 2020 in Minuten|https://www.karto365.de/hosting/rest/services/p_freibad_r_HA2022/MapServer||
|beschq_w_HA2023|Sozialversicherungspflichtig beschäftigte Frauen am Wohnort je 100 Frauen im erwerbsfähigen Alter im Jahr 2022|https://www.karto365.de/hosting/rest/services/beschq_w_HA2023/MapServer|beschq_w|
|kbetr_ue3_HA2021|Anteil der betreuten Kinder zwischen 3 und 6 Jahren in Kindertageseinrichtungen__tagespflege an der Altersgruppe im Jahr 2019 in _, kbetr_ue3_HA2021|https://www.karto365.de/hosting/rest/services/kbetr_ue3_HA2021/MapServer|kbetr_ue3|
|erw_mini_ZA2023|Anteil der ausschließlich geringfügig entlohnten Beschäftigten am Arbeitsort an allen Erwerbstätigen im Jahr 2020 in _%|https://www.karto365.de/hosting/rest/services/erw_mini_ZA2023/MapServer|erw_mini|
|teilz_m_HA2023|Männliche sozialversicherungspflichtig Beschäftigte in Teilzeit am Arbeitsort an den männlichen sozialversicherungspflichtig Beschäftigten im Jahr 2022 in _%|https://www.karto365.de/hosting/rest/services/teilz_m_HA2023/MapServer|teilz_m|
|bev_ue65_HA2023|Anteil der 65_Jährigen und Älteren an der Gesamtbevölkerung im Jahr 2021 in _%|https://www.karto365.de/hosting/rest/services/bev_ue65_HA2023/MapServer|bev_ue65|
|v_harzt_HA2022|Hausärzte__ärztinnen je 100_000 Einwohner__innen im Jahr 2019|https://www.karto365.de/hosting/rest/services/v_harzt_HA2022/MapServer|v_harzt|
|elternv_g_HA2023|Anteil der Kinder_ deren Vater Elterngeld bezogen hat an allen anspruchsbegründeten Kindern im Jahr 2019 in _%|https://www.karto365.de/hosting/rest/services/elternv_g_HA2023/MapServer|elterng_v|
|bquali_unifh_HA2022|Anteil sozialversicherungspflichtig Beschäftigter am Arbeitsort mit einem akademischen Abschluss an allen sozialversicherungspflichtig Beschäftigten im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/bquali_unifh_HA2022/MapServer|bquali_unifh|
|sozsich_HA2021|Anteil der Personen in sozialer Mindestsicherung an allen Einwohnerinnen und Einwohnern im Jahr 2019 in %, sozsich_HA2021|https://www.karto365.de/hosting/rest/services/sozsich_HA2021/MapServer|sozsich|
|p_kh_sm_b|p_kh_sm_b, feature|https://www.karto365.de/hosting/rest/services/p_kh_sm_b/MapServer||
|p_ozmz_oev_r_HA2021|Reisezeit mit dem Öffentlichen Verkehr _ÖV_ zum Stadtzentrum des nächsten Ober_ oder Mittelzentrum 2020 in Minuten, p_ozmz_oev_r_HA2021, Raster|https://www.karto365.de/hosting/rest/services/p_ozmz_oev_r_HA2021/MapServer||
|p_selade_f_HA2023|Mittlere Pkw_Fahrzeit zur nächsten öffentlich zugänglichen Schnellladestation für Elektroautos im Jahr 2023|https://www.karto365.de/hosting/rest/services/p_selade_f_HA2023/MapServer||
|alq_HA2022_2|Arbeitslosenquote bezogen auf alle zivilen Erwerbspersonen im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/alq_HA2022_2/MapServer|alq|
|bev_ausl_ZA2022|Anteil der Ausländer__innen an der Gesamtbevölkerung im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/bev_ausl_ZA2022/MapServer|bev_ausl|
|bev_entw_HA2023|Gemittelte Entwicklung der Bevölkerungszahl zwischen 2016 und 2021 pro Jahr in _%|https://www.karto365.de/hosting/rest/services/bev_entw_HA2023/MapServer|bev_entw|
|pfl_geld_HA2021|Anteil der Pflegegeldempfänger__innen im Jahr 2017 an den Pflegebedürftigen insgesamt in _, pfl_geld_HA2021|https://www.karto365.de/hosting/rest/services/pfl_geld_HA2021/MapServer|pfl_geld|
|oenv_HA2021|Anteil der Bevölkerung_ die in maximal 600 m bzw_ bei Bahnhöfen 1_200 m Luftlinienentfernung um eine Haltestelle mit mindestens 20 Abfahrten im ÖV am Tag wohnt_ im Jahr 2020 in %, oenv_HA2021|https://www.karto365.de/hosting/rest/services/oenv_HA2021/MapServer|oenv|
|beschq_m_HA2021|Sozialversicherungspflichtig beschäftigte Männer am Wohnort je 100 Männer im erwerbsfähigen Alter im Jahr 2020, beschq_m_HA2021|https://www.karto365.de/hosting/rest/services/beschq_m_HA2021/MapServer|beschq_m|
|pfl_geld_ZA2022|Anteil der Pflegegeldempfänger__innen im Jahr 2019 an den Pflegebedürftigen insgesamt in _|https://www.karto365.de/hosting/rest/services/pfl_geld_ZA2022/MapServer|pfl_geld|
|p_grunds_b|p_grunds_b, feature|https://www.karto365.de/hosting/rest/services/p_grunds_b/MapServer||
|straft_HA2021|Straftaten insgesamt pro 100_000 Einwohner__innen im Jahr 2020, straft_HA2021|https://www.karto365.de/hosting/rest/services/straft_HA2021/MapServer|straft|
|luftrtng_a|Erreichbarkeit durch Luftrettung während des Tages im Jahr 2016 in Minuten, luftrtng, K36, Raster|https://www.karto365.de/hosting/rest/services/luftrtng_a/MapServer||
|p_apo_a|Pkw_Fahrzeit zum nächsten öffentlichen Apotheke im Jahr 2013 in Minuten, K35, p_apo_a|https://www.karto365.de/hosting/rest/services/p_apo_a/MapServer||
|p_poli_a|Pkw_Fahrzeit von der nächsten Polizeidienststelle im Jahr 2014 in Minuten, K50, p_poli_a|https://www.karto365.de/hosting/rest/services/p_poli_a/MapServer||
|VG250_v_lte_Grenzen|VG250_v_lte_Grenzen|https://www.karto365.de/hosting/rest/services/VG250_v_lte_Grenzen/MapServer||
|pfl_ambu_ZA2022|Anteil der Pflegebedürftigen in ambulanter Pflege an den Pflegebedürftigen insgesamt im Jahr 2019 in _|https://www.karto365.de/hosting/rest/services/pfl_ambu_ZA2022/MapServer|pfl_ambu|
|VG250_Kreise1219_Punkt| tahoma 10 schwarz, zuerst features in punkte; Beste Platzierung 214|https://www.karto365.de/hosting/rest/services/VG250_Kreise1219_Punkt/MapServer||
|v_breitb50_HA2022|Anteil der Haushalte_ die mit einer Internetgeschwindigkeit von mindestens 50 Mbit_s versorgt werden können_ im Juni 2021 in _|https://www.karto365.de/hosting/rest/services/v_breitb50_HA2022/MapServer|v_breitb50|
|fl_wald_HA2021|Anteil der Waldfläche an der Gesamtfläche im Jahr 2019 in %, fl_wald_HA2021|https://www.karto365.de/hosting/rest/services/fl_wald_HA2021/MapServer|fl_wald|
|bev_entw_wms|Gemittelte Entwicklung der Bevölkerungszahl zwischen 2015 und 2020 pro Jahr in _|https://www.karto365.de/hosting/rest/services/bev_entw_wms/MapServer|bev_entw|
|wohn_MFH_HA2021|Fertiggestellte Wohnungen in neuen Mehrfamilienhäusern je 10_000 Einwohner__innen im Jahr 2019, wohn_MFH_HA2021|https://www.karto365.de/hosting/rest/services/wohn_MFH_HA2021/MapServer|wohn_MFH|
|erw_wachs_HA2021|Gemittelte Entwicklung der Erwerbstätigenzahl am Arbeitsort von 2008 bis 2018 pro Jahr in %, erw_wachs_HA2021|https://www.karto365.de/hosting/rest/services/erw_wachs_HA2021/MapServer|erw_wachs|
|wahl_beteil_HA2022|Bundestagswahlbeteiligung 2021 in Kreisen in _|https://www.karto365.de/hosting/rest/services/wahl_beteil_HA2022/MapServer|wahl_beteil|
|p_hbad_r_HA2022|Pkw_Fahrzeit zum nächsten Hallenband im Jahr 2020 in Minuten|https://www.karto365.de/hosting/rest/services/p_hbad_r_HA2022/MapServer||
|schule_oabschl_HA2021|Anteil der Schulabgänger__innen ohne Hauptschulabschluss an allen Schulabgänger__innen allgemeinbildender Schulen im Jahr 2019 in %, schule_oabschl_HA2021|https://www.karto365.de/hosting/rest/services/schule_oabschl_HA2021/MapServer|schule_oabschl|
|wohn_EZFH_HA2023|Fertiggestellte Wohnungen in neuen Ein_ und Zweifamilienhäusern je 10_000 Einwohner__innen im Jahr 2021|https://www.karto365.de/hosting/rest/services/wohn_EZFH_HA2023/MapServer|wohn_EZFH|
|alq_HA2022|Arbeitslosenquote bezogen auf alle zivilen Erwerbspersonen im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/alq_HA2022/MapServer|alq|
|heiz_wohn_HA2022|Anteil fertiggestellter Wohnungen mit primär erneuerbarer Heizenergie an allen errichteten Wohnungen in neuen Wohngebäuden im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/heiz_wohn_HA2022/MapServer|heiz_wohn|
|einbr_HA2021|Fälle von Wohnungseinbruchdiebstahl pro 100_000 Einwohner__innen im Jahr 2020, einbr_HA2021|https://www.karto365.de/hosting/rest/services/einbr_HA2021/MapServer|einbr|
|erw_bip_ZA2023|Bruttoinlandsprodukt je erwerbstätige Person im Jahr 2020 in 1_000 €|https://www.karto365.de/hosting/rest/services/erw_bip_ZA2023/MapServer|erw_bip|
|pfl_ambu_HA2021|Anteil der Pflegebedürftigen in ambulanter Pflege im Jahr 2017 an den Pflegebedürftigen insgesamt in %, pfl_ambu_HA2021|https://www.karto365.de/hosting/rest/services/pfl_ambu_HA2021/MapServer|pfl_ambu|
|teilz_m_HA2021|Männliche sozialversicherungspflichtig Beschäftigte in Teilzeit am Arbeitsort je 100 männliche Einwohner im erwerbsfähigen Alter im Jahr 2020, teilz_m_HA2021|https://www.karto365.de/hosting/rest/services/teilz_m_HA2021/MapServer|teilz_m|
|grusi_ZA2023|Anteil der Bevölkerung mit Grundsicherung im Alter an den 65_Jährigen und Älteren im Jahr 2021 in _|https://www.karto365.de/hosting/rest/services/grusi_ZA2023/MapServer|grusi|
|erw_minineben_HA2021|Anteil der geringfügig entlohnten Beschäftigten im Nebenjob am Arbeitsort an allen Erwerbstätigen 2018 in %, erw_minineben_HA2021|https://www.karto365.de/hosting/rest/services/erw_minineben_HA2021/MapServer|erw_minineben|
|bev_binw_HA2021|Saldo der Binnenwanderungen pro 10_000 Einwohner__innen im Jahr 2019; bev_binw_HA2021|https://www.karto365.de/hosting/rest/services/bev_binw_HA2021/MapServer|bev_binw|
|kbetr_ue6_HA2021|Anteil der betreuten Kinder ab 6 bis unter 11 Jahren in Kindertageseinrichtungen__tagespflege an der Altersgruppe im Jahr 2019 in %, kbetr_ue6_HA2021|https://www.karto365.de/hosting/rest/services/kbetr_ue6_HA2021/MapServer|kbetr_ue6|
|hh_veink_ZA2023|Verfügbares Einkommen privater Haushalte je Einwohner__in im Jahr 2020 in 1_000 €|https://www.karto365.de/hosting/rest/services/hh_veink_ZA2023/MapServer|hh_veink|
|kbtr_pers_ZA2022|Plätze in Kindertageseinrichtungen je pädagogisch tätige Person im Jahr 2021|https://www.karto365.de/hosting/rest/services/kbtr_pers_ZA2022/MapServer|kbtr_pers|
|erw_mini_HA2021|Anteil der ausschließlich geringfügig entlohnten Beschäftigten am Arbeitsort an allen Erwerbstätigen 2018 in %, erw_mini_HA2021|https://www.karto365.de/hosting/rest/services/erw_mini_HA2021/MapServer|erw_mini|
|v_breitb1000_HA2021|Anteil der Haushalte, die mit einer Internetgeschwindigkeit von mindestens 1000 Mbit/s versorgt werden können im Jahr 2020 in %|https://www.karto365.de/hosting/rest/services/v_breitb1000_HA2021/MapServer|v_breitb1000|
|p_ozmz_b|Durchschnittliche bevölkerungsgewichtete Pkw-Fahrzeit zum Stadtzentrum des nächst_en Ober- oder Mittelzentrum 2019 in Minuten, K29, p_ozmz|https://www.karto365.de/hosting/rest/services/p_ozmz_b/MapServer||
|schulden_HA2021|Anteil überschuldeter Personen über 18 Jahren an der Altersgruppe im Jahr 2020 in %, HA2021|https://www.karto365.de/hosting/rest/services/schulden_HA2021/MapServer|schulden|
|erw_minineben_ZA2022|Anteil der geringfügig entlohnten Beschäftigten im Nebenjob am Arbeitsort an allen Erwerbstätigen im Jahr 2019 in _|https://www.karto365.de/hosting/rest/services/erw_minineben_ZA2022/MapServer|erw_minineben|
|p_freibad_f_HA2022|feature abfrage layer für p_freibad|https://www.karto365.de/hosting/rest/services/p_freibad_f_HA2022/MapServer||
|bev_u18_za2022|Anteil der unter 18_Jährigen an der Gesamtbevölkerung im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/bev_u18_za2022/MapServer|bev_u18|
|bquali_unifh_HA2021|Anteil sozialversicherungspflichtig Beschäftigter am Arbeitsort mit einem akademischen Abschluss an allen sozialversicherungspflichtig Beschäftigten im Jahr 2020 in %, bquali_unifh_HA2021|https://www.karto365.de/hosting/rest/services/bquali_unifh_HA2021/MapServer|bquali_unifh|
|fl_suv_HA2021|Anteil der Siedlungs_ und Verkehrsfläche an der Gesamtfläche im Jahr 2019 in %, fl_suv_HA2021|https://www.karto365.de/hosting/rest/services/fl_suv_HA2021/MapServer|fl_suv|
|erw_bip_ZA2022|Bruttoinlandsprodukt je erwerbstätige Person im Jahr 2019 in 1_000 €|https://www.karto365.de/hosting/rest/services/erw_bip_ZA2022/MapServer|erw_bip|
|straft_HA2022|Straftaten insgesamt pro 100_000 Einwohner__innen im Jahr 2021|https://www.karto365.de/hosting/rest/services/straft_HA2022/MapServer|straft|
|elterng_v_HA2021|Anteil der Kinder_ für die mindestens ein männlicher Leistungsbezieher Elterngeld erhalten hat_ an allen anspruchsbegründenden Kindern im Jahr 2017 in %, elterng_v_HA2021|https://www.karto365.de/hosting/rest/services/elterng_v_HA2021/MapServer|elterng_v|
|elterng_v_HA2023|Anteil der Kinder_ deren Vater Elterngeld bezogen hat an allen anspruchsbegründeten Kindern im Jahr 2019 in _%|https://www.karto365.de/hosting/rest/services/elterng_v_HA2023/MapServer|elterng_v|
|teilz_insg_HA2021|Anteil der sozialversicherungspflichtig Beschäftigten in Teilzeit am Arbeitsort an den sozialversicherungspflichtig Beschäftigten im Jahr 2020 in %, teilz_insg_HA2021|https://www.karto365.de/hosting/rest/services/teilz_insg_HA2021/MapServer|teilz_insg|
|elade_ZA2023|Öffentlich zugängliche Ladepunkte für Elektrofahrzeuge im Jahr 2022 je 100_000 Einwohner__innen|https://www.karto365.de/hosting/rest/services/elade_ZA2023/MapServer|elade|
|VG250_LAN1217_grenzen|VG250 Grenzen Länder 1217|https://www.karto365.de/hosting/rest/services/VG250_LAN1217_grenzen/MapServer||
|p_sek_2_a|Pkw_Fahrzeit zur nächsten Schule der Sekundarstufe II im Jahr 2015_2016_2017 in Minuten, K42, p_sek_2_a|https://www.karto365.de/hosting/rest/services/p_sek_2_a/MapServer||
|p_grunds_a|Pkw_Fahrzeit zur nächsten Grundschule im Jahr 2015_16_17 in Minuten, K40, p_grunds|https://www.karto365.de/hosting/rest/services/p_grunds_a/MapServer||
|alq_HA2021|Arbeitslosenquote bezogen auf alle zivilen Erwerbspersonen im Jahr 2020 in %, alq_HA2021|https://www.karto365.de/hosting/rest/services/alq_HA2021/MapServer|alq|
|pendel_b_HA2022|Pendlerverflechtungen zwischen Gemeindeverbänden nach Anzahl der Pendler im Jahr 2020|https://www.karto365.de/hosting/rest/services/pendel_b_HA2022/MapServer|Pendler202|
|oenv_wms|Anteil der Bevölkerung_ die in maximal 600 m bzw_ bei Bahnhöfen 1_200 m Luftlinienentfernung um eine Haltestelle mit mindestens 20 Abfahrten im ÖV am Tag wohnt_ im Jahr 2020 in _|https://www.karto365.de/hosting/rest/services/oenv_wms/MapServer|oenv|
|kbetr_u3_HA2021|Anteil der betreuten Kinder unter 3 Jahren in Kindertageseinrichtungen__tagespflege an der Altersgruppe im Jahr 2019 in %, kbetr_u3_HA2021|https://www.karto365.de/hosting/rest/services/kbetr_u3_HA2021/MapServer|kbetr_u3|
|grusi_HA2021|Anteil der Bevölkerung mit Grundsicherung im Alter an den 65_Jährigen und Älteren 2020 in _, grusi_HA2021|https://www.karto365.de/hosting/rest/services/grusi_HA2021/MapServer|grusi|
|p_markt_a|Pkw_Fahrzeit zum nächsten Supermarkt oder Discounter im Jahr 2017 in Minuten, K30, p_markt|https://www.karto365.de/hosting/rest/services/p_markt_a/MapServer||
|bev_ausw_HA2021|Saldo der Außenwanderungen pro 10_000 Einwohner__innen im Jahr 2019; bev_ausw_HA2021|https://www.karto365.de/hosting/rest/services/bev_ausw_HA2021/MapServer|bev_ausw|
|preis_baul_wms|Baulandpreise für Eigenheime im Jahr 2020 in € je m²|https://www.karto365.de/hosting/rest/services/preis_baul_wms/MapServer||
|erw_wachs_ZA2022|Gemittelte Entwicklung der Erwerbstätigenzahl am Arbeitsort von 2009 bis 2019 pro Jahr in _|https://www.karto365.de/hosting/rest/services/erw_wachs_ZA2022/MapServer|erw_wachs|
|v_lte_HA2021|Mobile Breitbandverfügbarkeit mit LTE ab 2Mbit_s in _ der Fläche im Jahr 2020, v_lte_HA2021|https://www.karto365.de/hosting/rest/services/v_lte_HA2021/MapServer|anteil_fla|
|preis_baul_ZA2022|Baulandpreise für Eigenheime im Jahr 2020 in € je m²|https://www.karto365.de/hosting/rest/services/preis_baul_ZA2022/MapServer||
|bev_dicht_ZA2022|Einwohner__innen je km² im Jahr 2020|https://www.karto365.de/hosting/rest/services/bev_dicht_ZA2022/MapServer|bev_dicht|
|v_breitb_ZA2021|Anteil der Haushalte_ die mit einer Internetgeschwindigkeit von mindestens 50 Mbit_s versorgt werden können im Jahr 2019 in %, K25, v_breitb_ZA2021|https://www.karto365.de/hosting/rest/services/v_breitb_ZA2021/MapServer|v_breitb|
|pfl_stat_HA2021|Anteil der Pflegebedürftigen in stationärer Pflege im Jahr 2017 an den Pflegebedürftigen insgesamt in _, pfl_stat_HA2021|https://www.karto365.de/hosting/rest/services/pfl_stat_HA2021/MapServer|pfl_stat|




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
