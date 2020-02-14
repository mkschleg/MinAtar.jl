

# using Pkg; Pkg.install("Conda");
using Conda
using PyCall

if findfirst("pip", read(`$(Conda.conda) list`, String)) == nothing
    Conda.add("pip")
    Conda.add("git")
end

if findfirst("minatar", read(`$(Conda.conda) list`, String)) == nothing
    pycmd = PyCall.python
    run(`$pycmd -m pip install git+https://github.com/kenjyoung/MinAtar.git`)
end
# end

