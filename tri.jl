using GLMakie

a = Observable(0.0)
tri1 = @lift([0 0; cos($a) sin($a); 0 0; cos($a) 0; cos($a) sin($a); cos($a) 0])
tri2 = @lift([0 0; 1 tan($a); 0 0; 1 0; 1 tan($a); 1 0])

fig = Figure()
Axis(fig[1, 1], title="Trigonometric ratios")
limits!(-0.5, 1.5, -0.5, 1.5)
linesegments!(tri2, color=[RGBAf(0, 0, 0, 0.5), :black, :blue])
linesegments!(tri1, color=[:black, :red, :green])
text!(-0.05, -0.05, text="A", align=(:left, :center))
text!(-0.25, 0.6, text=@lift("sin A = $(floor(sin($a), digits=3))"), color=:green, align=(:center, :center))
text!(-0.25, 0.4, text=@lift("cos A = $(floor(cos($a), digits=3))"), color=:red, align=(:center, :center))
text!(1.25, 0.5, text=@lift("tan A = $($a == pi / 2 ? "∞" : floor(tan($a), digits=3))"), color=:blue, align=(:center, :center))

timestamps = range(0, pi / 2, length=200)

record(fig, "tri.mp4", timestamps; framerate=30) do t
  a[] = t
end