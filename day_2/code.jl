module Global
    action_points = Dict("A"=>1, "B"=>2, "C"=>3)
    action_equivalent = Dict("X"=>"A", "Y"=>"B", "Z"=>"C")
    action_lose_cases = Dict("B"=>"X", "C"=>"Y", "A"=>"Z")
    action_win_cases = Dict("A"=>"Y", "B"=>"Z", "C"=>"X")
    game_result_points = Dict("W"=>6, "D"=>3, "L"=>0)
end

getpoints(option::String, game_result::String) = Global.action_points[option] + Global.game_result_points[game_result]

function getgameresult(fplayer_action::String, splayer_action::String)
    if fplayer_action == Global.action_equivalent[splayer_action]
        return "D"
    elseif (fplayer_action == "A" && splayer_action == "Z") ||
        (fplayer_action == "B" && splayer_action == "X") ||
        (fplayer_action == "C" && splayer_action == "Y")
        return "L"
    else
        return "W"
    end
end

function gettrickedaction(fplayer_action::String, splayer_action::String)
    if splayer_action == "X"
        return Global.action_lose_cases[fplayer_action]
    elseif splayer_action == "Y"
        return Dict(value => key for (key, value) in Global.action_equivalent)[fplayer_action]
    else
        return Global.action_win_cases[fplayer_action]
    end
end

function rockpaperscissors(file::String, tricked::Bool=false)
    total_score = 0
    open(file) do f
        while ! eof(f)
            game = readline(f)
            fplayer_action, splayer_action = split(game, ' ')
            splayer_action = tricked ? gettrickedaction(String(fplayer_action), String(splayer_action)) : splayer_action
            game_result = getgameresult(String(fplayer_action), String(splayer_action)) 
            total_score += getpoints(Global.action_equivalent[String(splayer_action)], game_result)
        end
    end
    return total_score
end

total_score = rockpaperscissors("./input")
println("Total score: ", total_score)
tricked_total_score = rockpaperscissors("./input", true)
println("Tricked total score: ", tricked_total_score)
