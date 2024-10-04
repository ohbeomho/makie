using GLMakie
GLMakie.activate!()
set_theme!(theme_black())

sin_points = Observable(Point2f[])
cos_points = Observable(Point2f[])
limit = Observable(-1.0)
timestamps = range(0, 10 * pi, step=1 / 7.5)

fig, ax = lines(sin_points)
lines!(ax, cos_points)

record(fig, "vids/wave.mp4", timestamps; framerate=30) do time
  sin_y = sin(time) * time
  cos_y = cos(time) * time
  sin_points[] = push!(sin_points[], Point2f(time, sin_y))
  cos_points[] = push!(cos_points[], Point2f(time, cos_y))

  limit[] = max(limit[], max(sin_y, cos_y) + 1, -(min(sin_y, cos_y) - 1))
  limits!(ax, 0, 10 * pi, -(limit[]), limit[])
end