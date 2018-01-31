procedure Main is
   type AI is access all Integer;
   protected type AA is
      entry Insert (An_Item : in out AI) with
      Depends => (AA => null, S => AA),
        Global => S;
      entry Remove (An_Item : out AI);
   private
      S:AI;
   end AA;

   protected body AA is
      entry Insert (An_Item : in out AI) when True is 
	  -- borrowed An_Item and S
      begin
         S := An_Item;
		 -- ERROR, when returing, An_Item is not RW
      end Insert;
      entry Remove (An_Item : out AI) when True is
	  -- borrowed An_Item and S
      begin
         An_Item := S;
		 -- ERROR, when returning, An_Item is not RW
      end Remove;
   end AA;
   X : aliased Integer := 42;
   Y : AI := X'Access; --move of X occurs here
   Z : AI;
   W : AI;
   A : AA;
begin
   Y.all := 43; -- assign to (Y.all)
   A.Insert(Y); -- borrow (Y) and (S)

   A.Remove(W); -- borrow (Y) and (S)
   A.Remove(Z); -- borrow (Y) and (S)
   Z.all := 40;
   W.all := 41;
end Main;
