# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

__precompile__(true)

module LegendTestData

legend_test_data_path() = joinpath(dirname(@__DIR__), "deps", "testdata")
export legend_test_data_path

end # module
