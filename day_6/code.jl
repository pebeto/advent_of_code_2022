function detectmarker(signal::String)
    for c = signal
        if count(==(c), signal) > 1
            return false
        end
    end
    return true
end

function markdetector(file::String)
    open(file) do f
        while ! eof(f)
            signal = readline(f)

            detected_sop_index = nothing
            detected_som_index = nothing
            for i = range(1, length(signal))
                if i + 3 > length(signal) || i + 13 > length(signal)
                    continue
                end
                sop_marker = signal[i:i+3]
                som_marker = signal[i:i+13]
                println(sop_marker, '-', som_marker)

                if detectmarker(sop_marker)
                    detected_sop_index = detected_sop_index != nothing ? detected_sop_index : i
                end
                if detectmarker(som_marker)
                    detected_som_index = detected_som_index != nothing ? detected_som_index : i
                end
                if detected_sop_index != nothing && detected_som_index != nothing
                    println("SOP chars before mark: ", length(signal[1:detected_sop_index+3]))
                    println("SOM chars before mark: ", length(signal[1:detected_som_index+13]))
                    break
                end
            end
        end
    end
end

markdetector("./input")
