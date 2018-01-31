-- Deallocation : creating dangling pointer through aliasing.

with Ada.Unchecked_Deallocation;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Main is
   package Data is
      type MyStruct is record
         A,B : aliased Integer;
      end record;
      type AM is access MyStruct;
      type AI is access all Integer;

      procedure Free_MyStruct is new Ada.Unchecked_Deallocation
        (MyStruct, AM); -- Free(in out access MyStruct)
      -- moved parameter : in out mode

   end Data;
   use Data;

   X : AM := new MyStruct'(A => 10, B => 12);
   Y : AI := X.all.A'Access; -- move of (X.all.A) occurs here
begin
   Y.all := 14; -- assign to (Y.all): OK

   Free_MyStruct(X); -- explicit free, creating dangling pointer
                     -- ERROR cannot move (X): prefix of moved path (X.all.A)

   Put_Line ("Y.all =" & Integer'Image(Y.all)); --/!\ use of dangling pointer

   X := new MyStruct'(A => 42, B => 43);
   -- assign (X): allowed; (X) does not have the number of .all
end Main;

