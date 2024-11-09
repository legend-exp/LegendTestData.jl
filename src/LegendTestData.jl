# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

# This file contains code from Pkg.operations, also licensed under the MIT License (MIT).


__precompile__(true)

module LegendTestData

using Artifacts


const _legend_testdata_commit="7c49ea9"

"""
    legend_test_data_path()::AbstractString

Get local path to the LEGEND test data set.

Will download the test data version matching the current version of
LegendTestData if not already present. The local copy of the test data is
managed via [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl).

Set `ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"` to avoid interactive prompt
asking for download permission.
"""
legend_test_data_path() = joinpath(artifact"legend_testdata", "legend-exp-legend-testdata-$_legend_testdata_commit")
export legend_test_data_path


"""
    activate_legend_test_data_config()

Set environment variable `"LEGEND_DATA_CONFIG"` to the LEGEND test data
configuration
"""
function activate_legend_test_data_config()
    testdata_dir = joinpath(legend_test_data_path(), "data", "legend")
    ENV["LEGEND_DATA_CONFIG"] = joinpath(testdata_dir, "config.json")
end
export activate_legend_test_data_config

end # module
