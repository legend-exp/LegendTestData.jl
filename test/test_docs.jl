# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

using Test
using LegendTestData
import Documenter

Documenter.DocMeta.setdocmeta!(
    LegendTestData,
    :DocTestSetup,
    :(using LegendTestData);
    recursive=true,
)
Documenter.doctest(LegendTestData)
