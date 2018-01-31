procedure Main is
   package Data is
      type AI is access all Integer;

      type ACI is access constant Integer;
      type ACAI is access constant AI;
      procedure Modify (T0 : aliased in ACAI) with
        --no need for depends
        Global => null;
   end Data;
   package body Data is
      procedure Modify (T0 : aliased ACAI) is -- observed T0
	  -- access to variables are borrowed, access to constant observed
         T1 : constant ACAI := T0; -- creating alias of pointer
                                   -- move of (T0) occurs here
         --ERROR: cannot move (T0): extension of observed path (T0)

         P : AI := T0.all.all'Access; -- freezing *T0
                                      --move of (T0.all.all) occurs here
         --ERROR: cannot move (T0.all.all): extension of observed path (T0)
      begin
         T1.all.all := 42; --assign to (T1.all.all)
      end Modify;


   end Data;
   use Data;
   X : aliased Integer := 44;
   YY : aliased AI := X'Access; --move of (X) occurs here
   Y : aliased ACAI := YY'Access;--move of (YY) occurs here
begin
   Modify (Y); --observe (Y)
end Main;
