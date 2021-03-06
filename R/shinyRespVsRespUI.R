shinyRespVsRespUI <- function () {

  fluidPage(
    sidebarLayout(
      sidebarPanel(
        helpText("Correlate response variables"),
        uiOutput('respUI'),
        selectInput("output_option", label = h3("Generate"),
                    choices = list('Scatter Pairs' = 1, 'Density'=2, 'Waterfall'=3, 'Data'=4),
                    selected = 1),
        h3("Plot Options:"),
        selectInput("tissue_option", label = "Select tissue categorisation",
                    choices = list('Crude' = 'crude', 'CCLE' = 'ccle', 'Eurofins'='eurofins'),
                    selected = 'crude'),
        sliderInput('plot_width', label = 'Control plot width', min=200, max=2000, value=600),
        sliderInput('plot_height', label = 'Control plot height', min=200, max=2000, value=400),
        uiOutput('tissuesUI')
        # submitButton('Submit')
      ),
      uiOutput('resultsUI')


    )
  )
}
