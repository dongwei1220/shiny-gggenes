###############################################################################
# Author: Wei Dong
# Emial: 1369852697@qq.com
# Github: https://github.com/dongwei1220
# Blog: http://bioinfomics.top/
# Team: https://hiplot.com.cn
# Version: R-4.0.2
# Date: 2020-09-02
###############################################################################
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# install.packages("shiny")
# install.packages("bs4Dash")
# install.packages("DT")
# install.packages("gggenes")
# install.packages("ggsci")

# load required packages
library(shiny)
library(bs4Dash)
library(DT)
library(ggplot2)
library(gggenes)
library(ggsci)

shiny::shinyApp(
  # Define UI for application that draw gene arrow maps
  ui = bs4DashPage(
      old_school = FALSE,
      sidebar_min = TRUE,
      sidebar_collapsed = FALSE,
      #controlbar_collapsed = TRUE,
      #controlbar_overlay = TRUE,
      title = "Shiny gggenes",
      
      #=== 1.bs4DashSidebar ===
      sidebar = bs4DashSidebar(
        skin = "light",
        status = "primary",
        title = "Wei Dong",
        brandColor = "primary",
        url = "http://bioinfomics.top/",
        src = "https://s1.imagehub.cc/images/2020/09/02/avatar.jpg",
        elevation = 3,
        opacity = 0.8,
        
        #=== bs4SidebarMenu ===
        bs4SidebarMenu(
          bs4SidebarHeader("Menus"),
          bs4SidebarMenuItem(
            "Plot",
            tabName = "plot",
            icon = "sitemap"
          ),
          bs4SidebarMenuItem(
            "Gallery",
            tabName = "gallery",
            icon = "photo"
          ),
          bs4SidebarMenuItem(
            "Table",
            tabName = "table",
            icon = "table"
          ),
          br()
        )
      ),
      
      #=== 2.bs4DashNavbar ===
      navbar = bs4DashNavbar(
        skin = "light",
        status = "white",
        border = TRUE,
        sidebarIcon = "bars",
        controlbarIcon = "th",
        fixed = FALSE,
        leftUi = bs4DropdownMenu(
          show = FALSE,
          align = "left",
          status = "warning",
          menuIcon = "envelope-open",
          src = NULL
        ),
        rightUi = bs4DropdownMenu(
          show = FALSE,
          status = "danger",
          src = "https://github.com/dongwei1220",
          bs4DropdownMenuItem(
            message = "message 1",
            from = "Wei Dong",
            src = "https://s1.imagehub.cc/images/2020/09/02/avatar.jpg",
            time = "today",
            status = "danger",
            type = "message"
          )
        )
      ),
      
      #=== 3.bs4DashControlbar ===
      #controlbar = bs4DashControlbar(
      #  skin = "light",
      #  title = "My right sidebar",
      #  sliderInput(
      #    inputId = "obs",
      #    label = "Number of observations:",
      #    min = 0,
      #    max = 1000,
      #    value = 500
      #  )
      #),
      
      #=== 4.bs4DashFooter ===
      footer = bs4DashFooter(
        copyrights = a(href = "https://github.com/dongwei1220",
            target = "_blank", "Copyrights: @Wei Dong"
        ),
        right_text = "2020"
      ),
      
      #=== 5.bs4DashBody ===
      body = bs4DashBody(
        bs4TabItems(
          #== 1.Plot tabItem
          bs4TabItem(
            tabName = "plot",
            fluidRow(
              bs4Card(
                style="padding:7px",
                inputId = NULL,
                title = "gggenes",
                # footer = "Canvas",
                width = 3,
                status = "primary",
                elevation = 1,
                solidHeader = T,
                headerBorder = T,
                # gradientColor = "primary",
                collapsible = F,
                closable = F,
                maximizable = T,
                # labelText = "Window Options",
                # labelTooltip = "Like Windows",
                overflow = F,
                enable_sidebar = F,
                fluidRow(
                  bs4Card(
                    style="padding:7px;",
                    inputId = NULL,
                    title = "File Upload and Download",
                    # footer = "Canvas",
                    width = 12,
                    status = "primary",
                    elevation = 1,
                    solidHeader = T,
                    headerBorder = T,
                    # gradientColor = "primary",
                    collapsible = TRUE,
                    collapsed = T,
                    closable = F,
                    maximizable = T,
                    # labelText = "Window Options",
                    # labelTooltip = "Like Windows",
                    overflow = F,
                    # enable_sidebar = T,
                    # sidebar_background = "dark",
                    # dropdownMenu = dropdownItemList(
                    #     dropdownItem(url = "https://github.com/dongwei1220", name = "Github")
                    # ),
                    column(
                      width = 12,
                      fileInput(
                        inputId = "input_file",
                        label = "GeneMap File",
                        multiple = F,
                        accept = NULL,
                        width = NULL,
                        buttonLabel = "Browse",
                        placeholder = "Input File "
                      ),
                      selectInput(
                        inputId = "plot_format",
                        label = "Image Format",
                        choices = c(
                          "PDF" = "pdf",
                          "SVG" = "svg",
                          "PNG" = "png",
                          "JPEG" = "jpeg",
                          "TIFF" = "tiff",
                          "BMP" = "bmp"
                        ),
                        selected = "pdf",
                        multiple = F,
                        width = NULL
                      ),
                      downloadButton(
                        outputId = "plot_download",
                        label = "Download",
                        class = NULL
                      )
                    )
                  ),
                  bs4Card(
                    style="padding:7px;",
                    inputId = NULL,
                    title = "Parameter Options",
                    footer = "Canvas",
                    width = 12,
                    status = "primary",
                    elevation = 1,
                    solidHeader = T,
                    headerBorder = T,
                    # gradientColor = "primary",
                    collapsible = TRUE,
                    closable = F,
                    maximizable = T,
                    # labelText = "Window Options",
                    # labelTooltip = "Like Windows",
                    overflow = F,
                    # enable_sidebar = T,
                    # sidebar_background = "dark",
                    # dropdownMenu = dropdownItemList(
                    #     dropdownItem(url = "https://github.com/dongwei1220", name = "Github")
                    # ),
                    column(
                      width = 12,
                      selectInput(
                        inputId = "color_palette",
                        label = "Color Palette",
                        choices = c(
                          "NPG",
                          "AAAS",
                          "NEJM", 
                          "Lancet",
                          "JAMA", 
                          "JCO", 
                          "UCSCGB",
                          "D3",
                          "LocusZoom",
                          "IGV",
                          "UChicago",
                          "Star Trek",
                          "Tron Legacy", 
                          "Futurama",
                          "Rick and Morty",
                          "The Simpsons"
                        ),
                        selected = "UCSCGB",
                        multiple = F,
                        width = NULL
                      ),
                      selectInput(
                        inputId = "color_theme",
                        label = "Color Theme",
                        choices = c(
                          "theme_genes", 
                          "theme_minimal",
                          "theme_classic",
                          "theme_bw",
                          "theme_gray",
                          "theme_dark",
                          "theme_light",
                          "theme_linedraw"
                        ),
                        selected = "theme_minimal",
                        multiple = F,
                        width = NULL
                      ),
                      radioButtons(
                        inputId = "label",
                        label = "Label",
                        choices = c("TRUE","FALSE"),
                        selected = "FALSE",
                        inline = T,
                        width = NULL
                      ),
                      selectInput(
                        inputId = "align",
                        label = "Label Align",
                        choices = c(
                          "Left" = "left", 
                          "Centre" = "centre",
                          "Right" = "right"
                        ),
                        selected = "centre",
                        multiple = F,
                        width = NULL
                      ),
                      sliderInput(
                        inputId = "width",
                        label = "Arrowhead Width",
                        min = 1,
                        max = 10,
                        value = 5,
                        step = 1,
                        round = T,
                        ticks = T,
                        animate = T,
                        width = NULL,
                        timeFormat = T
                      ),
                      sliderInput(
                        inputId = "height",
                        label = "Arrowhead Height",
                        min = 1,
                        max = 10,
                        value = 5,
                        step = 1,
                        round = T,
                        ticks = T,
                        animate = T,
                        width = NULL,
                        timeFormat = T
                      )
                    )
                  )
                )
              ),
              bs4Card(
                style = "padding:5px;
                         background: #ffffff;
                         border-radius: 0px;
                         box-shadow: inset 9.91px 9.91px 20px #D9DADE, inset -9.91px -9.91px 20px #FFFFFF;",
                inputId = NULL,
                title = "Plots",
                footer = "Canvas",
                width = 9,
                status = "warning",
                elevation = 1,
                solidHeader = T,
                headerBorder = T,
                # gradientColor = "primary",
                collapsible = TRUE,
                closable = T,
                maximizable = T,
                labelText = "Window Options",
                labelTooltip = "Like Windows",
                overflow = F,
                enable_sidebar = T,
                sidebar_background = "dark",
                dropdownMenu = dropdownItemList(
                  dropdownItem(url = "https://github.com/dongwei1220", name = "Github")
                ),
                plotOutput("plot",height = 800)
              )
            )
          ),
          
          #== 2.Gallery tabItem
          bs4TabItem(
            tabName = "gallery",
            bs4Card(
              style="padding:20px;",
              inputId = NULL,
              title = "Author Information",
              footer = "Canvas",
              width = 12,
              status = "primary",
              elevation = 1,
              solidHeader = T,
              headerBorder = T,
              #gradientColor = "warning",
              collapsible = TRUE,
              closable = T,
              maximizable = T,
              labelText = "Window Options",
              labelTooltip = "Like Windows",
              overflow = T,
              enable_sidebar = T,
              #sidebar_background = "dark",
              dropdownMenu = dropdownItemList(
                dropdownItem(url = "https://github.com/dongwei1220", name = "Github")
              ),
              h5("Author: Wei Dong",style="font-weight:bold"),
              h5("Github: https://github.com/dongwei1220",style="font-weight:bold"),
              h5("Email: 1369852697@qq.com",style="font-weight:bold"),
              h5("Blog: http://bioinfomics.top/",style="font-weight:bold")
            ),
            fluidPage(
              fluidRow(
                bs4Box(
                  height = "550px",
                  width = 4,
                  title = "Demo 1",
                  div(style="width:100%",
                      img(src="https://wilkox.org/gggenes/articles/introduction-to-gggenes_files/figure-html/theme_genes-1.png",style="width:100%"))
                ),
                bs4Box(
                  height = "550px",
                  width = 4,
                  title = "Demo 2",
                  div(style="width:100%",
                      img(src="https://wilkox.org/gggenes/articles/introduction-to-gggenes_files/figure-html/labelled_genes-1.png",style="width:100%"))
                ),
                bs4Box(
                  height = "550px",
                  width = 4,
                  title = "Demo 3",
                  div(style="width:100%",
                      img(src="https://wilkox.org/gggenes/articles/introduction-to-gggenes_files/figure-html/subgenes-1.png",style="width:100%"))
                )
              )
            )
          ),
          
          #== 3.Table tabItem
          bs4TabItem(
            tabName = "table",
            bs4Card(
              style="padding:20px;",
              inputId = NULL,
              title = "Author Information",
              footer = "Canvas",
              width = 12,
              status = "primary",
              elevation = 1,
              solidHeader = T,
              headerBorder = T,
              #gradientColor = "warning",
              collapsible = TRUE,
              closable = T,
              maximizable = T,
              labelText = "Window Options",
              labelTooltip = "Like Windows",
              overflow = T,
              enable_sidebar = T,
              #sidebar_background = "dark",
              dropdownMenu = dropdownItemList(
                dropdownItem(url = "https://github.com/dongwei1220", name = "Github")
              ),
              h5("Author: Wei Dong",style="font-weight:bold"),
              h5("Github: https://github.com/dongwei1220",style="font-weight:bold"),
              h5("Email: 1369852697@qq.com",style="font-weight:bold"),
              h5("Blog: http://bioinfomics.top/",style="font-weight:bold")
            ),
            fluidPage(
              DTOutput(outputId = "dataset")
            )
          )
        )
      )
    ),

  # Define server logic required to draw gene arrow maps
  server = (function(input, output) {
    # Select palette color
    PaletteSelected <- reactive({
      switch(input$color_palette,
             "NPG" = scale_fill_npg(),
             "AAAS" = scale_fill_aaas(),
             "NEJM" = scale_fill_nejm(), 
             "Lancet" = scale_fill_lancet(),
             "JAMA" = scale_fill_jama(), 
             "JCO" = scale_fill_jco(), 
             "UCSCGB" = scale_fill_ucscgb(),
             "D3" = scale_fill_d3(),
             "LocusZoom" = scale_fill_locuszoom(),
             "IGV" = scale_fill_igv(),
             "UChicago" = scale_fill_uchicago(),
             "Star Trek" = scale_fill_startrek(),
             "Tron Legacy" = scale_fill_tron(), 
             "Futurama" = scale_fill_futurama(),
             "Rick and Morty" = scale_fill_rickandmorty(),
             "The Simpsons" = scale_fill_simpsons()
      )
    })
    
    # Select theme color
    ThemeSelected <- reactive({
      switch(input$color_theme,
             "theme_genes" = theme_genes(), 
             "theme_bw" = theme_bw(),
             "theme_gray" = theme_gray(),
             "theme_dark" = theme_dark(),
             "theme_classic" = theme_classic(),
             "theme_minimal" = theme_minimal(),
             "theme_light" = theme_light(),
             "theme_linedraw" = theme_linedraw()
      )
    })
    
    # output plot
    output$plot <- renderPlot({
      if (is.null(input$input_file)){
        data_input <- read.table("demo.txt",
                                 header = T,
                                 sep = "\t")
        data_input <- as.data.frame(data_input)
      }else{
        data_input <- read.table(input$input_file$datapath,
                                 header = T,
                                 sep = "\t")
        data_input <- as.data.frame(data_input)
      }
      colnames(data_input) <- c("molecule", "gene", "start", "end", "strand", "direction")
      
      if(input$label){
        ggplot(data_input, 
               aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = direction, label = gene)) +
          geom_gene_arrow(arrowhead_height = unit(input$height, "mm"), 
                          arrowhead_width = unit(input$width, "mm")) +
          geom_gene_label(align = input$align) +
          facet_wrap(~ molecule, scales = "free", ncol = 1) +
          PaletteSelected() +
          ThemeSelected()
      }else{
        ggplot(data_input, 
               aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = direction)) +
          geom_gene_arrow(arrowhead_height = unit(input$height, "mm"), 
                          arrowhead_width = unit(input$width, "mm")) +
          facet_wrap(~ molecule, scales = "free", ncol = 1) +
          PaletteSelected() +
          ThemeSelected()
      }
    })
    
    # output plot download
    output$plot_download <- downloadHandler(
      filename = function(){
        paste0("genemap-",Sys.Date(),".",input$plot_format)
      },
      content = function(file){
        if (is.null(input$input_file)){
          data_input <- read.table("demo.txt",
                                   header = T,
                                   sep = "\t")
          data_input <- as.data.frame(data_input)
        }else{
          data_input <- read.table(input$input_file$datapath,
                                   header = T,
                                   sep = "\t")
          data_input <- as.data.frame(data_input)
        }
        colnames(data_input) <- c("molecule", "gene", "start", "end", "strand", "direction")
        
        if (input$plot_format == "pdf"){
          pdf(file = file,width = 12, height = 8,
              family = "Times")
        }else if (input$plot_format == "svg"){
          svg(file = file,width = 12, height = 8,
              family = "Times")
        }else if (input$plot_format == "png"){
          png(file = file,width = 1000, height = 800,
              family = "Times")
        }else if (input$plot_format == "tiff"){
          tiff(file = file,width = 1000, height = 800,
               family = "Times")
        }else if (input$plot_format == "bmp"){
          bmp(file = file,width = 1000, height = 800,
              family = "Times")
        }else if (input$plot_format == "jpeg"){
          jpeg(file = file,width = 1000, height = 800,
               family = "Times")
        }
        if(input$label){
         p <- ggplot(data_input, 
                 aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = direction, label = gene)) +
            geom_gene_arrow(arrowhead_height = unit(input$height, "mm"), 
                            arrowhead_width = unit(input$width, "mm")) +
            geom_gene_label(align = input$align) +
            facet_wrap(~ molecule, scales = "free", ncol = 1) +
            PaletteSelected() +
            ThemeSelected()
        }else{
         p <- ggplot(data_input, 
                 aes(xmin = start, xmax = end, y = molecule, fill = gene, forward = direction)) +
            geom_gene_arrow(arrowhead_height = unit(input$height, "mm"), 
                            arrowhead_width = unit(input$width, "mm")) +
            facet_wrap(~ molecule, scales = "free", ncol = 1) +
            PaletteSelected() +
            ThemeSelected()
        }
        print(p)
        dev.off()
      })
    
    output$dataset <- renderDT({
      if (is.null(input$input_file)){
        data_input <- read.table("demo.txt",
                                 header = T,
                                 sep = "\t")
        data_input <- as.data.frame(data_input)
      }else{
        data_input <- read.table(input$input_file$datapath,
                                 header = T,
                                 sep = "\t")
        data_input <- as.data.frame(data_input)
      }
      colnames(data_input) <- c("molecule", "gene", "start", "end", "strand", "direction")
      
      data_input
    })
  })
)
