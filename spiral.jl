using GLMakie

GLMakie.activate!()
set_theme!(theme_black())

ps = Observable(Point2f[])
colors = Observable(Float64[])

f = Figure()
ax = Axis(f[1, 1], aspect=1, title="Spiral")
l = lines!(ps, color=colors, colormap=:inferno)
limits!(ax, -30, 30, -30, 30)

timestamps = range(0, 14pi, length=200)

record(f, "vids/spiral.mp4", timestamps; framerate=30) do t
  ps[] = push!(ps[], Point2f(cos(t) * t, sin(t) * t))
  colors[] = push!(colors[], Int(floor(t * 10)))
  l.colorrange = (0, Int(floor(t * 10)))
end