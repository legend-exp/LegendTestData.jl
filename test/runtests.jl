# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

using LegendTestData
using PropDicts
import JSON, YAML
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
        crystal_metadata_file = joinpath(crystal_metadata_dir, "V99000.yaml")
        @test isfile(crystal_metadata_file)
        crystal_metadata = readprops(crystal_metadata_file)
        @test haskey(crystal_metadata, :impurity_measurements)
        @test haskey(crystal_metadata.impurity_measurements, :value_in_1e9e_cm3)
        @test haskey(crystal_metadata.impurity_measurements, :distance_from_seed_end_mm)
        @test crystal_metadata.impurity_measurements.value_in_1e9e_cm3 == [8, 9, 10, 10, 11]
        @test crystal_metadata.impurity_measurements.distance_from_seed_end_mm == [0, 14, 30, 50, 80]
    end

    @testset "Check for example HDF5 files" begin
	rawdir = joinpath(legend_test_data_path(), "data", "lh5", "prod-ref-l200", "generated", "tier", "raw")
	@test isdir(rawdir)
	@test isfile(joinpath(rawdir, "aph", "p13", "r007", "l200-p13-r007-aph-20250101T003931Z-tier_raw.lh5"))
	@test isfile(joinpath(rawdir, "cal", "p14", "r005", "l200-p14-r004-cal-20250606T010224Z-tier_raw.lh5"))
    end

    @testset "Test data config" begin
        ENV["LEGEND_DATA_CONFIG"] = ""

        activate_old_legend_test_data_config()
        @test isfile(ENV["LEGEND_DATA_CONFIG"])
        @test endswith(ENV["LEGEND_DATA_CONFIG"], ".json")

        activate_legend_test_data_config()
        @test isfile(ENV["LEGEND_DATA_CONFIG"])
        @test endswith(ENV["LEGEND_DATA_CONFIG"], ".yaml")

        @testset "Test datasets" begin
            datasets_dir = joinpath(legend_test_data_path(), "data", "legend", "metadata", "datasets")
            @test isdir(datasets_dir)
            @test isfile(joinpath(datasets_dir, "cal_groupings.yaml"))
            @test isfile(joinpath(datasets_dir, "phy_groupings.yaml"))
        end
    end
end # testset

include("test_docs.jl")
