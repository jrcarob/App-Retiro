library(shiny)

renderInputs <- function(prefix) {
  wellPanel(
    fluidRow(
      column(6,
             sliderInput(paste0(prefix, "_", "n_obs"), "Horizonte temporal (en años):", min = 0, max = 40, value = 20),
             sliderInput(paste0(prefix, "_", "start_capital"), "Capital inicial invertido:", min = 50000, max = 1000000, value = 5000, step = 5000, pre = "EUR ", sep = "."),
             sliderInput(paste0(prefix, "_", "annual_mean_return"), "Retorno anual de la inversión (en %):", min = 0.0, max = 30.0, value = 6.0, step = 0.5),
             sliderInput(paste0(prefix, "_", "annual_ret_std_dev"), "Volatilidad anual de la inversión (en %):", min = 0.0, max = 25.0, value = 5.0, step = 0.1)
      ),
      column(6,
             sliderInput(paste0(prefix, "_", "annual_inflation"), "Inflación anual (en %):", min = 0, max = 20, value = 2, step = 0.1),
             sliderInput(paste0(prefix, "_", "annual_inf_std_dev"), "Volatilidad de la inflación anual (en %):", min = 0.0, max = 5.0, value = 0.5, step = 0.05),
             sliderInput(paste0(prefix, "_", "monthly_withdrawals"), "Retiradas mensuales de capital:", min = 1000, max = 5000, value = 500, step = 500, pre = "EUR ", sep = "."),
             sliderInput(paste0(prefix, "_", "n_sim"), "Número de simulaciones:", min = 0, max = 2000, value = 200)
      )
    ),
    p(actionButton(paste0(prefix, "_", "recalc"),
                   "Rehacer simulación", icon("random")
    ))
  )
}

# Define UI for application that plots random distributions
fluidPage(theme="simplex.min.css",
          tags$style(type="text/css",
                     "label {font-size: 12px;}",
                     ".recalculating {opacity: 1.0;}"
          ),
          
          # Application title
          tags$h2("Jubilación: Simulación Estocástica de inversión de capital con retornos, inflación y retiradas aleatorias"),
          h4("© 2019",
            tags$a(href="https://github.com/jrcarob", "José Rafael Caro Barrera"),
            "como parte del proyecto de tesis:",
            tags$a(href="https://github.com/jrcarob/Congress_Poster", "Demografía y Pensiones: Recursos de Planificación a Largo Plazo
                   "),
            ""),
          p("Aplicación diseñada con fines didácticos."),
          hr(),
          
          fluidRow(
            column(6, tags$h3("Escenario A")),
            column(6, tags$h3("Escenario B (aconsejable simular con la inclusión de la hipoteca inversa)"))
          ),
          fluidRow(
            column(6, renderInputs("a")),
            column(6, renderInputs("b"))
          ),
          fluidRow(
            column(6,
                   plotOutput("a_distPlot", height = "600px")
            ),
            column(6,
                   plotOutput("b_distPlot", height = "600px")
            )
          )
)