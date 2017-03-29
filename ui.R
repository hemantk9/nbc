## app.R ##
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "NBC-Forecasting"),
  dashboardSidebar(sidebarMenu(
    menuItem("Home", tabName = "home", icon = icon("dashboard")),
    menuItem("Accounts", tabName = "accounts", icon = icon("dashboard")),
    menuItem("Decay Curves", tabName = "decaycurves", icon = icon("dashboard")),
    menuItem("Promotions", tabName = "promotions", icon = icon("dashboard")),
    menuItem("Products", tabName = "products", icon = icon("dashboard")),
    menuItem("Average Price", tabName = "avgPrice", icon = icon("dashboard")),
    menuItem("Reports", tabName = "reports", icon = icon("dashboard")),
    menuItem("Settings", tabName = "settings", icon = icon("dashboard")),
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th"))
  )),
  ## Body content
  dashboardBody(
    tabItems(
      # Accounts tab content
      tabItem(tabName = "accounts",
              fluidRow(
                column(3, h2("Accounts")),
                column(3,  selectInput("accountDataset", "", choices = c("target"))),
                style="background:#fff;margin: -25px -15px 15px -15px;"
              ),
              fluidPage(
                #
                navlistPanel(
                  tabPanel("Launch Forecasting Tool",
                           mainPanel(
                             helpText("Note: while the data view will show only the specified",
                                      "number of observations, the summary will still be based",
                                      "on the full dataset."),
                             # Copy the line below to make a text input box
                             textInput("text", label = h5("Director Name"), value = "Enter text..."),
                             textInput("text", label = h5("Sales Rep Name:"), value = "Enter text..."),
                             selectInput("dataset", "Shipment Offset Weeks:", choices = c("rock", "pressure", "cars")),
                             numericInput("obs", "Return Rate offset week:", 10),
                             submitButton("Update"),
                             hr()
                           )
                  ),
                  tabPanel("Edit Shipment Factor", h3("In Progress..."))
                )
                #
              )
      ),
      # Products tab content
      tabItem(tabName = "products",
              fluidRow(
                column(3, h2("Products")),
                column(6,  h4("Synchronize Products")),
                style="background:#fff;margin: -25px -15px 0px -15px;"
              ),
              fluidRow(
              div(class = "ui breadcrumb", 
                  a(class = "section", "Home"), 
                  a(class = "section", "Products")
              )),
              h4("Search"),
              fluidRow(
                box(
                  textInput("text", label = h6("By Word/Phase:", style="margin: 0px;"), value = "Enter text..."),
                  checkboxGroupInput("checkGroup horizontal", label = "", 
                                     choices = list("Limit Search to.." = 1, 
                                                    "By Release Date" = 2, 
                                                    "By Package Description" = 3,
                                                    "By Package Type" = 4),
                                     selected = 1),
                  width=12
                )
              )
              
      ),
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                column(3, h2("Dashboard")),
                style="background:#fff;margin: -25px -15px 15px -15px;"
              ),
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              fluidRow(
                tabBox(
                  title = "First tabBox",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "tabset1", height = "250px",
                  tabPanel("Tab1", "First tab content"),
                  tabPanel("Tab2", "Tab content 2")
                ),
                tabBox(
                  side = "right", height = "250px",
                  selected = "Tab3",
                  tabPanel("Tab1", "Tab content 1"),
                  tabPanel("Tab2", "Tab content 2"),
                  tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
                )
              ),
              fluidRow(
                tabBox(
                  # Title can include an icon
                  title = tagList(shiny::icon("gear"), "tabBox status"),
                  tabPanel("Tab1",
                           "Currently selected tab from first box:",
                           verbatimTextOutput("tabset1Selected")
                  ),
                  tabPanel("Tab2", "Tab content 2")
                )
              )
      )
    )
  )
)