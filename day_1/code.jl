module Global
    elf_calories_array = Int[]
end

function caloriecounting(file::String)
    open(file) do f
        elf_calories = 0
    
        while ! eof(f)
            calories = readline(f)
            if calories == "" 
                push!(Global.elf_calories_array, elf_calories)
                elf_calories = 0
                continue
            end
            elf_calories += parse(Int, calories)
        end
    end
    sort!(Global.elf_calories_array, rev=true)
end

caloriecounting("./input")
top_3_elves = Global.elf_calories_array[1:3]
println("Top 3 elves: ", top_3_elves)
println("Sum of top 3 elves: ", sum(top_3_elves))
