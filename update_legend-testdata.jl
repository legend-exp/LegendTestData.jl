import Pkg, Artifacts
Pkg.activate(temp = true)
Pkg.add(["ArtifactUtils", "HTTP", "JSON"])
using ArtifactUtils, Artifacts
import HTTP, JSON

pkg_dir = joinpath(dirname(@__DIR__), "LegendTestData")
cd(pkg_dir)
Pkg.activate(pkg_dir)

project_path = Pkg.project().path
project = Pkg.Types.read_project(project_path)
package_name = "LegendTestData"
@assert project.name == package_name

testdata_commit_info_url = "https://api.github.com/repos/legend-exp/legend-testdata/commits/main"
testdata_commit_id = JSON.parse(String(HTTP.get(testdata_commit_info_url).body))["sha"]
testdata_commit_id_short = testdata_commit_id[begin:begin+6]

artifact_id = add_artifact!(
    "Artifacts.toml",
    "legend_testdata",
    "https://api.github.com/repos/legend-exp/legend-testdata/tarball/" * testdata_commit_id,
    force = true
)
Pkg.ensure_artifact_installed("legend_testdata", "Artifacts.toml")
@info "Updated legend-testdata artifact"

main_src_file = joinpath("src", "LegendTestData.jl")

write(
    main_src_file,
    replace(
        read(main_src_file, String),
        r"const _legend_testdata_commit=\".*\"" => "const _legend_testdata_commit=\"$testdata_commit_id_short\""
    )
)
@info "Updated $main_src_file."

package_version = project.version
vmajor, vminor, vpatch = package_version.major, package_version.minor, package_version.patch
new_package_version = VersionNumber(vmajor, vminor, vpatch + 1)
project.version = new_package_version
Pkg.Types.write_project(project, project_path)
@assert Pkg.project().version == new_package_version
@info "Increased version of $package_name from $package_version to $new_package_version."

rm("Manifest.toml", force = true)
Pkg.test("LegendTestData")
rm("Manifest.toml", force = true)

git_branch = git_branch = strip(read(`git rev-parse --abbrev-ref HEAD`, String))
run(`git add "Project.toml" "Artifacts.toml" $main_src_file`)
run(`git commit -m "Update legend-testdata to $testdata_commit_id_short, increase package version to $new_package_version"`)
@info "Commited changes to package $package_name to branch $git_branch."
println("Run `git push origin $git_branch` to push the changes.")
