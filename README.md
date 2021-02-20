# Geospatial Datapackage Specification

This is an example Geospatial Data Package.

This datapackage follows the [Frictionless Data Specification](https://frictionlessdata.io) and defines a way of specifying a simple map view based on geojsons as a data resource to the package.

## Datapackage Structure

### Licenses and Sources

- `Licenses:` Defines the details of the licenses
- `Sources`: Sources that have been used as input

### Resources

An array of resources with links to or the data itself. Includes a resource `name` (unique inside the datapackage), a `title` and a `description` as well as a `mediatype`. At least one of these should be a geojson or of some other spatial type.

Possible Mediatypes

- `application/geo+json`: GeoJSON with [Mapbox Simple Styles](https://github.com/mapbox/simplestyle-spec)
- `application/vnd.simplestyle-extended`: GeoJSON with [Extended Simple Styles](https://github.com/cividitech/simplestyle-extended-spec)
- `application/vnd.mapbox-vector-tile`: Mapbox URI for styled vector tiles

### Views

An array of rendered versions of the data resources.

Contains extra metadata used for rendering all or a subset of the packages resources.

For a map view compatible with the [Gemeindescan-Project](https://bitbucket.org/cividi/gemeindescan-webui) use the following fields and resources that are either Mapbox Style URI or a geojson that includes styles as defined by the [Simplestyle Spec](https://github.com/mapbox/simplestyle-spec) or [Extended Simplestyle Spec](https://github.com/cividitech/simplestyle-extended-spec).

```json
{
  "name": "package-name",
  "profile": "https://raw.githubusercontent.com/cividi/spatial-data-package-spec/main/schemas/snapshot.json",
  "views":[
    {
      "name": "mapview",
      "resources": [
          "geojson-resource-name-1",
          "mapbox-resource-name"
      ],
      "specType": "gemeindescanSnapshot",
      "spec": {
        "title": "Snapshot Title",
        "description": "Snapshot Description",
        "bounds": [
            "geo:47.43668029143545,9.355459213256836",
            "geo:47.483104811626674,9.424123764038086"
        ],
        "legend": [{
          "label": "Legend text",
          "shape": "square",
          "size": 0.5,
          "primary": true,
          "fillColor": "#ffffff",
          "fillOpacity": 0.2,
          "strokeColor": "#000000",
          "strokeOpacity": 1,
          "strokeWidth": 1
        }]
      }
    }
  ],
  "resources":[
    {
      "name": "geojson-resource-name-1",
      "mediatype": "application/vnd.simplestyle-extended",
      "data": {
        "type": "FeatureCollection",
        "features": [{
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [9.38771, 47.46058]
          },
          "properties": {
            "fid": 1,
            "radius": 200,
            "fillColor": "red",
            "fillOpacity": 0.2,
            "title": "Centerpoint",
            "color": "red",
            "weight": 1,
            "opacity": 0.8
          }
        }]
      }
    },
    {
      "path": "mapbox://styles/gemeindescan/ckc4sha4310d21iszp8ri17u2",
      "mediatype": "application/vnd.mapbox-vector-tile",
      "name": "mapbox-resource-name"
    }
  ]
}
```

- `name`: name of the view (unique within datapackage)
- `resources`: an array of resource-names (see above) in order of rendering, first will be lowest in render order
- `specType`: currently only `map` is supported here
- `spec`: Metainformation to render a full map view
  - `title`: Title of the View
  - `description`: Description of the View 
  - `bounds`: array of bounding box support geopoints, denoted as Geo-URI as defined by [RFC5870](https://tools.ietf.org/html/rfc5870), latitude first
  - `legend`: Legend entries for the view
    - `shape`: one of square, circle or line
    - `size`: relative size in percent, either size of the sqaure or circle or line thickness
    - `color`: fill/main color
    - `opacity`: opacity value
    - `label`: legend entry text
    - `primary`: can be used for simplifying the legend to less elements in size constraint contexts

### Contributors and Maintainers

Each represents an array of people and institutions, companies involved in creating and maintaining the datapackage. 

## Sample Data

Data comes from open data sources via the [CIVIDI project](https://cividi.ch).

## License

This Data Package is licensed under the [ODC Public Domain Dedication and Licence (PDDL)](LICENSE).
