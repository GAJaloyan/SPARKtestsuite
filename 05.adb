-- Creating a read access from a RW borrow

procedure Main with SPARK_Mode is
   package Data is
      type MyStruct is record
         A,B : aliased Integer;
      end record;

      type AM is access all MyStruct;
      type ACI is access constant Integer;

      X : aliased MyStruct := (A => 10, B => 12);

   end Data;
   package body Data is end Data;
   use Data;
begin
   declare
      Z : aliased AM := X'Access; -- move of (X) with 'Access occurs here
   begin
      declare
         package DataIn is
            type AAM is access all AM;
            function foo (X:in AAM) return ACI;

         end DataIn;

         package body DataIn is
            function foo (X:in AAM) return ACI -- observed argument (X)
            is (X.all.A'Access); -- move of (X.all.A) with 'Access occurs here
            -- ERROR: cannot move (X.all.A): extension of observed path (X)
         end DataIn;
         use DataIn;

         Y : AAM := Z'Access; -- move of (Z) with 'Access occurs here
         II : ACI;
      begin
         II := foo(Y); -- observe of (Y) occurs here

         Y.all.all.A := 12; -- assign to (Y.all.all.A): OK

         X := (A => 42, B => 43); -- assign to (X)
         -- ERROR assignment (X): prefix of moved path (X) with 'Access

      end;
   end;
end Main;

