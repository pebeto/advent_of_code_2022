function rucksackdivider(rucksack::String)
    half_rucksack_length = Int(length(rucksack)/2)
    return rucksack[1:half_rucksack_length], rucksack[half_rucksack_length+1:length(rucksack)]
end

function getpriorities(letter::Char)
    ascii_number = Int(letter)
    return ascii_number > 96 ? ascii_number - 96 : ascii_number - 38
end

function rucksackreorganization(file::String)
    single_total_priority = 0
    group_total_priority = 0
    open(file) do f
        group_rucksack = String[]
        while ! eof(f)
            rucksack = readline(f)
            push!(group_rucksack, rucksack)
            if length(group_rucksack) == 3
                badge = first(intersect(group_rucksack[:1], group_rucksack[:2], group_rucksack[:3]))
                group_total_priority += getpriorities(badge)
                group_rucksack = String[]
            end
            first_half, second_half = rucksackdivider(rucksack)
            common_item = first(intersect(first_half, second_half))
            single_total_priority += getpriorities(common_item)
        end
    end
    return single_total_priority, group_total_priority
end

single_total_priority, group_total_priority = rucksackreorganization("./input")
println("Total priority: ", single_total_priority)
println("Group total priority: ", group_total_priority)

