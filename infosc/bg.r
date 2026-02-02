# Generate vertices of a regular hexagon with vertical tips (pointing up/down)
# Vertex order (counter-clockwise starting from top):
#   1: 90°   (0, 1)        — top
#   2: 30°   (√3/2, 0.5)   — upper-right
#   3: 330°  (√3/2, -0.5)  — lower-right
#   4: 270°  (0, -1)       — bottom
#   5: 210°  (-√3/2, -0.5) — lower-left
#   6: 150°  (-√3/2, 0.5)  — upper-left
angles_deg <- c(90, 30, 330, 270, 210, 150)
angles_rad <- angles_deg * base::pi / 180
hex_vertices <- base::data.frame(
  x = base::cos(angles_rad),
  y = base::sin(angles_rad),
  vertex_id = 1:6
)

# Construct three quadrilateral regions for equal-area trisection
# Partition lines connect center to vertices 1 (top), 3 (lower-right), 5 (lower-left)
# Resulting regions (each contains exactly 2 equilateral triangles = 1/3 total area):
#   - upper_left:  center → vertex5 → vertex6 → vertex1
#   - upper_right: center → vertex1 → vertex2 → vertex3
#   - bottom:      center → vertex3 → vertex4 → vertex5
region_data <- base::rbind(
  # Upper-left region (increase trend)
  base::data.frame(
    x = c(0, hex_vertices$x[5], hex_vertices$x[6], hex_vertices$x[1]),
    y = c(0, hex_vertices$y[5], hex_vertices$y[6], hex_vertices$y[1]),
    region = "increase"
  ),
  # Upper-right region (decrease trend)
  base::data.frame(
    x = c(0, hex_vertices$x[1], hex_vertices$x[2], hex_vertices$x[3]),
    y = c(0, hex_vertices$y[1], hex_vertices$y[2], hex_vertices$y[3]),
    region = "decrease"
  ),
  # Bottom region (stable trend)
  base::data.frame(
    x = c(0, hex_vertices$x[3], hex_vertices$x[4], hex_vertices$x[5]),
    y = c(0, hex_vertices$y[3], hex_vertices$y[4], hex_vertices$y[5]),
    region = "stable"
  )
)

# color_map <- base::c(
#   increase = "#77725E",  # Soft teal — upward/growth trend
#   decrease = "#4C453B",  # Gentle coral — downward/decline trend  
#   stable   = "#B5A166"   # Muted gold — neutral/stable trend
# )

color_map <- base::c(
  increase = "#77725E",  # Deep olive ash — subtle upward movement
  decrease = "#4C453B",  # Xuan black — profound descent
  stable   = "#8B7A4E"   # Xuan-Huang — earthy gold with charcoal depth, noble equilibrium
)

# Hexagon outer border (closed path for stroke only)
hex_border <- base::rbind(hex_vertices, hex_vertices[1, ])

# Render hexagon with three seamless regions and gray outer stroke
fig_bg = ggplot2::ggplot() +
  # Three internal regions with soft fills and NO internal borders
  ggplot2::geom_polygon(
    data = region_data,
    mapping = ggplot2::aes(x = x, y = y, fill = region),
    colour = NA,          # Critical: no borders between regions
    show.legend = FALSE,
    alpha = 0.75
  ) +
  # Outer hexagon border in neutral gray
  ggplot2::geom_path(
    data = hex_border,
    mapping = ggplot2::aes(x = x, y = y),
    colour = "#7F7F7F",   # Medium gray stroke
    linewidth = 2.75,
    lineend = "round",
    show.legend = FALSE,
    alpha = 1
  ) +
  # Apply trend-based color mapping
  ggplot2::scale_fill_manual(values = color_map) +
  # Preserve geometric proportions and remove all axes/panels
  ggplot2::coord_fixed(ratio = 1, expand = FALSE) +
  ggplot2::theme_void() +
  ggplot2::theme(
    plot.background = ggplot2::element_rect(fill = "transparent", colour = NA),
    panel.background = ggplot2::element_rect(fill = "transparent", colour = NA)
  ) +
  # Add minimal padding for visual comfort
  ggplot2::expand_limits(x = c(-1.15, 1.15), y = c(-1.15, 1.15))  

fig_bg + ggview::canvas(3.6,4.17,bg = "transparent",dpi = 600)

ggview::save_ggplot(fig_bg + ggview::canvas(3.6,4.17,bg = "transparent",dpi = 600),
                    "./infosc/bg.png")

attractor = figpatch::fig("./infosc/M.png")

fig_base = fig_bg +
  ggplot2::annotation_custom(
    grob = ggplot2::ggplotGrob(attractor),
    xmin = -1.275
  ) +
  ggview::canvas(3.6,4.17,bg = "transparent",dpi = 600)

ggview::save_ggplot(fig_base, "./infosc/base.png")
