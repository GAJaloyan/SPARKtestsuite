procedure Main is

   package Data is
      type Point is record
         X,Y : aliased Integer;
      end record;
      type AI is access all Integer;
      function CreatePoint(X: AI; Y: AI) return Point;
   end Data;

   package body Data is
      function CreatePoint (X: AI; Y: AI) return Point -- observed X and Y
      is (X=>X.all, Y=>Y.all); --valid, shallow are copied, not moved

   end Data;
   use Data;

   X : aliased Integer := 10;
   Y : aliased Integer := 14;
   AX : AI := X'Access; -- move of (X) occurs here.
   AY : AI := Y'Access; -- move of (Y) occurs here.
   P : Point;
begin
   P := CreatePoint(AX,AY); -- observe of AX, AY

   AY.all := 42;
   AX.all := 40;

end Main;
