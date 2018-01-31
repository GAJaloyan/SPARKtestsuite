-- Already forbidden by Ada lifetime checks.

procedure Main is
   package Data is
      type MyStruct is record
         A,B : aliased Integer;
      end record;

      type AM is access constant MyStruct;
      type AI is access constant Integer;
      function foo (X:AM) return AI;
      Y : AI;
   end Data;

   package body Data is
      function foo (X:AM) return AI
      is (X.all.A'Access);
   end Data;
   use Data;

begin
   declare --LT1
      X : aliased MyStruct := (A => 10, B => 12);
      -- creating local object with lifetime LT1
   begin
      Y := foo(X'Access);
      -- ERROR non-local pointer cannot point to local object

      end;
end Main;

