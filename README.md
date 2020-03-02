# Geospatial Datapackage Specification

This is an example Geospatial Data Package.

This datapackage follows the [Frictionless Data Specification](https://frictionlessdata.io) and defines a way of specifying a simple map view based on geojsons as a data resource to the package.

## Datapackage Structure

### Licenses and Sources

- `Licenses:` Defines the details of the licenses
- `Sources`: Sources that have been used as input

### Rersources

An array of resources with links to or the data itself. Includes a resource `name` (unique inside the datapackage), a `title` and a `description` as well as a `mediatype`. At least one of these should be a geojson or of some other spatial type.

### Views

An array of rendered versions of the data resources.

Contains extra metadata used for rendering all or a subset of the packages resources.

For a map view compatible with the [Gemeindescan-Project](https://bitbucket.org/cividi/gemeindescan-webui) use the following fields and resources that are either Mapbox Style URI or a geojson that includes styles as defined by the [Simplestyle Spec](https://github.com/mapbox/simplestyle-spec).

```json
{
      "name": "mapview",
      "resources": [
        "gemeinden-geojson",
        "mb-bg-map"
      ],
      "specType": "map",
      "bounds": [
        "geo:47.43668029143545,9.355459213256836",
        "geo:47.483104811626674,9.424123764038086"
      ]
  }
```

- `name`: name of the view (unique within datapackage)
- `resources`: an array of resource-names (see above) in order of rendering, first will be lowest in render order
- `specType`: currently only `map` is supported here
- `bounds`: array of bounding box support geopoints, denoted as Geo-URI as defined by [RFC5870](https://tools.ietf.org/html/rfc5870), latitude first

### Contributors and Maintainers

Each represents an array of people and institutions, companies involved in creating and maintaining the datapackage. 

## Sample Data

Data comes from open data sources via the [CIVIDI project](https://cividi.ch).

## License

This Data Package is licensed under the [ODC Public Domain Dedication and Licence (PDDL)](LICENSE).
