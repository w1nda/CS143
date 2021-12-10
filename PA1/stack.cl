(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

class Stack{
   io : IO;
   a2i : A2I;
   list : List;
   exit : Bool;

   init(): Stack {
      {
         io <- new IO;
         a2i <- new A2I;
         list <- new List;
         exit <- false;
         if list.isNil() then
            io.out_string("list is empty\n")
         else
            io.out_string("list is not empty\n")
         fi;
         self;
      }
   };

   dealInput4ever(): Object {
      while (not exit) loop
         let 
            input : String <- io.in_string()
         in
            if input = "+" then  plus()      else
            if input = "s" then  swap()      else
            if input = "e" then  evaluate()  else
            if input = "d" then  display()   else
            if input = "x" then  quit()      else 
               number(input)
            fi fi fi fi fi
      pool
   };

   evaluate() : Object {
      if (not list.isNil()) then
         let 
         str : String <- list.head()
         in
            if str = "+" then  doPlus()   else
            if str = "s" then  doSwap()   else
               ""
            fi fi
      else
         ""
      fi
   };

   plus() : Object {
      list <- list.cons("+")
   };

   doPlus() : Object {
      {
         let 
            a : Int,
            b : Int,
            c : Int
         in
            {
               list <- list.tail();
               a <- a2i.a2i(list.head());
               list <- list.tail();
               b <- a2i.a2i(list.head());
               list <- list.tail();
               c <- a + b;
               list <- list.cons(a2i.i2a(c));
            };
      }
   };

   swap() : Object {
      list <- list.cons("s")
   };

   doSwap() : Object {
      {
         let 
            a : String,
            b : String
         in 
            {
               list <- list.tail();
               a <- list.head();
               list <- list.tail();
               b <- list.head();
               list <- list.tail();
               list <- list.cons(a);
               list <- list.cons(b);
            };

      }
   };

   display() : Object {
      list.print()
   };
   
   quit() : Object {
      {
         exit <- true;
         io.out_string("quit\n");
      }
   };

   number(s : String) : Object {
      list <- list.cons(s)
   };

};

class Main inherits IO {

   stack : Stack;

   main() : Object {
      {
         stack <- (new Stack).init();
         stack.dealInput4ever();
      }
   };

};
