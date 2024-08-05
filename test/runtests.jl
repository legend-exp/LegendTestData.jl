# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

using LegendTestData
using PropDicts
using Test

include("test_aqua.jl")

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
        @test haskey(invcoax.production, :enrichment)
        @test invcoax.production.enrichment isa PropDict
        @test haskey(invcoax.production.enrichment, :val) && haskey(invcoax.production.enrichment, :unc)
    end

    @testset "Crystal metadata" begin
        crystal_metadata_dir = joinpath(legend_test_data_path(), "data", "legend", "metadata", "hardware", "detectors", "germanium", "crystals")
        @test isdir(crystal_metadata_dir)
        crystal_metadata_file = joinpath(crystal_metadata_dir, "V99000.json")
        @test isfile(crystal_metadata_file)
        crystal_metadata = readprops(crystal_metadata_file)
        @test haskey(crystal_metadata, :impurity_measurements)
        @test haskey(crystal_metadata.impurity_measurements, :value_in_1e9e_cm3)
        @test haskey(crystal_metadata.impurity_measurements, :distance_from_seed_end_mm)
        @test crystal_metadata.impurity_measurements.value_in_1e9e_cm3 == [8, 9, 10, 10, 11]
        @test crystal_metadata.impurity_measurements.distance_from_seed_end_mm == [0, 14, 30, 50, 80]
    end

    @testset "Test data config" begin
        ENV["LEGEND_DATA_CONFIG"] = ""
        activate_legend_test_data_config()
        @test isfile(ENV["LEGEND_DATA_CONFIG"])
    end
end # testset

include("test_docs.jl")
