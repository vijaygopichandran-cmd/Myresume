library(shiny)
library(bslib)

# ── UI ──────────────────────────────────────────────────────────────────────
ui <- fluidPage(
  title = "Dr. Vijayaprasad Gopichandran – Academic CV",
  tags$head(
    tags$link(
      rel = "stylesheet",
      href = "https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=Source+Sans+3:wght@300;400;600&display=swap"
    ),
    tags$style(HTML("
      /* ── Reset & Base ── */
      *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
      body {
        background: #0d1117;
        color: #e8e0d4;
        font-family: 'Source Sans 3', sans-serif;
        font-weight: 300;
        min-height: 100vh;
      }

      /* ── Hero Header ── */
      .hero {
        background: linear-gradient(135deg, #0d1117 0%, #1a2332 50%, #0d1117 100%);
        border-bottom: 1px solid #2a3a50;
        padding: 60px 5% 50px;
        position: relative;
        overflow: hidden;
      }
      .hero::before {
        content: '';
        position: absolute;
        top: -60px; right: -60px;
        width: 320px; height: 320px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(192,150,83,0.12) 0%, transparent 70%);
        pointer-events: none;
      }
      .hero-inner {
        max-width: 1000px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: 1fr auto;
        gap: 24px;
        align-items: end;
      }
      .hero-name {
        font-family: 'Playfair Display', serif;
        font-size: clamp(2.4rem, 5vw, 4rem);
        font-weight: 900;
        line-height: 1.05;
        color: #f0e8d8;
        letter-spacing: -0.01em;
      }
      .hero-name span { color: #c09653; }
      .hero-title {
        font-size: 1rem;
        font-weight: 600;
        letter-spacing: 0.18em;
        text-transform: uppercase;
        color: #c09653;
        margin-top: 12px;
      }
      .hero-contact {
        display: flex;
        flex-direction: column;
        gap: 6px;
        font-size: 0.85rem;
        color: #8a9bb0;
        text-align: right;
      }
      .hero-contact a { color: #a0b8d0; text-decoration: none; }
      .hero-contact a:hover { color: #c09653; }

      /* ── Metrics Strip ── */
      .metrics-strip {
        background: #141d2b;
        border-bottom: 1px solid #2a3a50;
        padding: 24px 5%;
      }
      .metrics-inner {
        max-width: 1000px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 0;
      }
      .metric {
        text-align: center;
        padding: 16px 12px;
        border-right: 1px solid #2a3a50;
      }
      .metric:last-child { border-right: none; }
      .metric-num {
        font-family: 'Playfair Display', serif;
        font-size: 2.4rem;
        font-weight: 700;
        color: #c09653;
        line-height: 1;
      }
      .metric-label {
        font-size: 0.72rem;
        text-transform: uppercase;
        letter-spacing: 0.12em;
        color: #5a7090;
        margin-top: 6px;
      }

      /* ── Navbar ── */
      .cv-nav {
        background: #111820;
        border-bottom: 1px solid #2a3a50;
        padding: 0 5%;
        position: sticky;
        top: 0;
        z-index: 100;
      }
      .cv-nav-inner {
        max-width: 1000px;
        margin: 0 auto;
        display: flex;
        gap: 0;
      }
      .nav-btn {
        background: none;
        border: none;
        color: #5a7090;
        font-family: 'Source Sans 3', sans-serif;
        font-size: 0.8rem;
        font-weight: 600;
        letter-spacing: 0.12em;
        text-transform: uppercase;
        padding: 16px 20px;
        cursor: pointer;
        border-bottom: 2px solid transparent;
        transition: all 0.2s;
      }
      .nav-btn:hover { color: #c09653; }
      .nav-btn.active { color: #c09653; border-bottom-color: #c09653; }

      /* ── Main Content ── */
      .cv-main {
        max-width: 1000px;
        margin: 0 auto;
        padding: 48px 5% 80px;
      }
      .cv-section { display: none; }
      .cv-section.visible { display: block; }

      /* ── Section Header ── */
      .section-heading {
        font-family: 'Playfair Display', serif;
        font-size: 1.7rem;
        font-weight: 700;
        color: #f0e8d8;
        margin-bottom: 32px;
        padding-bottom: 14px;
        border-bottom: 1px solid #2a3a50;
        position: relative;
      }
      .section-heading::after {
        content: '';
        position: absolute;
        bottom: -1px; left: 0;
        width: 48px; height: 2px;
        background: #c09653;
      }

      /* ── Cards ── */
      .cv-card {
        background: #141d2b;
        border: 1px solid #2a3a50;
        border-radius: 6px;
        padding: 28px 32px;
        margin-bottom: 16px;
        transition: border-color 0.2s;
      }
      .cv-card:hover { border-color: #3a4f6a; }

      .card-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 16px;
        margin-bottom: 10px;
        flex-wrap: wrap;
      }
      .card-title {
        font-family: 'Playfair Display', serif;
        font-size: 1.1rem;
        font-weight: 700;
        color: #f0e8d8;
      }
      .card-meta {
        font-size: 0.8rem;
        color: #c09653;
        font-weight: 600;
        letter-spacing: 0.06em;
        white-space: nowrap;
      }
      .card-subtitle {
        font-size: 0.9rem;
        color: #8a9bb0;
        margin-bottom: 4px;
      }
      .card-body {
        font-size: 0.9rem;
        color: #6a8090;
        line-height: 1.6;
      }

      /* ── Education Grid ── */
      .edu-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 16px;
        margin-bottom: 0;
      }
      .edu-card {
        background: #141d2b;
        border: 1px solid #2a3a50;
        border-radius: 6px;
        padding: 24px 22px;
        border-top: 3px solid #c09653;
        transition: transform 0.2s;
      }
      .edu-card:hover { transform: translateY(-3px); }
      .edu-degree {
        font-family: 'Playfair Display', serif;
        font-size: 1.3rem;
        font-weight: 700;
        color: #c09653;
        margin-bottom: 8px;
      }
      .edu-inst {
        font-size: 0.9rem;
        color: #f0e8d8;
        font-weight: 600;
        margin-bottom: 6px;
      }
      .edu-year {
        font-size: 0.8rem;
        color: #5a7090;
        letter-spacing: 0.08em;
      }

      /* ── Achievements list ── */
      .ach-list { list-style: none; padding: 0; }
      .ach-list li {
        padding: 14px 0 14px 24px;
        border-bottom: 1px solid #1e2d3e;
        position: relative;
        font-size: 0.92rem;
        color: #c8d4e0;
        line-height: 1.5;
      }
      .ach-list li:last-child { border-bottom: none; }
      .ach-list li::before {
        content: '▸';
        position: absolute;
        left: 0;
        color: #c09653;
        font-size: 0.75rem;
        top: 16px;
      }

      /* ── Publications ── */
      .pub-card {
        background: #141d2b;
        border: 1px solid #2a3a50;
        border-radius: 6px;
        padding: 22px 28px;
        margin-bottom: 12px;
        display: grid;
        grid-template-columns: auto 1fr auto;
        gap: 20px;
        align-items: start;
        transition: border-color 0.2s;
      }
      .pub-card:hover { border-color: #3a4f6a; }
      .pub-num {
        font-family: 'Playfair Display', serif;
        font-size: 1.5rem;
        font-weight: 700;
        color: #2a3a50;
        line-height: 1;
        width: 28px;
        text-align: right;
      }
      .pub-text {
        font-size: 0.88rem;
        color: #8a9bb0;
        line-height: 1.6;
      }
      .pub-text strong { color: #f0e8d8; }
      .pub-citations {
        text-align: center;
        min-width: 60px;
      }
      .pub-cite-num {
        font-family: 'Playfair Display', serif;
        font-size: 1.6rem;
        font-weight: 700;
        color: #c09653;
        line-height: 1;
      }
      .pub-cite-label {
        font-size: 0.65rem;
        text-transform: uppercase;
        letter-spacing: 0.1em;
        color: #4a6070;
      }

      /* ── Grants ── */
      .grant-card {
        background: #141d2b;
        border: 1px solid #2a3a50;
        border-left: 4px solid #c09653;
        border-radius: 0 6px 6px 0;
        padding: 22px 28px;
        margin-bottom: 14px;
      }
      .grant-title {
        font-family: 'Playfair Display', serif;
        font-size: 1rem;
        font-weight: 700;
        color: #f0e8d8;
        margin-bottom: 10px;
        line-height: 1.4;
      }
      .grant-meta-row {
        display: flex;
        gap: 24px;
        flex-wrap: wrap;
      }
      .grant-meta-item {
        font-size: 0.8rem;
        color: #5a7090;
      }
      .grant-meta-item span { color: #a0b8cc; font-weight: 600; }
      .grant-amount {
        font-family: 'Playfair Display', serif;
        font-size: 1rem;
        color: #c09653;
        font-weight: 700;
      }

      /* Responsive */
      @media (max-width: 680px) {
        .edu-grid { grid-template-columns: 1fr; }
        .metrics-inner { grid-template-columns: repeat(2,1fr); }
        .hero-inner { grid-template-columns: 1fr; }
        .hero-contact { text-align: left; }
        .pub-card { grid-template-columns: 1fr; }
        .pub-num { display: none; }
      }
    "))
  ),
  
  # ── Header ──────────────────────────────────────────────────────────────
  div(class = "hero",
      div(class = "hero-inner",
          div(
            div(class = "hero-name",
                "Dr. ", tags$span("Vijayaprasad"), br(), "Gopichandran"
            ),
            div(class = "hero-title", "MBBS · MD (Community Medicine) · PhD (Public Health)")
          ),
          div(class = "hero-contact",
              tags$a(href = "mailto:vijay.gopichandran@gmail.com", "vijay.gopichandran@gmail.com"),
              div("+91 94452 26806"),
              div("Chennai 600033, India"),
              div("DOB: 12 October 1978")
          )
      )
  ),
  
  # ── Metrics ─────────────────────────────────────────────────────────────
  div(class = "metrics-strip",
      div(class = "metrics-inner",
          div(class = "metric",
              div(class = "metric-num", "93"),
              div(class = "metric-label", "Peer-Reviewed Publications")
          ),
          div(class = "metric",
              div(class = "metric-num", "2572"),
              div(class = "metric-label", "Total Citations")
          ),
          div(class = "metric",
              div(class = "metric-num", "27"),
              div(class = "metric-label", "h-Index")
          ),
          div(class = "metric",
              div(class = "metric-num", "45"),
              div(class = "metric-label", "i10-Index")
          )
      )
  ),
  
  # ── Nav ──────────────────────────────────────────────────────────────────
  div(class = "cv-nav",
      div(class = "cv-nav-inner",
          tags$button(class = "nav-btn active", id = "btn-edu",    onclick = "showSection('edu')",    "Education"),
          tags$button(class = "nav-btn",        id = "btn-exp",    onclick = "showSection('exp')",    "Experience"),
          tags$button(class = "nav-btn",        id = "btn-ach",    onclick = "showSection('ach')",    "Achievements"),
          tags$button(class = "nav-btn",        id = "btn-pubs",   onclick = "showSection('pubs')",   "Publications"),
          tags$button(class = "nav-btn",        id = "btn-grants", onclick = "showSection('grants')", "Grants")
      )
  ),
  
  # ── Sections ─────────────────────────────────────────────────────────────
  div(class = "cv-main",
      
      # EDUCATION
      div(id = "sec-edu", class = "cv-section visible",
          div(class = "section-heading", "Educational Qualifications"),
          div(class = "edu-grid",
              div(class = "edu-card",
                  div(class = "edu-degree", "MBBS"),
                  div(class = "edu-inst", "Madras Medical College, Chennai"),
                  div(class = "edu-year", "The TN Dr. MGR Medical University · 2002"),
                  tags$div(style = "margin-top:12px; font-size:0.82rem; color:#c09653; font-weight:600;", "🥇 Gold Medal")
              ),
              div(class = "edu-card",
                  div(class = "edu-degree", "MD"),
                  div(class = "edu-inst", "Christian Medical College, Vellore"),
                  div(class = "edu-year", "The TN Dr. MGR Medical University · 2010"),
                  tags$div(style = "margin-top:12px; font-size:0.82rem;",
                           tags$span(style="color:#c09653; font-weight:600;", "🥇 Gold Medal"),
                           br(),
                           tags$span(style="color:#5a7090; font-size:0.78rem;", "Community Medicine · Best Outgoing Student")
                  )
              ),
              div(class = "edu-card",
                  div(class = "edu-degree", "PhD"),
                  div(class = "edu-inst", "School of Public Health, SRM University"),
                  div(class = "edu-year", "SRM University · 2015"),
                  tags$div(style = "margin-top:12px; font-size:0.82rem; color:#5a7090;", "Public Health · DST INSPIRE Fellow")
              )
          )
      ),
      
      # EXPERIENCE
      div(id = "sec-exp", class = "cv-section",
          div(class = "section-heading", "Work Experience"),
          
          div(class = "cv-card",
              div(class = "card-header",
                  div(
                    div(class = "card-title", "Head, International Centre for Collaborative Research"),
                    div(class = "card-subtitle", "Omayal Achi College of Nursing, Chennai")
                  ),
                  div(class = "card-meta", "Jan 2025 – Present")
              ),
              div(class = "card-body", "Research leadership role — overseeing international collaborative research initiatives.")
          ),
          
          div(class = "cv-card",
              div(class = "card-header",
                  div(
                    div(class = "card-title", "Assistant Professor, Community Medicine"),
                    div(class = "card-subtitle", "ESIC Medical College & Hospital, KK Nagar, Chennai")
                  ),
                  div(class = "card-meta", "May 2015 – Feb 2024")
              ),
              div(class = "card-body", "Teaching and academic responsibilities in Community Medicine over nearly 9 years.")
          ),
          
          div(class = "cv-card",
              div(class = "card-header",
                  div(
                    div(class = "card-title", "Doctoral Research Fellow"),
                    div(class = "card-subtitle", "School of Public Health, SRM University")
                  ),
                  div(class = "card-meta", "2011 – 2014")
              ),
              div(class = "card-body", "Research and teaching experience. Supported by DST INSPIRE Fellowship.")
          ),
          
          div(class = "cv-card",
              div(class = "card-header",
                  div(
                    div(class = "card-title", "Medical and Research Officer"),
                    div(class = "card-subtitle", "Rural Women's Social Education Centre, Chengalpet")
                  ),
                  div(class = "card-meta", "2010 – 2011")
              ),
              div(class = "card-body", "Community-based research with rural women's health.")
          ),
          
          div(class = "cv-card",
              div(class = "card-header",
                  div(
                    div(class = "card-title", "Junior Resident – Community Medicine"),
                    div(class = "card-subtitle", "Christian Medical College, Vellore")
                  ),
                  div(class = "card-meta", "2007 – 2010")
              ),
              div(class = "card-body", "Research and teaching experience in Community Medicine during postgraduate training.")
          )
      ),
      
      # ACHIEVEMENTS
      div(id = "sec-ach", class = "cv-section",
          div(class = "section-heading", "Academic Accomplishments & Recognitions"),
          div(class = "cv-card",
              tags$ul(class = "ach-list",
                      tags$li("Gold Medal in MBBS — Madras Medical College"),
                      tags$li("Gold Medal in MD (Community Medicine) — CMC Vellore"),
                      tags$li("Best Outgoing Student from MD Community Medicine — CMC Vellore"),
                      tags$li("DST INSPIRE Fellowship, Department of Science & Technology, Government of India — to pursue PhD in Public Health (2011)"),
                      tags$li("Consultant for the World Health Organization on Ethics of Public Health Surveillance"),
                      tags$li("Consultant for the World Health Organization on Ethics of Implementation Research"),
                      tags$li("Consultant for the World Health Organization on Ethics of Vector-Borne Disease Control"),
                      tags$li("Developed and authored the curriculum, course and MOOC on Ethics of Implementation Research for WHO/TDR"),
                      tags$li("Member, Scientific Review Committee — Department of Epidemiology, The TN Dr. MGR Medical University, Chennai"),
                      tags$li("Resource Person, Research Methodology Workshop — The TN Dr. MGR Medical University, Chennai")
              )
          )
      ),
      
      # PUBLICATIONS
      div(id = "sec-pubs", class = "cv-section",
          div(class = "section-heading", "Top 10 Highly Cited Publications"),
          
          div(class = "pub-card",
              div(class = "pub-num", "1"),
              div(class = "pub-text",
                  "KGM Dhanapal, SS Magesh, S. Saravanan, ", tags$strong("V Gopichandran"), ". ",
                  "Attitude towards COVID-19 vaccines and vaccine hesitancy in urban and rural communities in Tamil Nadu, India — a community based survey. ",
                  tags$em("BMC Health Services Research"), " 21(1), 1–10, 2021. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "190"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "2"),
              div(class = "pub-text",
                  tags$strong("V Gopichandran"), ", S Lyndon, MK Angel et al. ",
                  "Diabetes self-care activities: a community-based survey in urban southern India. ",
                  tags$em("National Medical Journal of India"), " 25(1):14, 2012. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "159"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "3"),
              div(class = "pub-text",
                  "K Vadivelan, P Sekar, SS Sruthi, ", tags$strong("V Gopichandran"), ". ",
                  "Burden of caregivers of children with cerebral palsy: an intersectional analysis of gender, poverty, stigma, and public policy. ",
                  tags$em("BMC Public Health"), " 20, 1–8, 2020. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "211"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "4"),
              div(class = "pub-text",
                  "R Balakrishnan, ", tags$strong("V Gopichandran"), ", SP Chaturvedi et al. ",
                  "Continuum of Care Services for Maternal and Child Health using mobile technology — a health system strengthening strategy in LMICs. ",
                  tags$em("BMC Medical Informatics and Decision Making"), " 16, 1–8, 2016. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "148"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "5"),
              div(class = "pub-text",
                  tags$strong("V Gopichandran"), ", S Chetlapalli. ",
                  "Factors influencing trust in doctors: a community segmentation strategy for quality improvement in healthcare. ",
                  tags$em("BMJ Open"), " 3(12), 2013. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "102"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "6"),
              div(class = "pub-text",
                  tags$strong("V Gopichandran"), ", VA Luyckx, N Biller-Andorno et al. ",
                  "Developing the ethics of implementation research in health. ",
                  tags$em("Implementation Science"), " 11, 1–13, 2016. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "83"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "7"),
              div(class = "pub-text",
                  tags$strong("V Gopichandran"), ", SK Chetlapalli. ",
                  "Dimensions and determinants of trust in health care in resource-poor settings — a qualitative exploration. ",
                  tags$em("PloS One"), " 8(7), e69170, 2013. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "88"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "8"),
              div(class = "pub-text",
                  tags$strong("V Gopichandran"), ", S Subramaniam, MJ Kalsingh. ",
                  "Psycho-social impact of stillbirths on women and their families in Tamil Nadu, India — a qualitative study. ",
                  tags$em("BMC Pregnancy and Childbirth"), " 18, 1–13, 2018. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "85"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "9"),
              div(class = "pub-text",
                  "S Ravi, S Kumar, ", tags$strong("V Gopichandran"), ". ",
                  "Do supportive family behaviors promote diabetes self-management in resource-limited urban settings? A cross-sectional study. ",
                  tags$em("BMC Public Health"), " 18(1), 1–9, 2018. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "72"),
                  div(class = "pub-cite-label", "Citations")
              )
          ),
          
          div(class = "pub-card",
              div(class = "pub-num", "10"),
              div(class = "pub-text",
                  "S Sundararajan, ", tags$strong("V Gopichandran"), ". ",
                  "Emotional intelligence among medical students: a mixed methods study from Chennai, India. ",
                  tags$em("BMC Medical Education"), " 18, 1–9, 2018. PubMed."
              ),
              div(class = "pub-citations",
                  div(class = "pub-cite-num", "80"),
                  div(class = "pub-cite-label", "Citations")
              )
          )
      ),
      
      # GRANTS
      div(id = "sec-grants", class = "cv-section",
          div(class = "section-heading", "Research Grants"),
          
          div(class = "grant-card",
              div(class = "grant-title",
                  "Are antimicrobials appropriately used in public health facilities as per treatment guidelines for antimicrobial use in common syndromes?"
              ),
              div(class = "grant-meta-row",
                  div(class = "grant-meta-item", "Role: ", tags$span("Principal Investigator")),
                  div(class = "grant-meta-item", "Agency: ", tags$span("Tamil Nadu Health Systems Reforms Program, Govt. of Tamil Nadu")),
                  div(class = "grant-meta-item", "Duration: ", tags$span("Aug 2021 – Aug 2022")),
                  div(class = "grant-amount", "₹14 Lakhs")
              )
          ),
          
          div(class = "grant-card",
              div(class = "grant-title",
                  "Practical and experiential wisdom of ethics and professionalism of community health workers in Tamil Nadu"
              ),
              div(class = "grant-meta-row",
                  div(class = "grant-meta-item", "Role: ", tags$span("Principal Investigator")),
                  div(class = "grant-meta-item", "Agency: ", tags$span("The Thakur Foundation, USA")),
                  div(class = "grant-meta-item", "Duration: ", tags$span("Jan 2022 – Jan 2023")),
                  div(class = "grant-amount", "₹12 Lakhs")
              )
          ),
          
          div(class = "grant-card",
              div(class = "grant-title",
                  "Ethics and professionalism of Community Health Workers — curriculum development and training project"
              ),
              div(class = "grant-meta-row",
                  div(class = "grant-meta-item", "Role: ", tags$span("Principal Investigator")),
                  div(class = "grant-meta-item", "Agency: ", tags$span("The Thakur Foundation, USA")),
                  div(class = "grant-meta-item", "Duration: ", tags$span("Aug 2023 – Aug 2024")),
                  div(class = "grant-amount", "₹10 Lakhs")
              )
          ),
          
          div(class = "grant-card",
              div(class = "grant-title",
                  "Peer support and mHealth intervention to promote diabetes self-management in a rural community in Tamil Nadu, India — a cluster randomized controlled trial"
              ),
              div(class = "grant-meta-row",
                  div(class = "grant-meta-item", "Role: ", tags$span("Co-Principal Investigator")),
                  div(class = "grant-meta-item", "Agency: ", tags$span("Azim Premji Foundation")),
                  div(class = "grant-meta-item", "Duration: ", tags$span("Jan 2024 – Jun 2026")),
                  div(class = "grant-amount", "₹68 Lakhs")
              )
          )
      )
  ),
  
  # ── JS for tab switching ──────────────────────────────────────────────────
  tags$script(HTML("
    function showSection(id) {
      // hide all sections
      document.querySelectorAll('.cv-section').forEach(function(s){ s.classList.remove('visible'); });
      document.getElementById('sec-' + id).classList.add('visible');
      // update nav buttons
      document.querySelectorAll('.nav-btn').forEach(function(b){ b.classList.remove('active'); });
      document.getElementById('btn-' + id).classList.add('active');
    }
  "))
)

# ── Server (no reactive logic needed) ─────────────────────────────────────
server <- function(input, output, session) {}

shinyApp(ui, server)