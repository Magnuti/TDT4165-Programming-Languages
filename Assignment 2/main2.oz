functor
import
    System
define
    \insert mdc.oz

    proc {PrintList List}
        for X in List do
            {System.printInfo X#' '}
        end
        %{System.printInfo ' = '}
        %{System.show List}
        {System.showInfo ''}
    end

    proc {TestA}
        {System.showInfo '\n--- Test A ---'}
        {System.showInfo 'Should be:'}
        {System.show ["1" "2" "+" "3" "*"]}
        {System.showInfo 'Actual'}
        {System.show {Lex "1 2 + 3 *"}}
    end

    proc {TestB}
        {System.showInfo '\n--- Test B ---'}
        {System.showInfo 'Should be:'}
        {System.show [number(1.0) number(2.0) operator(type:plus) number(3.0) operator(type:multiply)]}
        {System.showInfo 'Actual'}
        {System.show {Tokenize ["1" "2" "+" "3" "*"]}}
    end

    proc {TestC}
        {System.showInfo '\n--- Test C ---'}
        {System.showInfo 'Should be:'}
        {System.show [number(1) number(5)]}
        {System.showInfo 'Actual'}
        {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}
    end

    proc {TestD}
        {System.showInfo '\n--- Test D ---'}
        {System.showInfo 'Should be:'}
        {System.show [number(1) number(2) number(3)]}
        {System.show [number(1) number(5)]}
        {System.showInfo 'Actual'}
        {System.show {Interpret {Tokenize {Lex "1 2 3 p +"}}}}
    end

    proc {TestE}
        {System.showInfo '\n--- Test E ---'}
        {System.showInfo 'Should be:'}
        {System.show [number(1) number(5) number(5)]}
        {System.showInfo 'Actual'}
        {System.show {Interpret {Tokenize {Lex "1 2 3 + d"}}}}
    end

    proc {TestF}
        {System.showInfo '\n--- Test F ---'}
        {System.showInfo 'Should be:'}
        {System.show [number(1) number(~20)]}
        {System.showInfo 'Actual'}
        {System.show {Interpret {Tokenize {Lex "1 10 i 30 + i"}}}}
    end

    proc {TestG}
        {System.showInfo '\n--- Test G ---'}
        {System.showInfo 'Should be:'}
        {System.show [number(1.0/4.5)]}
        {System.showInfo 'Actual'}
        {System.show {Interpret {Tokenize {Lex "1 2 ^ + 3 + ^"}}}}
    end

    %Input = "15 7 1 1 + - / 3 * 2 1 1 + + -" % = 5 from Wikipedia
    %Input = "1 2 + 3"
    %{PrintList {Lex Input}}
    %{System.show {Tokenize {Lex Input}}}
    %{System.show {Interpret {Tokenize {Lex Input}}}}

    {TestA}
    {TestB}
    {TestC}
    {TestD}
    {TestE}
    {TestF}
    {TestG}

    {PrintList {Infix {Tokenize {Lex "3.0 10.0 9.0 * - 0.3 +"}}}}
    {PrintList {Infix {Tokenize {Lex "1.0 2.0 3.0 + -"}}}}
    {PrintList {Infix {Tokenize {Lex "1 2 + ^"}}}}
    {PrintList {Infix {Tokenize {Lex "1 2 i +"}}}}

    {PrintList {Infix {Tokenize {Lex "3 2 + 50 2 25 * / 200 * - 5 2 * 2 - 100 / +"}}}}
    {System.show {Interpret {Tokenize {Lex "3 2 + 50 2 25 * / 200 * - 5 2 * 2 - 100 / +"}}}}
end