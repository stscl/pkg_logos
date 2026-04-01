library(showtext)
showtext_auto(enable = TRUE)
font_add("ShineTypewriter", regular = "./ShineTypewriter-lgwzd.ttf")
library(hexSticker)
library(magick)

fig = sticker(
    subplot = "./infoxtr/symbol.png",
    s_x = 0.995,
    s_y = 0.935,
    s_width = 1.05,
    s_height = 1.05,
    package = "infoxtr",
    p_family = "ShineTypewriter",
    p_size = 12.5,
    p_color = ggplot2::alpha("#fdeaa0",.95),
    p_x = 1.00,
    p_y = 1.125,
    dpi = 300,
    asp = 1,
    h_size = 2.15,
    h_color = ggplot2::alpha("#3b3b45",1),
    h_fill = ggplot2::alpha('#2c2e35',0.95),
    white_around_sticker = T,
    # url = "https://stscl.github.io/infoxtr",
    # u_color = ggplot2::alpha("#6d4b2c",.95),
    # u_size = 4.55,
    filename = "./infoxtr/infoxtr.png"
)

# fig + ggview::canvas(1600,1800,units = "px",bg = "transparent") 

# ggview::save_ggplot(fig + ggview::canvas(1600,1800,units = "px",bg = "transparent"),
#                     "./infocaus/infocaus.png")

# image_read('./infocaus/infocaus.png') |> 
#   image_resize("240x278")|> 
#   image_write('./infocaus/infocaus_logo.png')
