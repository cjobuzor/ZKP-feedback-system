pragma circom 2.0.0;
include "circomlib/circuits/comparators.circom";

template TimeRangeProof() {
    signal input Pt;
    signal input d;
    signal input Ct;

    component gte1 = GreaterEqThan(32); 
    gte1.in[0] <== Ct;              
    gte1.in[1] <== Pt;                  

      component gte2 = GreaterEqThan(32); 
    gte2.in[0] <== Pt+d;              
    gte2.in[1] <== Ct;                 

        signal isBothGreaterEqZero;
    isBothGreaterEqZero <== gte1.out * gte2.out;

        signal out;
    out <== isBothGreaterEqZero;
    out - 1 === 0;
 }

component main {public [Pt, d]} = TimeRangeProof();
