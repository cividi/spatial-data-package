# (Geo) Spatial Data Package Specification

This document outlines a (geo) spatial data package [profile](https://specs.frictionlessdata.io/profiles/) for [JSON-based](https://en.wikipedia.org/wiki/JSON) [Frictionless Data Packages](https://specs.frictionlessdata.io/data-package/), also called a Snapshot.

It follows the [Frictionless Data Specification](https://frictionlessdata.io) and provides a simple, human-readable way of defining map views with [styled](https://github.com/cividi/simplestyle-extended-spec) [GeoJSON](https://geojson.org) documents.

## Usage

### Editor Linting

To add linting support to your editor (e.g. VS Code has built in support) you can check directly against the [JSON schema `schema/snapshot.json`](schema/snapshot.json).

Simply add
```json
"$schema": "https://raw.githubusercontent.com/cividi/spatial-data-package-spec/main/schemas/snapshot.json"
```
to your data package and enable linting support for JSON schemas.

### Validation with Frictionless Tools

Make sure to include 
```json
"profile": "https://raw.githubusercontent.com/cividi/spatial-data-package-spec/main/schemas/snapshot.json"
```
in your Snapshot file. You can then use Frictionless Tools, e.g. data-cli to validate the schema and tabular data:
```sh
data validate . # Looks for datapackage.json in current folder
```

## Detailed Data Package Structure

In addition to the basic structure of a Data Package (cf. [Frictionless Data Package](https://specs.frictionlessdata.io/data-package/)) requiring

1. a `name` and
1. a `resource`

a Snapshots (Spatial Data Package) also require (technical details see below)

1. a `view` – Defining how the map can be rendered
1. a `source` – Listing data sources
1. `resource`s added to a `view` to be either
   - a simple-style GeoJSON – supporting Lines, Polygons, Markers
   - a simple-style-extended GeoJSON – supporting Circles
   - a mapbox style URL – for a background map
   - a [WMS](https://www.ogc.org/standards/wms) layer

### Examples

A valid example can be found in [`datapackage.json`](datapackage.json).

### Resources

An array of resources with links to or the data itself. Includes a resource `name` (unique inside the datapackage), a `title` and a `description` as well as a `mediatype`. At least one of these should be a geojson or of some other spatial type.

Possible Mediatypes

- `application/geo+json`: GeoJSON with [Mapbox Simple Styles](https://github.com/mapbox/simplestyle-spec)
- `application/vnd.simplestyle-extended`: GeoJSON with [Extended Simple Styles](https://github.com/cividi/simplestyle-extended-spec)
- `application/vnd.mapbox-vector-tile`: Mapbox URI for styled vector tiles
- `application/vnd.wms`: WMS URI and parameters (see example below)

### Views

An array of rendered versions of the data resources.

Contains extra metadata used for rendering all or a subset of the packages resources.

For a map view compatible with the [Gemeindescan-Project](https://github.com/cividi/spatial-data-package-platform) use the following fields and resources that are either Mapbox Style URI or a geojson that includes styles as defined by the [Simplestyle Spec](https://github.com/mapbox/simplestyle-spec) or [Extended Simplestyle Spec](https://github.com/cividitech/simplestyle-extended-spec).

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
      "name": "wms-bauzonen",
      "title": "Geo Admin: Bauzonen Schweiz (harmonisiert)",
      "mediatype": "application/vnd.wms",
      "path": "https://wms.geo.admin.ch",
      "parameters": {
        "format": "image/png",
        "transparent": true,
        "layers": "ch.are.bauzonen",
        "opacity": 0.5
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
- `specType`: currently only `gemeindescanSnapshot` is supported here
- `spec`: Metainformation to render a full map view
  - `title`: Title of the View
  - `description`: Description of the View 
  - `bounds`: array of bounding box support geopoints, denoted as Geo-URI as defined by [RFC5870](https://tools.ietf.org/html/rfc5870), latitude first
  - `legend`: Legend entries for the view
    - `label`: legend entry text
    - `shape`: one of square, circle or line
    - `size`: relative size in percent, either size of the sqaure or circle or line thickness
    - `primary`: can be used for simplifying the legend to less elements in size constraint contexts
    - `fillColor`: fill/main color
    - `fillOpacity`: opacity value
    - `strokeColor`: stroke color
    - `strokeOpacity`: stroke opacity
    - `strokeWidth`: stroke width

### Licenses and Sources

- `Licenses:` *optional* Defines the details of the licenses
- `Sources`: Sources that have been used

### Contributors and Maintainers

Each represents an array of people and institutions, companies involved in creating and maintaining the datapackage. 

## Unit testing

To validate [`datapackage.json`](datapackage.json) against the current schema, run

```sh
npm install
npm run test
```

## Sample Data

Data comes from open data sources via the [cividi project](https://cividi.ch).

## License

This Data Package is licensed under the [ODC Public Domain Dedication and Licence (PDDL)](LICENSE).
