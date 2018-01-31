procedure Main is
   type AI is access all Integer;
   protected type AA is
      entry Insert (An_Item : in out AI) with
      Depends => (An_Item => null, AA =>+ An_Item);
      entry Remove (An_Item : out AI) with
      Depends => (An_Item => AA, AA => null);
   private
      S:AI;
   end AA;

   protected body AA is
      entry Insert (An_Item : in out AI) when True is -- borrowed An_Item
			-- implicit out parameter S
      begin
         S := An_Item; -- move of An_Item occurs here
         An_Item := null; -- assign to An_Item
	     -- An_Item and S are RW when returning
      end Insert;
      entry Remove (An_Item : out AI) when True is -- borrowed An_Item
			-- implicit in out parameter S
      begin
         An_Item := S; -- move of S occurs here
         S := null; -- assign to S
	     -- An_Item and S are RW when returning
      end Remove;
   end AA;
   X : aliased Integer := 42;
   Y : AI := X'Access; --move of X occurs here
   Z : AI;
   W : AI;
   A : AA;
begin
   Y.all := 43; -- assign to (Y.all)
   A.Insert(Y); -- borrow (Y) and (S).

   A.Remove(Z); -- borrow (Z) and (S).
   Z.all := 40;
   
   A.Remove(W); -- borrow (W) and (S).
   W.all := 41; --Runtime error : null pointer dereferencing
end Main;
