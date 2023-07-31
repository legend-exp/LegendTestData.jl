# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

using LegendTestData
using PropDicts
using Test

@testset "Package LegendTestData" begin

    @info legend_test_data_path()
    @test isdir(joinpath(legend_test_data_path(), "data"))

    @testset "Inverted coax metadata" begin
        invcoax_metadata = joinpath(legend_test_data_path(), "data", "ldsim", "invcoax-metadata.json")
        @test isfile(invcoax_metadata)
        invcoax = readprops(invcoax_metadata)
        @test haskey(invcoax.geometry.borehole, :depth_in_mm)
        @test invcoax.geometry.borehole.depth_in_mm == 55
        @test !haskey(invcoax.geometry.borehole, :gap_in_mm)
    end

end # testset
