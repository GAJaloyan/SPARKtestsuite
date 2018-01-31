-- Allowed in Rust but not in SPARK

procedure Main is

   package Data is
      type MyStruct is record
         A,B : aliased Integer;
      end record;

      type ACM is access constant MyStruct;
      type ACI is access constant Integer;

      X : aliased MyStruct := (A => 10, B => 12);
   end Data;
   package body Data is end Data;
   use Data;
begin
   declare
      Z : aliased ACM := X'Access; -- move of (X) occurs here
   begin
      declare

         package DataIn is
            type ACACM is access constant ACM;
            function foo (X:in ACACM) return ACI;
         end DataIn;

         package body DataIn is
            function foo (X:in ACACM) return ACI -- observed (X)
            is (X.all.A'Access); -- legal in rust
            -- ERROR: move of (X.all.A): extension of observed path (X)
         end DataIn;
         use DataIn;

         Y : ACACM := Z'Access; -- move of (Z) occurs here
         II : ACI;
      begin
         II := foo(Y); -- observe of (Y) occurs here
      end;
   end;
end Main;

