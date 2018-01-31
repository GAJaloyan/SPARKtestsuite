-- Aliased Read-Write access.

procedure Main with SPARK_Mode is
   package Data is
      type MyStruct is record
         A,B : aliased Integer;
      end record;
      type AI is access all Integer;
   end Data;
   use Data;

   X : MyStruct := (A => 10, B => 12);
   Y : constant AI := X.A'Access; -- move of (X.A) occurs here.
begin
   Y.all := 12; -- Assign to (Y.all): OK
   
   X := (A => 42, B => 43); 
   -- ERROR, assignment to (X): prefix of moved path (X.A) with 'Access
   
end Main;
