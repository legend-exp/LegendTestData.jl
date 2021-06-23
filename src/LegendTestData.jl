# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

# This file contains code from Pkg.operations, also licensed under the MIT License (MIT).


__precompile__(true)

module LegendTestData

using DataDeps


const testdata_url = "https://github.com/legend-exp/legend-testdata.git"
const testdata_version = "8d67659"


# Slightly modified version of Pkg.operations.get_github_archive_url
function github_tarball_url(url::String, ref::Union{String,Base.SHA1})
    if (m = match(r"https://github.com/(.*?)/(.*?).git", url)) != nothing
        return "https://api.github.com/repos/$(m.captures[1])/$(m.captures[2])/tarball/$(ref)"
    end
    return nothing
end


function unpack_strip_toplevel(f)
    unpack(f)
    for d in readdir(pwd())
        @assert startswith(d, "legend-exp-legend-testdata")
        for f in readdir(joinpath(pwd(), d))
            mv(joinpath(d, f), joinpath(pwd(), f))
        end
        rm(d)
    end
end


"""
    legend_test_data_path()::AbstractString

Get local path to the LEGEND test data set.

Will download the test data version matching the current version of
LegendTestData if not already present. The local copy of the test data is
managed via [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl).

Set `ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"` to avoid interactive prompt
asking for download permission.
"""
legend_test_data_path() = @datadep_str "legend-testdata-$(testdata_version)"
export legend_test_data_path


function __init__()
    register(
        DataDep(
            "legend-testdata-$(testdata_version)",
            """
            Dataset: LEGEND Test Data
            Authors: The LEGEND Collaboration
            Website: $(testdata_url)
            """,
            [github_tarball_url(testdata_url, testdata_version)],
            post_fetch_method = unpack_strip_toplevel
        )
    );
end


end # module
