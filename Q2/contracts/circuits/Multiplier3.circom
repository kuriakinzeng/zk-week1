pragma circom 2.0.0;

/*This circuit template checks that c is the multiplication of a and b.*/  

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;  
   signal input c;
   signal output d;
   signal i; 

   // Constraints.  
   i <== a * b;  
   d <== i * c;
}

component main = Multiplier3();