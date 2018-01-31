-- allowed in Rust: we create an RO alias from a RW pointer at the same scope
-- this would emit a restriction that will prevent the original pointer of the
-- caller to use it as W (it will hence become a RO pointer also).

procedure Main is
   package Data is
      type MyStruct is record
         A,B : aliased Integer;
      end record;
      type AM is not null access all MyStruct;
      type AI is access constant Integer;
      function Inc_and_get (A : in AM) return AI;
   end Data;
   package body Data is
      function Inc_and_get (A : in AM) return AI is -- observed argument (A)
      begin
         A.all.A := A.all.A + 1;
         -- ERROR: cannot assign (A.all.A): extension of observed argument (A);
		 
         return A.all.A'Access;
         -- ERROR: cannot move (A.all.A): extension of observed argument (A);
      end Inc_and_get;


   end Data;
   use Data;

   X : aliased MyStruct := MyStruct'(A => 10, B => 12);
   Y : AM := X'Access; -- move of (X) occurs here
   Z : AI;
begin
   Z := Inc_and_get (Y); -- observe of (Y) occurs here
end Main;
