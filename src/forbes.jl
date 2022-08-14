using CSV, DataFrames, GLM, Plots

# read data
cd(@__DIR__)
df = DataFrame(CSV.File("../data/Forbes.csv"))

# visualize data
scatter(df.bp, df.pres, legend = :none, xlabel = "Temp", ylabel = "Pressure")
savefig("../fig/bp-pres.pdf")

scatter(df.bp, df.lpres, legend = :none, xlabel = "Temp", ylabel = "Lpres")
savefig("../fig/bp-lpres.pdf")

# fit model
res = fit(LinearModel, @formula(lpres ~ bp), df)

x0 = minimum(df.bp)
x1 = maximum(df.bp)
x = range(x0, x1, length = 20) |> collect
y = @. -42.138 + 0.895 * x

scatter(df.bp, df.lpres, legend = :none, xlabel = "Temp", ylabel = "Lpres")
plot!(x, y)
savefig("../fig/forbes-fit.pdf")

y0 = 139.60529 .* ones(20)
scatter(df.bp, df.lpres, legend = :none, xlabel = "Temp", ylabel = "Lpres")
plot!(x, y)
plot!(x, y0)

include("fdistribution.jl")
dx = range(0, 5, length = 1000) |> collect
dy = f_distribution.(dx, 1, 15)

plot(dx, dy, label = "F(1,15)", xlims=(0,1.46), ylims=(0,50))
savefig("../fig/fdistribution.pdf")
