# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

using LegendTestData
using Test

@testset "Package LegendTestData" begin

@info legend_test_data_path()
@test isdir(joinpath(legend_test_data_path(), "data"))

end # testset
