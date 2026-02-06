# --- Simulation Function ---

simulate_attractor = function(f, x0, y0, z0, steps = 1e4, dt = 0.01) {
  x = numeric(steps)
  y = numeric(steps)
  z = numeric(steps)
  
  x[1] = x0
  y[1] = y0
  z[1] = z0
  
  for (i in 1:(steps - 1)) {
    d = f(x[i], y[i], z[i])
    x[i + 1] = x[i] + dt * d$dx
    y[i + 1] = y[i] + dt * d$dy
    z[i + 1] = z[i] + dt * d$dz
  }
  
  cbind(x, y, z)
}

# --- Define Attractor Functions ---

# Lorenz Attractor
fLorenz = function(x, y, z, sigma = 10, rho = 35, beta = 8/3) {
  dx = sigma * (y - x)
  dy = x * (rho - z) - y
  dz = x * y - beta * z
  list(dx = dx, dy = dy, dz = dz)
}

# Hadley Attractor
fHadley = function(x, y, z, a = 0.3, b = 4, c = 8) {
  dx = -y^2 - z^2 - a * x + a * c
  dy = x * y - b * x * z - y + 1
  dz = b * x * y + x * z - z
  list(dx = dx, dy = dy, dz = dz)
}

# Thomas Attractor (single-lobed spiral)
fThomas = function(x, y, z, b = 0.208186) {
  dx = sin(y) - b * x
  dy = sin(z) - b * y
  dz = sin(x) - b * z
  list(dx = dx, dy = dy, dz = dz)
}

# Rössler Attractor
fRossler = function(x, y, z, a = 0.2, b = 0.2, c = 5.7) {
  dx = -y - z
  dy = x + a * y
  dz = b + z * (x - c)
  list(dx = dx, dy = dy, dz = dz)
}

# Halvorsen Attractor
fHalvorsen = function(x, y, z, a = 1.89) {
  dx = -a * x - 4 * y - 4 * z - y^2
  dy = -a * y - 4 * z - 4 * x - z^2
  dz = -a * z - 4 * x - 4 * y - x^2
  list(dx = dx, dy = dy, dz = dz)
}

# Dadras Attractor
fDadras = function(x, y, z, a = 3.0, b = 2.7, c = 1.7, d = 2.0, r = 9.0) {
  dx = y - a * x + b * y * z
  dy = c * y - x * z + z
  dz = d * x * y - r * z
  list(dx = dx, dy = dy, dz = dz)
}

# --- Latent Manifold ---

set.seed(42)
dadras = simulate_attractor(fDadras, 0.1, 0.3, 0.5)

plot3D::scatter3D(dadras[, 1], dadras[, 2], dadras[, 3],
                  colvar = NULL, pch = 19, col = "grey70",
                  theta = 45, phi = 60, cex = 0.105, bty = "n")

schematic_dir = "./sigcaus/"

png(filename = paste0(schematic_dir, "M.png"), 
    width = 800, height = 800, res = 150, bg = "transparent")

plot3D::scatter3D(dadras[, 1], dadras[, 2], dadras[, 3],
                  colvar = NULL, pch = 19, col = "#ECECEC",
                  theta = 45, phi = 60, cex = 0.25, 
                  bty = "n", axes = FALSE)

dev.off()
