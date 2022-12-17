function rucksackdivider(rucksack::String)
    half_rucksack_length = Int(length(rucksack)/2)
    return rucksack[1:half_rucksack_length], rucksack[half_rucksack_length+1:length(rucksack)]
end

function getpriorities(letter::Char)
    ascii_number = Int(letter)
    return ascii_number > 96 ? ascii_number - 96 : ascii_number - 38
end

function singlerucksackreorganization(file::String)
    total_priority = 0
    open(file) do f
        while ! eof(f)
            rucksack = readline(f)
            first_half, second_half = rucksackdivider(rucksack)
            common_item = first(intersect(first_half, second_half))
            total_priority += getpriorities(common_item)
        end
    end
    return total_priority
end

function grouprucksackreorganization(file::String)
    total_priority = 0
    open(file) do f
        group_rucksack = String[]
        while ! eof(f)
            rucksack = readline(f)
            push!(group_rucksack, rucksack)
            if length(group_rucksack) == 3
                badge = first(intersect(group_rucksack[:1], group_rucksack[:2], group_rucksack[:3]))
                total_priority += getpriorities(badge)
                group_rucksack = String[]
            end
        end
    end
    return total_priority
end

total_priority = singlerucksackreorganization("./input")
println("Total priority: ", total_priority)
group_total_priority = grouprucksackreorganization("./input")
println("Group total priority: ", group_total_priority)

