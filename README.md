# LegendTestData.jl

[![Documentation for stable version](https://img.shields.io/badge/docs-stable-blue.svg)](https://legend-exp.github.io/LegendTestData.jl/stable)
[![Documentation for development version](https://img.shields.io/badge/docs-dev-blue.svg)](https://legend-exp.github.io/LegendTestData.jl/dev)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md)
[![Build Status](https://github.com/legend-exp/LegendTestData.jl/workflows/CI/badge.svg?branch=main)](https://github.com/legend-exp/LegendTestData.jl/actions?query=workflow%3ACI)
[![Codecov](https://codecov.io/gh/legend-exp/LegendTestData.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/legend-exp/LegendTestData.jl)


## Documentation

* [Documentation for stable version](https://legend-exp.github.io/LegendTestData.jl/stable)
* [Documentation for development version](https://legend-exp.github.io/LegendTestData.jl/dev)


Julia package to provide access to the [LEGEND Test Data](https://github.com/legend-exp/legend-testdata).

Test data is downloaded and installed on package build:

```julia
import Pkg
Pkg.build("LegendTestData")
```

Use `legend_test_data_path()` to get the location of the test data:

```julia
using LegendTestData
legend_test_data_path()
```
