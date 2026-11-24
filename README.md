
# ensayolidia

## Descripción

ensayolidia es un paquete de R desarrollado en el marco
del Máster en Bioestadística de la Universidad Complutense
de Madrid (UCM).

Su objetivo es facilitar la consulta y el análisis de
ensayos clínicos registrados en ClinicalTrials.gov mediante
una conexión remota a la base de datos AACT
(Aggregate Analysis of ClinicalTrials.gov).

El paquete permite realizar consultas SQL sin necesidad
de descargar la base de datos completa.

## Instalación

El paquete puede instalarse desde GitHub mediante:

```r
install.packages("remotes")
remotes::install_github("lidihe01/ensayolidia")
```

Una vez instalado, se carga mediante:

```r
library(ensayolidia)
```

## Configuración de las credenciales

Para utilizar el paquete es necesario disponer de una
cuenta en AACT:

https://aact.ctti-clinicaltrials.org/

Las credenciales deben almacenarse en el archivo
.Renviron. Para abrirlo, ejecutar:

```r
usethis::edit_r_environ()
```

Añadir las siguientes líneas con las credenciales propias:

```text
AACT_USER=tu_usuario
AACT_PASSWORD=tu_contraseña
```

Guardar el archivo y reiniciar la sesión de R.

Por motivos de seguridad, las credenciales no deben
incluirse directamente en el código del paquete ni
publicarse en GitHub.

## Funciones del paquete

### resumen_ensayos_aact()

Permite obtener el número de ensayos clínicos y el
reclutamiento medio por fase clínica para una
determinada patología.

```r
resumen_ensayos_aact("Melanoma")
resumen_ensayos_aact("Celiac Disease")
```

### intervenciones_celiaquia_aact()

Permite analizar la distribución de los ensayos clínicos
sobre la enfermedad celíaca según el tipo de intervención,
como tratamientos farmacológicos, suplementos dietéticos,
intervenciones conductuales o dispositivos médicos.

```r
intervenciones_celiaquia_aact()
```

La función devuelve una tabla con dos variables:

- tipo_intervencion: tipo de intervención.
- num_ensayos: número de ensayos clínicos distintos
  para cada tipo de intervención.

Un mismo ensayo puede pertenecer a varios tipos de
intervención.

## Base de datos y tablas utilizadas

Las consultas se realizan sobre el esquema ctgov
de la base de datos AACT:

- ctgov.studies: información general de los ensayos clínicos.
- ctgov.conditions: patologías estudiadas.
- ctgov.interventions: intervenciones utilizadas.

Las tablas se relacionan mediante el identificador
único de cada ensayo clínico (nct_id).

## Dependencias

- DBI
- RPostgres

## Autoría

Lidia Hernández Torres

Máster en Bioestadística

Universidad Complutense de Madrid
