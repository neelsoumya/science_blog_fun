library(shiny)
library(ggplot2)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600&family=Syne:wght@400;700;800&display=swap');

      :root {
        --bg:        #0d0f14;
        --panel:     #13161e;
        --border:    #1f2535;
        --accent1:   #4f9cf9;
        --accent2:   #e05555;
        --text:      #cdd6f4;
        --muted:     #6c7086;
        --grid:      #1a1d28;
      }

      html, body { background: var(--bg); color: var(--text); font-family: 'Syne', sans-serif; margin: 0; }

      .app-shell {
        display: flex; flex-direction: column; align-items: center;
        min-height: 100vh; padding: 36px 24px 48px;
        background:
          radial-gradient(ellipse 80% 50% at 50% -10%, rgba(79,156,249,0.08), transparent),
          var(--bg);
      }

      .app-title {
        font-size: 1.6rem; font-weight: 800; letter-spacing: -.02em;
        color: #fff; margin-bottom: 4px; text-align: center;
      }
      .app-sub {
        font-size: .82rem; color: var(--muted); font-family: 'JetBrains Mono', monospace;
        text-align: center; margin-bottom: 32px;
      }

      .content-row {
        display: flex; gap: 24px; width: 100%; max-width: 1000px;
        align-items: flex-start; flex-wrap: wrap; justify-content: center;
      }

      /* ── CONTROLS ──────────────────────────────── */
      .controls-card {
        background: var(--panel);
        border: 1px solid var(--border);
        border-radius: 14px;
        padding: 24px 22px;
        width: 240px; min-width: 200px;
        box-shadow: 0 4px 32px rgba(0,0,0,.4);
      }
      .controls-card h4 {
        font-size: .75rem; font-weight: 700; letter-spacing: .12em;
        text-transform: uppercase; color: var(--muted);
        margin: 0 0 18px; font-family: 'JetBrains Mono', monospace;
      }

      .param-block { margin-bottom: 20px; }
      .param-label {
        display: flex; justify-content: space-between; align-items: baseline;
        font-size: .82rem; color: var(--text); margin-bottom: 6px;
        font-family: 'JetBrains Mono', monospace;
      }
      .param-label span.val {
        font-size: .78rem; color: var(--accent1); font-weight: 600;
      }

      input[type=range] {
        -webkit-appearance: none; width: 100%; height: 4px;
        border-radius: 4px; outline: none; cursor: pointer;
        background: linear-gradient(to right, var(--accent1) 0%, var(--accent1) var(--pct, 50%), var(--border) var(--pct, 50%), var(--border) 100%);
      }
      input[type=range]::-webkit-slider-thumb {
        -webkit-appearance: none; width: 14px; height: 14px;
        border-radius: 50%; background: var(--accent1);
        border: 2px solid var(--bg); box-shadow: 0 0 0 2px var(--accent1);
        transition: transform .15s;
      }
      input[type=range]::-webkit-slider-thumb:hover { transform: scale(1.3); }

      /* lambda badge */
      .lambda-badge {
        background: rgba(79,156,249,.08);
        border: 1px solid rgba(79,156,249,.25);
        border-radius: 8px; padding: 10px 14px;
        margin-top: 8px;
        font-family: 'JetBrains Mono', monospace;
        font-size: .78rem; color: var(--muted);
        line-height: 1.7;
      }
      .lambda-badge .lv { color: var(--accent1); font-size: 1rem; font-weight: 600; }
      .lambda-badge .exp-v { color: #a6e3a1; font-size: .88rem; font-weight: 600; }

      /* ── PLOT ──────────────────────────────────── */
      .plot-card {
        background: var(--panel);
        border: 1px solid var(--border);
        border-radius: 14px; overflow: hidden;
        flex: 1; min-width: 300px;
        box-shadow: 0 4px 32px rgba(0,0,0,.4);
      }
      .plot-card .shiny-plot-output { display: block; width: 100% !important; }

      /* param description */
      .param-desc {
        font-size: .72rem; color: var(--muted); line-height: 1.45;
        margin-top: 3px; margin-bottom: 10px;
        font-family: 'Syne', sans-serif;
      }

      /* context blurb */
      .context-blurb {
        max-width: 1000px; width: 100%;
        background: var(--panel);
        border: 1px solid var(--border);
        border-left: 3px solid var(--accent1);
        border-radius: 10px;
        padding: 16px 20px;
        margin-bottom: 24px;
        font-size: .83rem; line-height: 1.7; color: #a0a8c0;
        box-shadow: 0 2px 16px rgba(0,0,0,.3);
      }
      .blog-link {
        font-size: .8rem; font-family: 'JetBrains Mono', monospace;
        margin-bottom: 20px; text-align: center;
      }
      .blog-link a {
        color: var(--accent1); text-decoration: none;
        border-bottom: 1px dashed rgba(79,156,249,.4);
        padding-bottom: 1px;
        transition: border-color .2s, color .2s;
      }
      .blog-link a:hover { color: #fff; border-color: #fff; }

      .context-blurb strong { color: var(--text); }
      .context-blurb .formula {
        display: inline-block;
        background: rgba(79,156,249,.1);
        border: 1px solid rgba(79,156,249,.2);
        border-radius: 5px;
        padding: 1px 7px;
        font-family: 'JetBrains Mono', monospace;
        font-size: .8rem; color: var(--accent1);
      }

      /* shiny default overrides */
      .shiny-input-container { margin: 0 !important; }
      label { display: none !important; }
    "))
  ),
  
  div(class = "app-shell",
      div(class = "app-title", "Breathing Ramanujan's Air"),
      div(class = "app-sub", "What is the probability you just inhaled a molecule he once breathed?"),
      div(class = "blog-link",
          tags$a(href = "https://neelsoumya.github.io/science_blog_fun/ramanujan_breath.html",
                 target = "_blank",
                 "📖 Read the full blog post ↗")
      ),
      
      div(class = "context-blurb",
          tags$strong("The idea: "), "Every breath you take contains roughly ",
          tags$strong("10,000 – 100,000"), " molecules of air. Ramanujan breathed ",
          "continuously for ~32 years, cycling through an enormous number of molecules. ",
          "Because the atmosphere mixes those molecules globally over centuries, ",
          "a Poisson approximation gives the probability that ",
          tags$em("at least one"), " molecule in your current breath was also breathed by Ramanujan as ",
          tags$span(class = "formula", "P ≈ e⁻λ"),
          ", where ",
          tags$span(class = "formula", "λ = x · A / B"),
          " is the expected overlap count. ",
          tags$strong("x"), " = molecules per breath (yours) · ",
          tags$strong("A"), " = total molecules Ramanujan breathed · ",
          tags$strong("B"), " = molecules in Earth's atmosphere."
      ),
      
      div(class = "content-row",
          
          # ── Controls ───────────────────────────────────
          div(class = "controls-card",
              tags$h4("Parameters"),
              
              div(class = "param-block",
                  div(class = "param-label",
                      tags$span("x — molecules / breath"),
                      tags$span(class = "val", textOutput("x_val", inline = TRUE))
                  ),
                  sliderInput("x_exp", label = NULL,
                              min = 2, max = 8, value = 4, step = 0.1),
                  div(class = "param-desc", "Number of air molecules in a single breath you take right now.")
              ),
              
              div(class = "param-block",
                  div(class = "param-label",
                      tags$span("A — Ramanujan's lifetime"),
                      tags$span(class = "val", textOutput("A_val", inline = TRUE))
                  ),
                  sliderInput("A_exp", label = NULL,
                              min = 2, max = 12, value = 6, step = 0.1),
                  div(class = "param-desc", "Total molecules Ramanujan breathed over his entire lifetime (~32 years).")
              ),
              
              div(class = "param-block",
                  div(class = "param-label",
                      tags$span("B — atmosphere"),
                      tags$span(class = "val", textOutput("B_val", inline = TRUE))
                  ),
                  sliderInput("B_exp", label = NULL,
                              min = 6, max = 16, value = 7, step = 0.1),
                  div(class = "param-desc", "Total number of molecules in Earth's entire atmosphere.")
              ),
              
              div(class = "lambda-badge",
                  "expected overlap  λ = x·A / B",
                  tags$br(),
                  tags$span(class = "lv", textOutput("lam_val", inline = TRUE)),
                  tags$br(),
                  "P(sharing a molecule) = e⁻λ ≈ ",
                  tags$span(class = "exp-v", textOutput("exp_val", inline = TRUE))
              )
          ),
          
          # ── Plot ───────────────────────────────────────
          div(class = "plot-card",
              plotOutput("curve", height = "400px")
          )
      )
  ),
  
  # JS: live-update slider fill + format display values
  tags$script(HTML("
    function fmtSci(v) {
      if (v === 0) return '0';
      var e = Math.floor(Math.log10(Math.abs(v)));
      var m = v / Math.pow(10, e);
      var ms = (Math.abs(m - 1) < 1e-9) ? '' : m.toFixed(2) + '×';
      return ms + '10' + supStr(e);
    }
    function supStr(n) {
      var map = {'0':'⁰','1':'¹','2':'²','3':'³','4':'⁴','5':'⁵','6':'⁶','7':'⁷','8':'⁸','9':'⁹','-':'⁻'};
      return String(n).split('').map(function(c){ return map[c]||c; }).join('');
    }

    function updateSlider(id) {
      var el = document.getElementById(id);
      if (!el) return;
      var mn = parseFloat(el.min), mx = parseFloat(el.max), v = parseFloat(el.value);
      el.style.setProperty('--pct', ((v - mn) / (mx - mn) * 100) + '%');
    }

    $(document).on('shiny:connected', function() {
      ['x_exp','A_exp','B_exp'].forEach(function(id) {
        var el = document.getElementById(id);
        if (el) { updateSlider(id); el.addEventListener('input', function(){ updateSlider(id); }); }
      });
    });
  "))
)

server <- function(input, output, session) {
  
  x_val <- reactive(10^input$x_exp)
  A_val <- reactive(10^input$A_exp)
  B_val <- reactive(10^input$B_exp)
  lam   <- reactive(x_val() * A_val() / B_val())
  
  fmt_sci <- function(v) {
    if (v == 0) return("0")
    e <- floor(log10(abs(v)))
    m <- v / 10^e
    if (abs(m - 1) < 1e-9) paste0("10^", e)
    else paste0(signif(m, 3), " × 10^", e)
  }
  
  output$x_val  <- renderText(fmt_sci(x_val()))
  output$A_val  <- renderText(fmt_sci(A_val()))
  output$B_val  <- renderText(fmt_sci(B_val()))
  output$lam_val <- renderText(signif(lam(), 4))
  output$exp_val <- renderText({
    ev <- exp(-lam())
    if (ev == 0) "≈ 0" else formatC(ev, format = "e", digits = 3)
  })
  
  output$curve <- renderPlot({
    l <- lam()
    lo <- max(l / 20, 1e-6)
    hi <- l * 2
    grid_x <- seq(lo, hi, length.out = 200)
    grid_y <- exp(-grid_x)
    df <- data.frame(x = grid_x, y = grid_y)
    
    ggplot(df, aes(x, y)) +
      geom_line(color = "#4f9cf9", linewidth = 1.1) +
      geom_vline(xintercept = l, color = "#e05555",
                 linetype = "dashed", linewidth = 0.9) +
      annotate("text", x = l, y = max(grid_y) * 0.6,
               label = paste0("λ = ", signif(l, 4)),
               color = "#e05555", hjust = -0.1,
               family = "mono", size = 3.4) +
      scale_y_log10() +
      labs(x = expression(lambda ~ "(expected shared molecules)"),
           y = expression("P(no shared molecule) = " ~ e^{-lambda}),
           title = "Probability of Sharing Ramanujan's Breath") +
      theme_minimal(base_size = 13) +
      theme(
        plot.background  = element_rect(fill = "#13161e", color = NA),
        panel.background = element_rect(fill = "#13161e", color = NA),
        panel.grid.major = element_line(color = "#1f2535", linewidth = 0.4, linetype = "dashed"),
        panel.grid.minor = element_line(color = "#1a1d28", linewidth = 0.3, linetype = "dashed"),
        axis.text  = element_text(color = "#6c7086", family = "mono"),
        axis.title = element_text(color = "#cdd6f4"),
        plot.title = element_text(color = "#cdd6f4", face = "bold",
                                  hjust = 0.5, margin = margin(b = 10)),
        plot.margin = margin(20, 20, 16, 16)
      )
  }, bg = "#13161e")
}

shinyApp(ui, server)