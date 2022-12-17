function campcleanup(file::String)
    n_assignment_pairs_contained = 0
    n_assignment_pairs_overlaps = 0
    open(file) do f
        while ! eof(f)
            assignment_pairs = readline(f)
            first_elf, second_elf = [split(x, '-') for x in split(assignment_pairs, ',')]
            first_elf = collect(parse(Int, first_elf[:1]):parse(Int, first_elf[:2]))
            second_elf = collect(parse(Int, second_elf[:1]):parse(Int, second_elf[:2]))
            n_assignment_pairs_contained += Int(issubset(first_elf, second_elf) || issubset(second_elf, first_elf))
            n_assignment_pairs_overlaps += Int(length(intersect(first_elf, second_elf))>0)
        end
    end
    return n_assignment_pairs_contained, n_assignment_pairs_overlaps
end

contained, overlaps = campcleanup("./input")
println("Total assignment pairs containing the other: ", contained)
println("Total assignment pairs overlaps the other: ", overlaps)
