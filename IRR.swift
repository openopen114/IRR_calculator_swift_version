// IRR swift version
// openopen114@gmail.com
// reference http://www.codeproject.com/Tips/461049/Internal-Rate-of-Return-IRR-Calculation
// 2016/06/23

import UIKit


func computeIRR(cashFlows:[Int],numOfFlows:Int) -> Double{
    //const
    let LOW_RATE = 0.01 // 1%
    let HIGH_RATE = 0.5 //50%
    let MAX_ITERATION = 1000 //iteration
    let PRECISION_REQ = 0.00000001 //percision
    
    //variable
    var old: Double = 0.00;
    var new: Double = 0.00;
    var oldguessRate: Double = LOW_RATE;
    var newguessRate: Double = LOW_RATE;
    var guessRate: Double = LOW_RATE;
    var lowGuessRate: Double = LOW_RATE;
    var highGuessRate: Double = HIGH_RATE;
    var npv: Double = 0.0;
    var denom: Double = 0.0;
    
    for i in 0 ..< MAX_ITERATION {
        npv = 0.00;
        for j in 0..<numOfFlows{
            denom = pow(1 + guessRate,Double(j));
            npv = npv + (Double(cashFlows[j])/denom);
        }
        if((npv > 0) && (npv < PRECISION_REQ)){break;}
        
        if(old == 0){
            old = npv;
        }else{
            old = new;
        }
        new = npv;
        
        if(i > 0)
        {
            if(old < new)
            {
                if(old < 0 && new < 0){
                    highGuessRate = newguessRate;
                }else{
                    lowGuessRate = newguessRate;
                }
            }
            else
            {
                if(old > 0 && new > 0){
                    lowGuessRate = newguessRate;
                }else{
                    highGuessRate = newguessRate;
                }
            }
        }
        oldguessRate = guessRate;
        guessRate = (lowGuessRate + highGuessRate) / 2;
        newguessRate = guessRate;
        
    }
    
    return guessRate
}


//Test
/*
 var cf = [Int]()
 var numOfFlows:Int;
 cf.append(-224988)
 cf.append(34662)
 cf.append(34312)
 cf.append(33962)
 cf.append(33612)
 cf.append(33262)
 cf.append(32912)
 cf.append(32562)
 cf.append(32212)
 cf.append(31862)
 cf.append(31512)
 cf.append(31162)
 cf.append(30812)
 cf.append(30462)
 cf.append(30112)
 cf.append(29762)
 cf.append(29412)
 cf.append(29062)
 cf.append(28712)
 cf.append(28362)
 
 numOfFlows = 20;
 
 
 
 var irr = computeIRR(cf, numOfFlows:numOfFlows);
 print("\nFinal IRR: %.3f", irr);
 */

