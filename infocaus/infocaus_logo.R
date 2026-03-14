library(showtext)
showtext_auto(enable = TRUE)
font_add("ShineTypewriter", regular = "./ShineTypewriter-lgwzd.ttf")
library(hexSticker)
library(magick)

fig = sticker(
    subplot = "./infocaus/symbol.png",
    s_x = 0.992,
    s_y = 1.035,
    s_width = 0.6,
    s_height = 0.6,
    package = "infocaus",
    p_family = "ShineTypewriter",
    p_size = 12.5,
    p_color = ggplot2::alpha("#6d4a29",.95),#ggplot2::alpha("#3e3221",.75),
    p_x = 1.00,
    p_y = 0.305,
    dpi = 300,
    asp = 1,
    h_size = 2.15,
    h_color = ggplot2::alpha("#6d4b2c",.95),
    h_fill = ggplot2::alpha('#efdab7',0.95),
    white_around_sticker = F,
    url = "https://stscl.github.io/infocaus",
    u_color = ggplot2::alpha("#6d4b2c",.95),
    u_size = 4.55,
    filename = "./infocaus/infocaus.png"
)

# fig + ggview::canvas(1600,1800,units = "px",bg = "transparent") 

# ggview::save_ggplot(fig + ggview::canvas(1600,1800,units = "px",bg = "transparent"),
#                     "./infocaus/infocaus.png")

image_read('./infocaus/infocaus.png') |> 
  image_resize("240x278")|> 
  image_write('./infocaus/infocaus_logo.png')
