-- moving a freezed reference, creating an alias.

procedure Main is
   package Data is
      type AI is access all Integer;
      type ACI is access constant Integer;
      procedure Modify (A : in AI) with
        -- No need for Depends
        Global => null;

   end Data;
   package body Data is
      procedure Modify (A : in AI) is -- borrowed (A)
         B : ACI := A.all'Access; -- move of (A.all) occurs here
         T1 : AI := A; --move of (A) occurs here
         -- ERROR: cannot move (A): prefix of moved path (A.all)
		 -- ERROR: borrowed argument A is not RW on return
      begin
         T1.all := 42;
      end Modify;
   end Data;
   use Data;
   X : aliased Integer := 1;
   Y : AI := X'Access; --move of (X) occurs here
begin
   Modify(Y); --borrow Y
end Main;
