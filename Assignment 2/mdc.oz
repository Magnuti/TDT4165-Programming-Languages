\insert List.oz

fun {Lex Input}
    {String.tokens Input & }
end

fun {Tokenize Lexems}
    local X in
        if Lexems.1 == "+" then
            X = operator(type:'plus')
        elseif Lexems.1 == "-" then
            X = operator(type:'minus')
        elseif Lexems.1 == "*" then
            X = operator(type:'multiply')
        elseif Lexems.1 == "/" then
            X = operator(type:'divide')
        elseif Lexems.1 == "p" then
            X = command(print)
        elseif Lexems.1 == "d" then
            X = command(duplicatetop)
        elseif Lexems.1 == "i" then
            X = command(inverttop)
        elseif Lexems.1 == "^" then
            X = command(multiinvert)
        else
            try
                X = number({String.toFloat Lexems.1})
            catch error(...) then
                raise 'Invalid input' end
            end
        end

        if Lexems.2 == nil then
            [X]
        else
            {Append [X] {Tokenize Lexems.2}}
        end
    end
end

fun {Interpret Tokens}
    {InterpretWithStack Tokens [nil]}
end

% TODO
% Assuming input is valid, add code later
fun {InterpretWithStack Tokens Stack}
    if {ContainsOperators Tokens} then

        if {Record.label Tokens.1} == 'number' then
            if Stack == [nil] then

                %{System.show '-'}
                %{System.show Tokens}
                %{System.show Stack}

                {InterpretWithStack Tokens.2 [Tokens.1]}
            else
                {InterpretWithStack Tokens.2 {Append [Tokens.1] Stack}}
            end
        elseif {Record.label Tokens.1} == 'command' then
            if Tokens.1.1 == 'print' then
                {System.show {List.reverse Stack}}
                if Tokens.2 == nil then
                    {InterpretWithStack Stack [nil]}
                else
                    {InterpretWithStack Tokens.2 Stack}
                end
            elseif Tokens.1.1 == 'duplicatetop' then
                local NewStack in
                    NewStack = {Append [Stack.1] Stack}
                    if Tokens.2 == nil then
                        {InterpretWithStack {List.reverse NewStack} [nil]}
                    else
                        {InterpretWithStack Tokens.2 NewStack}
                    end
                end
            elseif Tokens.1.1 == 'inverttop' then
                local NewStack TopStackValue in
                    TopStackValue = ~Stack.1.1
                    NewStack = {Append [number(TopStackValue)] {Drop Stack 1}}
                    if Tokens.2 == nil then
                        {InterpretWithStack {List.reverse NewStack} [nil]}
                    else
                        {InterpretWithStack Tokens.2 NewStack}
                    end
                end
            elseif Tokens.1.1 == 'multiinvert' then
                local NewStack TopStackValue in
                    TopStackValue =  1.0 / Stack.1.1 % Assuming float
                    NewStack = {Append [number(TopStackValue)] {Drop Stack 1}}
                    if Tokens.2 == nil then
                        {InterpretWithStack NewStack [nil]}
                    else
                        {InterpretWithStack Tokens.2 NewStack}
                    end
                end
            else
                {System.show 'Unknown command'}
                raise 'Illegal command' end
            end
        % Add elseif for operator, else raise exception
        else
            local Number NewStack StackAfterDrop in

                if Tokens.1.type == 'plus' then
                    Number = number(Stack.2.1.1 + Stack.1.1)
                elseif Tokens.1.type == 'minus' then
                    Number = number(Stack.2.1.1 - Stack.1.1)
                elseif Tokens.1.type == 'multiply' then
                    Number = number(Stack.2.1.1 * Stack.1.1)
                elseif Tokens.1.type == 'divide' then
                    Number = number(Stack.2.1.1 / Stack.1.1) % Assuming float
                else
                    raise 'Illegal operator' end
                end

                StackAfterDrop = {Drop Stack 2}
                if StackAfterDrop == nil then
                    NewStack = [Number]
                else
                    NewStack = {Append [Number] StackAfterDrop}
                end

                %{System.show NewStack}
                %{System.show StackAfterDrop}

                {InterpretWithStack {Append {List.reverse NewStack} Tokens.2} [nil]}
            end
        end
    else
        %{System.showInfo 'Value of RPN:'}
        % Reverse the list to get stack on top
        if Stack == [nil] then
            Tokens
        else
            {Append {List.reverse Stack} Tokens}
            %{List.reverse {Append Tokens Stack}} % Fix this
        end
    end
end

fun {ContainsOperators List}
    if {Record.label List.1} == 'operator' then
        true
    elseif {Record.label List.1} == 'command' then
        true
    else
        if List.2 == nil then
            false
        else
            {ContainsOperators List.2}
        end
    end
end

% Assuming valid infix expression as input
fun {Infix Tokens}
    {InfixInternal Tokens [nil]}
end

% Each expression record in the ExpressionStack represent an (...)
fun {InfixInternal Tokens ExpressionStack}
    %{System.show '-'}
    %{System.show Tokens}
    %{System.show ExpressionStack}
    if Tokens == nil then
        ExpressionStack.1.1
    else
        if {Record.label Tokens.1} == 'number' then
            {InfixInternal Tokens.2 {Append [expression([{Float.toString Tokens.1.1}])] ExpressionStack}}
        else
            local NewStack StackAfterDrop ExpressionString A B C in
                if {Record.label Tokens.1} == 'command' then
                    if Tokens.1.1 == 'inverttop' then
                        ExpressionString = expression({Append ["i"] ExpressionStack.1.1})
                    elseif Tokens.1.1 == 'multiinvert' then
                        ExpressionString = expression({Append ["1 /"] ExpressionStack.1.1})
                    else
                        raise 'Illegal command' end
                    end

                    StackAfterDrop = {Drop ExpressionStack 1}
                elseif {Record.label Tokens.1} == 'operator' then

                    if Tokens.1.type == 'plus' then
                        A = {Append ExpressionStack.1.1 [")"]}
                        B = {Append ["+"] A}
                        C = {Append ExpressionStack.2.1.1 B}
                        ExpressionString = expression({Append ["("] C})
                    elseif Tokens.1.type == 'minus' then
                        A = {Append ExpressionStack.1.1 [")"]}
                        B = {Append ["-"] A}
                        C = {Append ExpressionStack.2.1.1 B}
                        ExpressionString = expression({Append ["("] C})
                    elseif Tokens.1.type == 'multiply' then
                        A = {Append ["*"]  ExpressionStack.1.1}
                        ExpressionString = expression({Append ExpressionStack.2.1.1 A})
                    elseif Tokens.1.type == 'divide' then
                        A = {Append ["/"]  ExpressionStack.1.1}
                        ExpressionString = expression({Append ExpressionStack.2.1.1 A})
                    else
                        raise 'Illegal operator' end
                    end

                    StackAfterDrop = {Drop ExpressionStack 2}
                else
                    raise 'Illegal record' end
                end

                NewStack = {Append [ExpressionString] StackAfterDrop}
                {InfixInternal Tokens.2 NewStack}
            end
        end
    end
end