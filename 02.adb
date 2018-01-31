-- Creating a memory leak.

procedure Main with SPARK_Mode is
   package Data is
      type MyStruct is record
         A,B : aliased Integer;
      end record;
      type AM is not null access all MyStruct;
      type AI is not null access all Integer;
   end Data;
   use Data;

   X : AM := new MyStruct'(A => 10, B => 12);
   Y : constant AI := X.all.A'Access; -- move of (X.all.A) occurs here
begin
   Y.all := 14; -- assign to (Y.all): OK

   X := new MyStruct'(A => 42, B => 43);
   -- if deallocation of old X there then dangling pointer Y created
   -- assign to (X): allowed; (X) does not have the same number of .all

end Main;
