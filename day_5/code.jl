function loadinitialconfig(file::String)
    movements = Array[]
    stacks = Dict()
    open(file) do f
        while ! eof(f)
            line = readline(f)
            if occursin("move", line)
                line = replace(line, "move"=>"")
                line = replace(line, "from"=>"")
                line = replace(line, "to"=>"")
                line = split(line, "  ")
                push!(movements, [parse(Int, line[:1]), parse(Int, line[:2]), parse(Int, line[:3])])
            else
                positions = (findall(==('['), line))
                cargo = [line[pos+1] for pos in positions]
                cargo_position = ceil.(Int, positions./4)
                for i in range(1, length(cargo_position))
                    if ~haskey(stacks, cargo_position[i])
                        stacks[cargo_position[i]] = Char[]
                    end
                    push!(stacks[cargo_position[i]], cargo[i])
                end
            end
        end
    end
    return movements, stacks
end

getlaststackselementsstring(stacks::Dict) = join([first(stacks[i]) for i in sort(collect(keys(stacks)))])

function startcraneoperation(movements::Array, stacks::Dict, multiple::Bool=false)
    temp_stacks = deepcopy(stacks)
    for mov in movements
        n_crates, orig, dest = mov
        if multiple
            stack_length = length(temp_stacks[orig])
            crane_crates = splice!(temp_stacks[orig], 1:n_crates)
            prepend!(temp_stacks[dest], crane_crates)
        else
            for i = 1:n_crates
                crane_crate = popfirst!(temp_stacks[orig])
                prepend!(temp_stacks[dest], crane_crate)
            end
        end
    end
    return temp_stacks
end

movements, stacks = loadinitialconfig("./input")
cratemover9000_operation = startcraneoperation(movements, stacks)
println("Last stacks elements (CrateMover 9000): ", getlaststackselementsstring(cratemover9000_operation))
cratemover9001_operation = startcraneoperation(movements, stacks, true)
println("Last stacks elements: (CrateMover 9001): ", getlaststackselementsstring(cratemover9001_operation))
