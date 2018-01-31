procedure Main is
   package Data is
      type AI is access all Integer;
      function Foo (x : AI) return AI;

      function Bar (x:Integer) return Integer is (x);
      procedure Test (x : in out Integer);
   end Data;
   package body Data is
	  -- Foo is an accessor function, it is not accepted by 
	  -- our rules, contrary to Rust.
      function Foo (x:AI) return AI is -- observed (x)
      begin
         return x; --move of (X) occurs here
         --ERROR, cannot move (X): observed path (X)
      end Foo;
      procedure Test (x : in out Integer) is
      begin
         x := 42;
      end Test;
   end Data;
   use Data;
   X : aliased Integer := 44;
   Y : aliased AI := X'Access; -- move of (X) occurs here
begin
   Foo(Y).all := 5; -- observe of (Y) occurs here

   Test(Foo(Y).all);
end Main;


