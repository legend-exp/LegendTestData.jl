# Use
#
#     DOCUMENTER_DEBUG=true julia --color=yes make.jl local [nonstrict] [fixdoctests]
#
# for local builds.

using Documenter
using LegendTestData

# Doctest setup
DocMeta.setdocmeta!(
    LegendTestData,
    :DocTestSetup,
    :(using LegendTestData);
    recursive=true,
)

makedocs(
    sitename = "LegendTestData",
    modules = [LegendTestData],
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        canonical = "https://legend-exp.github.io/LegendTestData.jl/stable/"
    ),
    pages = [
        "Home" => "index.md",
        "API" => "api.md",
        "LICENSE" => "LICENSE.md",
    ],
    doctest = ("fixdoctests" in ARGS) ? :fix : true,
    linkcheck = !("nonstrict" in ARGS),
    warnonly = ("nonstrict" in ARGS),
)

deploydocs(
    repo = "github.com/legend-exp/LegendTestData.jl.git",
    forcepush = true,
    push_preview = true,
)
