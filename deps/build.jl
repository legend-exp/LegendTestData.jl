# This file is a part of LegendTestData.jl, licensed under the MIT License (MIT).

# This file contains code from Pkg.operations, also licensed under the MIT License (MIT).

using Random
import BinaryProvider


# Slightly modified version of Pkg.operations.get_github_archive_url
function get_archive_url_for_version(url::String, ref::Union{String,Base.SHA1})
    if (m = match(r"https://github.com/(.*?)/(.*?).git", url)) != nothing
        return "https://api.github.com/repos/$(m.captures[1])/$(m.captures[2])/tarball/$(ref)"
    end
    return nothing
end


# Slightly modified version of Pkg.operations.install_archive
function install_github_archive(
    urls::Vector{String},
    ref::Union{String,Base.SHA1},
    version_path::String
)::Bool
    for url in urls
        archive_url = get_archive_url_for_version(url, ref)
        if archive_url != nothing
            path = tempname() * randstring(6) * ".tar.gz"
            url_success = true
            cmd = BinaryProvider.gen_download_cmd(archive_url, path);
            try
                run(cmd, (devnull, devnull, devnull))
            catch e
                e isa InterruptException && rethrow()
                url_success = false
            end
            url_success || continue
            dir = joinpath(tempdir(), randstring(12))
            mkpath(dir)
            cmd = BinaryProvider.gen_unpack_cmd(path, dir);
            # Might fail to extract an archive (Pkg#190)
            try
                run(cmd, (devnull, devnull, devnull))
            catch e
                e isa InterruptException && rethrow()
                @warn "failed to extract archive downloaded from $(archive_url)"
                url_success = false
            end
            url_success || continue
            dirs = readdir(dir)
            # 7z on Win might create this spurious file
            filter!(x -> x != "pax_global_header", dirs)
            @assert length(dirs) == 1
           !isdir(version_path) && mkpath(version_path)
            mv(joinpath(dir, dirs[1]), version_path; force=true)
            Base.rm(path; force = true)
            Base.rm(dir; force = true)
            return true
        end
    end
    return false
end


install_github_archive(["https://github.com/legend-exp/legend-testdata.git"], "dev", joinpath(pwd(), "testdata"))
