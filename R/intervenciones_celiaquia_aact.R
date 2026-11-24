#' Ensayos clinicos sobre celiaquia por tipo de intervencion
#'
#' Consulta la base de datos AACT para obtener el numero
#' de ensayos clinicos sobre la enfermedad celiaca
#' segun el tipo de intervencion.
#'
#' @return Un data.frame con el tipo de intervencion
#' y el numero de ensayos clinicos.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' intervenciones_celiaquia_aact()
#' }
intervenciones_celiaquia_aact <- function() {

  usuario <- Sys.getenv("AACT_USER")
  clave <- Sys.getenv("AACT_PASSWORD")

  if (usuario == "" || clave == "") {
    stop("Configura AACT_USER y AACT_PASSWORD en tu archivo .Renviron.")
  }

  con <- DBI::dbConnect(
    RPostgres::Postgres(),
    dbname = "aact",
    host = "aact-db.ctti-clinicaltrials.org",
    port = 5432,
    user = usuario,
    password = clave
  )

  on.exit(DBI::dbDisconnect(con), add = TRUE)
  consulta_sql <- "
  SELECT
    i.intervention_type AS tipo_intervencion,
      COUNT(DISTINCT s.nct_id) AS num_ensayos
    FROM ctgov.studies s
    INNER JOIN ctgov.interventions i
      ON s.nct_id = i.nct_id
    INNER JOIN ctgov.conditions c
      ON s.nct_id = c.nct_id
    WHERE LOWER(c.name) LIKE '%celiac%'
    GROUP BY i.intervention_type
    ORDER BY num_ensayos DESC;
  "
  DBI::dbGetQuery(con, consulta_sql)
}
