# Regionalatlas.DefaultApi

All URIs are relative to *https://www.gis-idmz.nrw.de/arcgis/rest/services/stba/regionalatlas/MapServer/dynamicLayer*

Method | HTTP request | Description
------------- | ------------- | -------------
[**query**](DefaultApi.md#query) | **GET** /query | query


# **query**
> {str: (bool, date, datetime, dict, float, int, list, str, none_type)} query(f, return_geometry, spatial_rel, where)

query

Die gewünschten Daten lassen sich über GET-Parameter im Query-String spezifizieren. 

### Example


```python
import time
from deutschland import Regionalatlas
from deutschland.Regionalatlas.api import default_api
from pprint import pprint
# Defining the host is optional and defaults to https://www.gis-idmz.nrw.de/arcgis/rest/services/stba/regionalatlas/MapServer/dynamicLayer
# See configuration.py for a list of all supported configuration parameters.
configuration = Regionalatlas.Configuration(
    host = "https://www.gis-idmz.nrw.de/arcgis/rest/services/stba/regionalatlas/MapServer/dynamicLayer"
)


# Enter a context with an instance of the API client
with Regionalatlas.ApiClient() as api_client:
    # Create an instance of the API class
    api_instance = default_api.DefaultApi(api_client)
    f = "json" # str | Output-Format (z.B. 'json' oder 'html').
    return_geometry = False # bool | Boolsche Angabe, ob Angaben zur Geometrie gesendet werden sollen (z.B. 'false').
    spatial_rel = "esriSpatialRelIntersects" # str | spational relation (z.B. 'esriSpatialRelIntersects').
    where = "1%3D1" # str | Spezifikation einer gewünschten Teilmenge der Daten (z.B.'1=1'' für alle Daten oder 'ags2 = 'DG' and jahr2 =  2020').
    out_fields = "*" # str | Auszugebende Variablen/fields (z.B. '*'). (optional)

    # example passing only required values which don't have defaults set
    try:
        # query
        api_response = api_instance.query(f, return_geometry, spatial_rel, where)
        pprint(api_response)
    except Regionalatlas.ApiException as e:
        print("Exception when calling DefaultApi->query: %s\n" % e)

    # example passing only required values which don't have defaults set
    # and optional values
    try:
        # query
        api_response = api_instance.query(f, return_geometry, spatial_rel, where, out_fields=out_fields)
        pprint(api_response)
    except Regionalatlas.ApiException as e:
        print("Exception when calling DefaultApi->query: %s\n" % e)
```


### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **f** | **str**| Output-Format (z.B. &#39;json&#39; oder &#39;html&#39;). |
 **return_geometry** | **bool**| Boolsche Angabe, ob Angaben zur Geometrie gesendet werden sollen (z.B. &#39;false&#39;). |
 **spatial_rel** | **str**| spational relation (z.B. &#39;esriSpatialRelIntersects&#39;). |
 **where** | **str**| Spezifikation einer gewünschten Teilmenge der Daten (z.B.&#39;1&#x3D;1&#39;&#39; für alle Daten oder &#39;ags2 &#x3D; &#39;DG&#39; and jahr2 &#x3D;  2020&#39;). |
 **layer** | **str**| Komplexer Parameter, der im JSON-Format Details der Anfrage spezifiziert. In der Regel stellt enthält der layer-Parameter ein Objekt (in geschweiften Klammern), das seinerseits ein Objekt namens &#39;source&#39; enthält. Das source-Objekt wiederum enthält ein Objekt, das zum einen das Objekt &#39;dataSource&#39; und zum anderen ein Datum namens &#39;type&#39; mit dem Wert &#39;dataLayer&#39; enthält. In dataSource wird die gewünschte Tabelle spezifiziert (z.B. für Angaben zur Bevölkerungsdichte &#39;ai002_1_5&#39;) - im Folgenden mit dem Platzhalter *tableName* gekennzeichnet.  dataSource kann unterschiedlich aufgebaut sein und enthält entweder (a) Daten namens &#39;dataSourceName&#39; (mit einem Wert wie z.B. &#39;regionalatlas.*tableName*&#39;), &#39;workspaceId&#39; (z.B.  &#39;gdb&#39;) und &#39;type&#39; (z.B. &#39;table&#39;) oder (b) Daten namens &#39;geometryType&#39; (z.B. &#39;esriGeometryPolygon&#39;), &#39;workspaceId&#39; (z.B. &#39;gdb&#39;), &#39;query&#39; (mit einem SQL-Query, z.B. &#39;SELECT * FROM verwaltungsgrenzen_gesamt LEFT OUTER JOIN *tableName* ON ags &#x3D; ags2 and jahr &#x3D; jahr2 WHERE typ &#x3D; 3 AND jahr &#x3D; 2020 AND (jahr2 &#x3D; 2020 OR jahr2 IS NULL)&#39;), &#39;oidFields&#39; (z.B. &#39;id&#39;), &#39;spatialReference&#39; (mit einem Objekt, das wiederum das Datum &#39;wkid&#39; mit einem Wert wie 25832 umfasst), und &#39;type&#39;:&#39;queryTable&#39;.    Der SQL-Query dürfte für Nutzer*innen des Regionalatlas Deutschland weitgehend selbsterklärend sein, wobei man wissen muss dass die Variable *typ* die gewünschte regionale Ebene spezifiziert&amp;#58;  - 1&#x3D;Bundesländer,   - 2&#x3D;Regierungsbezirke und Statistische Regionen,   - 3&#x3D;Kreise und kreisfreie Städte,  - 5&#x3D;Gemeinden/Verbandsgemeinde.   Gültige Einträge für die *tableName* werden im Folgenden auszugsweise dargestellt (jeweils mit den enthaltenen Variablen/fields)   - Bevölkerungsdichte&amp;#58; ai002_1_5  - - ai0201&amp;#58; Bevölkerungsdichte (EW je qkm)  - - ai0202&amp;#58; Bevölkerungsentwicklung im Jahr je 10.000 EW  - - ai0208&amp;#58; Anteil der ausländischen Bevölkerung an der Gesamtbevölkerung  - - ai0209&amp;#58; Lebendgeborene je 10.000 EW  - - ai0210&amp;#58; Gestorbene je 10.000 EW  - - ai0211&amp;#58; Geburten-/Gestorbenenüberschuss je 10.000 EW  - - ai0212&amp;#58; Wanderungssaldo je 10.000 EW   - Altersdurchschnitt&amp;#58; ai002_4_5   - - ai0218&amp;#58; Durchschnittsalter der Bevölkerung   - - ai0219&amp;#58; das Durchschnittsalter der Mutter bei der Geburt des 1. Kindes)   - Arbeitslosenquote&amp;#58; ai008_1_5   - - ai0801&amp;#58; Arbeitslosenquote  - - ai0806&amp;#58; Anteil Arbeitslose 15-24 Jahre an Arbeitslosen insgesamt  - - ai0807&amp;#58; Anteil Arbeitslose 55-64 Jahre an Arbeitslosen insgesamt  - - ai0808&amp;#58; Anteil Langzeitarbeitslose an Arbeitslosen insgesamt  - - ai0809&amp;#58; Anteil der ausl. Arbeitslosen an Arbeitslosen insgesamt    - Verfügbares Einkommen je EW&amp;#58; ai_s_01  - SGB-II-Quote&amp;#58; ai_s_04  - BIP je Erwerbstätigem&amp;#58; ai017_1  - Wahlergebnisse Bundestagswahl&amp;#58; ai005&#39;  | defaults to "%7B%22source%22%3A%7B%22dataSource%22%3A%7B%22geometryType%22%3A%22esriGeometryPolygon%22%2C%22workspaceId%22%3A%22gdb%22%2C%22query%22%3A%22SELECT%20*%20FROM%20verwaltungsgrenzen_gesamt%20LEFT%20OUTER%20JOIN%20ai002_1_5%20ON%20ags%20%3D%20ags2%20and%20jahr%20%3D%20jahr2%20WHERE%20typ%20%3D%201%20AND%20jahr%20%3D%202020%20AND%20(jahr2%20%3D%202020%20OR%20jahr2%20IS%20NULL)%22%2C%22oidFields%22%3A%22id%22%2C%22spatialReference%22%3A%7B%22wkid%22%3A25832%7D%2C%22type%22%3A%22queryTable%22%7D%2C%22type%22%3A%22dataLayer%22%7D%7D"
 **out_fields** | **str**| Auszugebende Variablen/fields (z.B. &#39;*&#39;). | [optional]

### Return type

**{str: (bool, date, datetime, dict, float, int, list, str, none_type)}**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json


### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | OK |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

