using GLMakie
using Makie.Colors

GLMakie.activate!()
set_theme!(theme_black())

d = 0.01
sigma = 10
beta = 8 / 3
rho = 30

function next_pos(pos)
  x, y, z = pos
  nx = sigma * (y - x)
  ny = x * (rho - z) - y
  nz = x * y - beta * z
  Point3f(x + nx * d, y + ny * d, z + nz * d)
end

time = Observable(0.0)
ps = Observable(Point3f[])
ps[] = push!(ps[], Point3f(1, 1, 1))

f = Figure()
ax = Axis3(f[1, 1], title="Lorenz Attractor")
lines!(ax, ps)
limits!(ax, -30, 30, -30, 30, 0, 50)

record(f, "vids/lorenz.mp4", 1:1200; framerate=100) do t
  time[] = t
  ps[] = push!(ps[], next_pos(ps[][end]))
  ax.azimuth = 1.275pi + sin(t * d) * 0.5
end
