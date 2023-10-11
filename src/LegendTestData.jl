# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

# This file contains code from Pkg.operations, also licensed under the MIT License (MIT).


__precompile__(true)

module LegendTestData

using Artifacts


"""
    legend_test_data_path()::AbstractString

Get local path to the LEGEND test data set.

Will download the test data version matching the current version of
LegendTestData if not already present. The local copy of the test data is
managed via [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl).

Set `ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"` to avoid interactive prompt
asking for download permission.
"""
legend_test_data_path() = joinpath(artifact"legend_testdata", "legend-exp-legend-testdata-32262e4")
export legend_test_data_path


end # module
