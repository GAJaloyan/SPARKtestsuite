package Pointers2 with
  SPARK_Mode
is
   type Int_Ptr is access Integer;

   procedure Bad_Swap (X, Y : in out Int_Ptr);

   procedure Swap (X, Y : in out Int_Ptr);

   X, Y : Int_Ptr;

   procedure Bad_Swap_Global with
     Global => (In_Out => (X, Y));

   procedure Swap_Global with
     Global => (In_Out => (X, Y));
   
   procedure Bad_Borrow (X, Y : in out Int_Ptr);
   
   procedure Bad_Move (X, Y : in out Int_Ptr);
   

end Pointers2;


package body Pointers2 with
  SPARK_Mode
is
   procedure Bad_Swap (X, Y : in out Int_Ptr) is
   begin
      X := Y;
   end Bad_Swap;

   procedure Swap (X, Y : in out Int_Ptr) is
      Tmp : Int_Ptr := X;
   begin
      X := Y;
      Y := Tmp;
   end Swap;

   procedure Bad_Swap_Global is
   begin
      X := Y;
   end Bad_Swap_Global;

   procedure Swap_Global is
      Tmp : Int_Ptr := X;
   begin
      X := Y;
      Y := Tmp;
   end Swap_Global;
   
   procedure Bad_Borrow (X, Y : in out Int_Ptr) is
   begin
      X := Y;
      Swap (X, Y);
   end Bad_Borrow;
   
   procedure Bad_Move (X, Y : in out Int_Ptr) is
   begin
      X := Y;
      X := Y;
   end Bad_Move;
   
end Pointers2;
