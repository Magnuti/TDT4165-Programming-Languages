functor
import
   System
define
   \insert List.oz

   % Task 3
   {System.showInfo 'Task 3:'}

   X = 100
   Y = 200
   Z = X + Y
   {System.showInfo Z}

   S = "Heisann"
   thread {System.showInfo P} end
   P = S

   {System.showInfo 'Thread?'}

   % Task 4
   {System.showInfo '\nTask 4:'}

   fun {Min X Y}
      if X < Y then
         X
      else
         Y
      end
   end

   fun {Max X Y}
      if X > Y then
         X
      else
         Y
      end
   end


   proc {PrintGreater X Y}
      if X > Y then
         {System.showInfo X}
      else
         {System.showInfo Y}
      end
   end

   {System.showInfo {Min 1000 500}}
   {System.showInfo {Max 1000 500}}
   {PrintGreater 25 35}

   % Task 5
   {System.showInfo '\nTask 5:'}

   proc {Circle R}
      local
         PI = 355.0 / 113.0
         A D C
      in
         A = PI * R * R
         D = 2.0 * R
         C = PI * D

         {System.printInfo 'Circle with radius: '}
         {System.show R}
         {System.printInfo 'Area: '}
         {System.show A}
         {System.printInfo 'Diameter: '}
         {System.show D}
         {System.printInfo 'Circumfence: '}
         {System.showInfo C}
      end
   end

   {Circle 10.0}

   % Task 6
   {System.showInfo '\nTask 6:'}

   fun {Factorial N}
      if N == 0 then
         1
      else
         N * {Factorial N - 1}
      end
   end

   {System.printInfo 'Factorial of 5: '}
   {System.show {Factorial 5}}

   % Task 7

   {System.showInfo '\nTask 7:'}

   MyList = [1 4 6 8 10 4]

   {System.printInfo 'List: '}
   {System.show MyList}

   {System.showInfo 'Task 7.a'}

   {System.printInfo 'Length of list is '}
   {System.showInfo {Length MyList}}

   {System.showInfo 'Task 7.b'}

   {System.printInfo 'First '}
   {System.printInfo 3}
   {System.printInfo ' elements in list are '}
   {System.show {Take MyList 3}}

   {System.showInfo 'Task 7.c'}

   {System.printInfo 'Last '}
   {System.printInfo 3}
   {System.printInfo ' elements of list are '}
   {System.show {Drop MyList 3}}

   {System.showInfo 'Task 7.d'}

   {System.printInfo 'List combined with [1 2] is '}
   {System.show {Append MyList [1 2]}}

   {System.showInfo 'Task 7.e'}

   {System.printInfo 'List contains 10: '}
   {System.show {Member MyList 10}}

   {System.showInfo 'Task 7.f'}

   {System.printInfo 'Position of 10 is '}
   {System.show {Position MyList 10}}

end