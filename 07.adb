-- returning pointer to stack

procedure Main is
   package Data is
      type AI is access constant Integer;
      function Get_Local_Pointer return AI;
   end Data;
   package body Data is

      function Get_Local_Pointer return AI is
         X: aliased Integer := 1;
      begin
         return X'Access; --ERROR non-local pointer cannot point to local object
      end;

   end Data;
   use Data;
   A : AI;
begin
   A := Get_Local_Pointer;

end Main;
