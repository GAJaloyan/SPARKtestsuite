package Pointers with
  SPARK_Mode
is
   --  Single level of pointers

   type Int_Ptr is access Integer;

   procedure Bad_Swap (X, Y : in out Int_Ptr);

   procedure Swap (X, Y : in out Int_Ptr);

   X, Y : Int_Ptr;

   procedure Bad_Swap with
     Global => (In_Out => (X, Y));

   procedure Swap with
     Global => (In_Out => (X, Y));

   --  Double level of pointers

   type Int_Ptr_Ptr is access Int_Ptr;

   procedure Bad_Swap2 (X, Y : Int_Ptr_Ptr);

   procedure Swap2 (X, Y : Int_Ptr_Ptr);

   XX, YY : Int_Ptr_Ptr;

   procedure Bad_Swap2 with
     Global => (Input => (XX, YY));

   procedure Swap2 with
     Global => (Input => (XX, YY));

   --  Constant single level of pointers

   type Int_Cst_Ptr is access constant Integer;

   procedure Bad_Swap3 (X, Y : in out Int_Cst_Ptr);

   procedure Swap3 (X, Y : in out Int_Cst_Ptr);

   CX, CY : Int_Cst_Ptr;

   procedure Bad_Swap3 with
     Global => (In_Out => (CX, CY));

   procedure Swap3 with
     Global => (In_Out => (CX, CY));

   --  Pointer to constant single level of pointers

   type Int_Ptr_Cst_Ptr is access Int_Cst_Ptr;

   procedure Bad_Swap4 (X, Y : Int_Ptr_Cst_Ptr);

   procedure Swap4 (X, Y : Int_Ptr_Cst_Ptr);

   CXX, CYY : Int_Ptr_Cst_Ptr;

   procedure Bad_Swap4 with
     Global => (Input => (CXX, CYY));

   procedure Swap4 with
     Global => (Input => (CXX, CYY));

   --  Constant double level of pointers

   type Int_Cst_Ptr_Ptr is access constant Int_Ptr;

   procedure Bad_Swap5 (X, Y : Int_Cst_Ptr_Ptr);

   procedure Swap5 (X, Y : Int_Cst_Ptr_Ptr);

   CCXX, CCYY : Int_Cst_Ptr_Ptr;

   procedure Bad_Swap5 with
     Global => (Input => (CCXX, CCYY));

   procedure Swap5 with
     Global => (Input => (CCXX, CCYY));

end Pointers;


package body Pointers with
  SPARK_Mode
is
   --  Single level of pointers

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

   procedure Bad_Swap is
   begin
      X := Y;
   end Bad_Swap;

   procedure Swap is
      Tmp : Int_Ptr := X;
   begin
      X := Y;
      Y := Tmp;
   end Swap;

   --  Double level of pointers

   procedure Bad_Swap2 (X, Y : Int_Ptr_Ptr) is
   begin
      X.all := Y.all;
   end Bad_Swap2;

   procedure Swap2 (X, Y : Int_Ptr_Ptr) is
      Tmp : Int_Ptr := X.all;
   begin
      X.all := Y.all;
      Y.all := Tmp;
   end Swap2;

   procedure Bad_Swap2 is
   begin
      XX.all := YY.all;
   end Bad_Swap2;

   procedure Swap2 is
      Tmp : Int_Ptr := XX.all;
   begin
      XX.all := YY.all;
      YY.all := Tmp;
   end Swap2;

   --  Constant single level of pointers

   procedure Bad_Swap3 (X, Y : in out Int_Cst_Ptr) is
   begin
      X := Y;
   end Bad_Swap3;

   procedure Swap3 (X, Y : in out Int_Cst_Ptr) is
      Tmp : Int_Cst_Ptr := X;
   begin
      X := Y;
      Y := Tmp;
   end Swap3;

   procedure Bad_Swap3 is
   begin
      CX := CY;
   end Bad_Swap3;

   procedure Swap3 is
      Tmp : Int_Cst_Ptr := CX;
   begin
      CX := CY;
      CY := Tmp;
   end Swap3;

   --  Pointer to constant single level of pointers

   procedure Bad_Swap4 (X, Y : Int_Ptr_Cst_Ptr) is
   begin
      X.all := Y.all;
   end Bad_Swap4;

   procedure Swap4 (X, Y : Int_Ptr_Cst_Ptr) is
      Tmp : Int_Cst_Ptr := X.all;
   begin
      X.all := Y.all;
      Y.all := Tmp;
   end Swap4;

   procedure Bad_Swap4 is
   begin
      CXX.all := CYY.all;
   end Bad_Swap4;

   procedure Swap4 is
      Tmp : Int_Cst_Ptr := CXX.all;
   begin
      CXX.all := CYY.all;
      CYY.all := Tmp;
   end Swap4;

   --  Constant double level of pointers

   procedure Bad_Swap5 (X, Y : Int_Cst_Ptr_Ptr) is
   begin
      X.all.all := Y.all.all;
   end Bad_Swap5;

   procedure Swap5 (X, Y : Int_Cst_Ptr_Ptr) is
      Tmp : Int_Ptr := X.all;
   begin
      X.all.all := Y.all.all;
      Y.all.all := Tmp.all;
   end Swap5;

   procedure Bad_Swap5 is
   begin
      CCXX.all.all := CCYY.all.all;
   end Bad_Swap5;

   procedure Swap5 is
      Tmp : Int_Ptr := CCXX.all;
   begin
      CCXX.all.all := CCYY.all.all;
      CCYY.all.all := Tmp.all;
   end Swap5;

end Pointers;
