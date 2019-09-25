functor
import
    Application
    System
define

    % Task 1.a
    proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
        local D in
            D = B*B - 4.0*A*C
            if D >= 0.0 then
                RealSol = true
                X1 = (~B + {Float.sqrt D}) / (2.0 * A)
                X2 = (~B - {Float.sqrt D}) / (2.0 * A)
            else
                RealSol = false
            end
        end
    end

    /* Task 1.b
    Procedural abstractions are useful because we can wrap any statement in a package (proc ... end) and call
    it any time we want with desired arguments.
    The procedure is not executed until it is called; it creates a procedure value.
    Often results in less code since procedures can be reused.
    */

    /* Task 1.c
    A procedure doesn´t necessarily return anything, while a function have to return exactly one value.
    Every function is a procedure as well, only that the procedure have optional binding variables so it
    doens´t need the return values, but binds them instead.
     */

     % Task 2
     % Assuming all elements are of the same type (float, integer).
    fun {Sum List}
        case List of Head|Tail then
            Head + {Sum Tail}
        else
            0
        end
    end

    % Task 3.a
    fun {RightFold List Op U}
        case List of Head|Tail then
            {Op Head {RightFold Tail Op U}}
        else
            U
        end
    end

    /* Task 3.b
    The function takes in a list, an anonymous function which works like a binary operator and a return value
    for the else statement. The function recursivly calls itself by returning the binary operator function plus
    the function with the list tail. When the list is nil, the value U is returned; the base case.
    */

    % Task 3.c

    fun {Length3 List}
        {RightFold List fun {$ X Y} 1 + Y end 0}
    end

    fun {Sum3 List}
        {RightFold List fun {$ X Y} X + Y end 0}
    end

    /* Task 3.d
    For sum and lenght, a left fold would give the same result. A subtraction however can give different results:
    (((x1 - x2) - x3) - x4) for left fold and (x1 - (x2 - (x3 - x4))) for right flop.
    (((1 - 2) - 3) - 4) = -8 while (1 - (2 - (3 - 4))) = -2.
    */

    /* Task 3.e
    To get the product, the value U needs to be 1, since multiplying with 1 doens´t change the result.
    */

    % Task 4
    fun {Quadratic A B C}
        fun {$ X}
            A * X * X + B * X + C
        end
    end

    % Task 5.a
    fun {LazyNumberGenerator StartValue}
        local NextValue AnonFunction in
            NextValue = StartValue + 1
            AnonFunction = fun {$} {LazyNumberGenerator NextValue} end
            record(StartValue AnonFunction)
        end
    end

    /* Task 5.b
    The function works by returning a record. The record contains the current value
    and an anonymus function, which calls the original function with the intecremented startvalue.
    This can result in an infinite list which is built on demand. The anonymous function can be called
    as many times as you want and then call 1 to get the current value.
    */

    % Task 6.a and 6.b
    % The function in task 2 is not tail recursive, but the function below is.

    fun {SumL List U}
        case List of Head|Tail then
            {SumL Tail (U + Head)}
        else
            U
        end
    end
    /*
    With tail recursion we need an extra paramenter to the function to keep track of the state/counter.
    With normal recursion the value is not calculated until the base case is found, but with tail
    recursion each step involves a calculation which is passed to the next recursive call. The base case
    then returns the final result, without the need for any more computation.

    A benefit of tail recursion is that the stack stays at a constant size due to tail call optimization,
    where new stack frames aren´t allocated because the return value of the calling function is the return
    value of the called function. With normal recursion the stack will continue to grow until the base 
    case is found or in the worst case a stack overflow occurs.

    Task 6.c
    If the compiler can spot tail call recursion, the programming language will benefit from tail recursion.
    If not the stack will continue to grow because new stack frames are allocated on each function call.
    */

    /*
    MyList = [1 2 3 4 5 6]

    {System.showInfo "Task 1:"}
    local R A B in
        {QuadraticEquation 2.0 1.0 ~1.0 R A B}
        {System.show R#A#B}
    end
    local R A B in 
        {QuadraticEquation 2.0 1.0 2.0 R A B}
        {System.show R#A#B}
    end

    {System.showInfo "\nTask 2:"}
    {System.showInfo {Sum MyList}}

    {System.showInfo "\nTask 3:"}
    {System.showInfo {Length3 MyList}}
    {System.showInfo {Sum3 MyList}}

    {System.showInfo "\nTask 4:"}
    {System.show {{Quadratic 3 2 1} 2}}

    {System.showInfo '\nTask 5:'}
    {System.show {LazyNumberGenerator 0}.1} % shows 0
    {System.show {{LazyNumberGenerator 0}.2}.1} % shows 1
    {System.show {{{{{{LazyNumberGenerator 0}.2}.2}.2}.2}.2}.1} % shows 5
    
    {System.showInfo "\nTask 6:"}
    {System.show {SumL MyList 0}}
    */

    {Application.exit 0}
end