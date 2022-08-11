using CSV, DataFrames, GLM, Plots

# read data
cd(@__DIR__)
df = DataFrame(CSV.File("../data/fuel2001.csv"))
df.IncomeN = df.Income ./ 1000

# visualize data
scatter(df.Pop, df.FuelC, legend = :none)
savefig("../fig/pop-fuelc.pdf")

scatter(df.Miles, df.FuelC, legend = :none)
savefig("../fig/miles-fuelc.pdf")

scatter(df.IncomeN, df.FuelC, legend = :none)
savefig("../fig/income-fuelc.pdf")

scatter(df.Tax, df.FuelC, legend = :none)
savefig("../fig/tax-fuelc.pdf")

# process data
Fuel = @. 1000 * df.FuelC / df.Pop
Dlic = @. 1000 * df.Drivers / df.Pop
Logmiles = log2.(df.Miles)

df.Fuel = Fuel
df.Dlic = Dlic
df.Logmiles = Logmiles

scatter(df.Tax, df.Fuel, legend = :none)
savefig("../fig/tax-fuel.pdf")

scatter(df.Dlic, df.Fuel, legend = :none)
savefig("../fig/dlic-fuel.pdf")

scatter(df.IncomeN, df.Fuel, legend = :none)
savefig("../fig/income-fuel.pdf")

scatter(df.Logmiles, df.Fuel, legend = :none)
savefig("../fig/logmiles-fuel.pdf")

# fit model
res = fit(LinearModel, @formula(Fuel ~ Tax + Dlic + IncomeN + Logmiles), df)
