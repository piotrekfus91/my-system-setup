function format_time
    set time $argv[1]
    if [ $time -gt (math "1000 * 60 * 60") ]
        set hours (math $time / (math "1000 * 60 * 60"))
        set minutes (math (math $time / (math "1000 * 60")) "%" 60)
        set seconds (math (math $time / 1000) "%" 60)
        set milliseconds (math "$time % 1000")
        echo $hours"h" $minutes"min" $seconds"s" $milliseconds"ms"
    else if [ $time -gt (math "1000 * 60") ]
        set minutes (math $time / (math "1000 * 60"))
        set seconds (math (math $time / 1000) "%" 60)
        set milliseconds (math $time "%" 1000)
        echo $minutes"min" $seconds"s" $milliseconds"ms"
    else if [ $time -gt 1000 ]
        set seconds (math $time / 1000)
        set milliseconds (math "$time % 1000")
        echo $seconds"s" $milliseconds"ms"
    else
        echo $time ms
    end
end
