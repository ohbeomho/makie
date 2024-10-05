using GLMakie
using Makie.Colors

GLMakie.activate!()
set_theme!(theme_black())

d = 0.01
sigma = 10
beta = 8 / 3
rho = 28

function next_pos(pos)
  x, y, z = pos
  nx = sigma * (y - x)
  ny = x * (rho - z) - y
  nz = x * y - beta * z
  Point3f(x + nx * d, y + ny * d, z + nz * d)
end

time = Observable(0.0)
ps = Observable(Point3f[])
colors = Observable(Float64[])
ps[] = push!(ps[], Point3f(1, 1, 1))

f = Figure()
ax = Axis3(f[1, 1], title="Lorenz Attractor")
l = lines!(ax, ps, color=colors, transparency=true)
limits!(ax, -30, 30, -30, 30, 0, 50)

record(f, "vids/lorenz.mp4", 1:240; framerate=30) do t
  time[] = t
  for i in 1:30
    ps[] = push!(ps[], next_pos(ps[][end]))
    colors[] = push!(colors[], t)
  end
  ax.azimuth = 1.275pi + sin(t * 0.05) * 0.5
  l.colorrange = (0, t)
end
