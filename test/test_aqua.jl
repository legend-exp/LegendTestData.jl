# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

import Test
import Aqua
import LegendTestData

Test.@testset "Package ambiguities" begin
    Test.@test isempty(Test.detect_ambiguities(LegendTestData))
end # testset

Test.@testset "Aqua tests" begin
    Aqua.test_all(
        LegendTestData,
        ambiguities = true
    )
end # testset
