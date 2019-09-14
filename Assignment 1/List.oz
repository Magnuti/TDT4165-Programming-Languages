% Append function taken from documentation, need help with it.
fun {Append List1 List2}
    case List1 of nil then
        List2
    [] X|Xr then
        X|{Append Xr List2}
    end
end

fun {Length List}
    if List.2 == nil then
        1
    else
        1 + {Length List.2}
    end
end

fun {Take List Count}
    if Count >= {Length List} then
        List
    elseif Count == 1 then
        [List.1]
    else
        {Append [List.1] {Take List.2 Count-1}}
    end
end

fun {Drop List Count}
    if Count >= {Length List} then
        nil
    elseif Count == 1 then
        List.2
    else
        {Drop List.2 Count-1}
    end
end

fun {Member List Element}
    if List.1 == Element then
        true
    else
        if {Length List} > 1 then
            {Member List.2 Element}
        else
            false
        end
    end
end

fun {Position List Element}
    if {Member List Element} then
        if List.1 == Element then
            0
        else
            1 + {Position List.2 Element}
        end
    else
        ~1
    end
end