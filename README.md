# LegendTestData.jl

[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md)
[![Travis Build Status](https://travis-ci.com/legend-exp/LegendTestData.jl.svg?branch=master)](https://travis-ci.com/legend-exp/LegendTestData.jl)
[![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/github/legend-exp/LegendTestData.jl?branch=master&svg=true)](https://ci.appveyor.com/project/legend-exp/LegendTestData-jl)
[![Codecov](https://codecov.io/gh/legend-exp/LegendTestData.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/legend-exp/LegendTestData.jl)


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
