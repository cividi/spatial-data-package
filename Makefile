# Project : Data Package Makefile
# -----------------------------------------------------------------------------
# Author : Thorben Westerhuys <thorben@cividi.ch>
# -----------------------------------------------------------------------------
# License : GNU General Public License
# -----------------------------------------------------------------------------
# This Data Package is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# The Data Package is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with the Data Package. If not, see <http://www.gnu.org/licenses/>.

GPKG_DIR = process
DATA_DIR = data

all: extract-perimeter
check-only: validate-csv

extract-perimeter:
	ogr2ogr -t_srs "EPSG:4326" $(DATA_DIR)/perimeter.geojson $(GPKG_DIR)/perimeter.gpkg
	ogr2ogr -t_srs "EPSG:4326" $(DATA_DIR)/perimeter.csv $(GPKG_DIR)/perimeter.gpkg

validate-csv:
	goodtables validate datapackage.json
