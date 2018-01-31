procedure Main is

   package Data is
      type Point is record
         X,Y : aliased Integer;
      end record;
      type AI is access all Integer;
      type AP is access all Point;
      type Meta is record
         A : aliased AP;
      end record;
      type AM is access all Meta;
      function CreatePoint(X: AI; Y: AI) return Point;
   end Data;

   package body Data is
      function CreatePoint (X: AI; Y: AI) return Point -- observed X and Y
      is (X=>X.all, Y=>Y.all); -- no move for X and Y : ok

   end Data;
   use Data;

   X : aliased Integer := 10;
   Y : aliased Integer := 14;
   AX : AI := X'Access; -- move of (X) occurs here.
   AY : AI := Y'Access; -- move of (Y) occurs here.
   P : aliased Point;
   M : aliased Meta;
   AAM : aliased AM;
   P2 : aliased Point := (X=> 102, Y=>103);
   getX : Integer;
   getY : Integer;
begin
   P := CreatePoint(AX,AY); -- observe of AX, AY

   AY.all := 42;
   AX.all := 40;


   M := (A=>P'Access); -- move of P occurs here
   AAM := M'Access; -- move of M occurs here

   getX := AAM.all.A.all.X; -- move of AAM.all.A.all.X;
   getY := AAM.all.A.all.Y; -- move of AAM.all.A.all.Y;

   AAM.all := (A=>P2'Access); -- move of P2 occurs here
                              -- assign to AAM.all: fresh RW
   getX := AAM.all.A.all.X;   -- move of AAM.all.A.all.X
   getY := AAM.all.A.all.Y;   -- move of AAM.all.A.all.Y

end Main;
