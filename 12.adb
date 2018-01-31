-- the loan exceeds the lifetime of the borrowed reference

with Ada.Text_IO;
use Ada.Text_IO;

procedure Main is
   package Data is
      type AI is access all Integer;
      type AAI is access all AI;
      function Copy_Pointer (A : in AAI) return AI;
   end Data;
   package body Data is
      function Copy_Pointer (A : in AAI) return AI is --observed (A)
      begin
         return A.all.all'Access; --the loan exceeds the lifetime of the borrow
                                  --move of (A.all.all) occurs here
         --ERROR cannot move (A.all.all): extension of observed path (A)
      end Copy_Pointer;
   end Data;
   use Data;
   X : aliased Integer := 1;
   Y : aliased AI := X'Access; --move of (X) occurs here
   Z : AI;
begin
   Z := Copy_Pointer (Y'Access); --observe of (Y) occurs here
end Main;
