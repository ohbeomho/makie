using GLMakie

GLMakie.activate!()
set_theme!(theme_black())

a = Observable(-10.0)
xs = range(-30, 30, length=50)
ys = @lift(xs .* $a)

fig = Figure()
ax = Axis(fig[1, 1], title=@lift("y = $(round($a, digits = 1))x"))
lines!(ax, xs, ys)
limits!(ax, -30, 30, -30, 30)

rotation = range(-10, 10, length=120)

record(fig, "line.mp4", rotation; framerate=30) do t
  a[] = t
end