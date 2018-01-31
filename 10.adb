procedure Main is
   package Data is
      type AI is access all Integer;

      type ACI is access constant Integer;
      procedure Modify (T0 : aliased in out AI) with
        Depends => (T0 => T0),
        Global => null;
   end Data;
   package body Data is
      procedure Modify (T0 : aliased in out AI) is -- borrowed T0
         P : constant ACI := T0.all'Access; -- freezing *T0
                                            -- move of (T0.all) occurs here

         T2 : access constant AI := T0'Access; -- move of (T0) occurs here
         -- ERROR: cannot move (T0): prefix of moved path (T0.all)

         Q : ACI := ACI(T2.all); -- Freezing *T0 but not through P
                                 -- move of (T2.all) occurs here

         R : ACI := T0.all'Access; -- Doing the same directly
                                   --move of (T0.all) occurs here
         -- ERROR: cannot move (T0.all): prefix of moved path (T0.all)
      begin
         null;
      end Modify;
   end Data;
   use Data;
   X : aliased Integer := 44;
   Y : aliased AI := X'Access; -- move of (X) occurs here
begin
   Modify (Y); -- borrow (Y)
end Main;
