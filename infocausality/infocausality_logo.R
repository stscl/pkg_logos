library(showtext)
showtext_auto(enable = TRUE)
font_add("ShineTypewriter", regular = "./ShineTypewriter-lgwzd.ttf")
library(hexSticker)
library(magick)

fig = sticker(
    subplot = "./infocausality/bg.png",
    s_x = 0.992,
    s_y = 1.003,
    s_width = 0.6,
    s_height = 0.6,
    package = "",
    p_family = "ShineTypewriter",
    p_size = 10.5,
    p_color = ggplot2::alpha("#efd298",.95),#ggplot2::alpha("#3e3221",.75),
    p_x = 1.00,
    p_y = 0.585,
    dpi = 300,
    asp = 1,
    h_size = 5.5,
    h_color = ggplot2::alpha("#6d4b2c",.95),
    h_fill = ggplot2::alpha('#efdab7',0.95),
    white_around_sticker = F,
    url = "https://stscl.github.io/infocausality",
    u_color = ggplot2::alpha("#6d4b2c",.95),
    u_size = 13.5,
    filename = "./infocausality/infocausality.png"
)

fig + ggview::canvas(1600,1800,units = "px",bg = "transparent") 

ggview::save_ggplot(fig + ggview::canvas(1600,1800,units = "px",bg = "transparent"),
                    "./infocausality/infocausality.png")

image_read('./infocausality/infocausality.png') |> 
  image_resize("240x278")|> 
  image_write('./infocausality/infocausality_logo.png')
