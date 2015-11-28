//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by ishant on 28/11/15.
//  Copyright © 2015 ishant. All rights reserved.
//
//Model Class
import Foundation
//core services layer

class CalculatorBrain
{
    private enum Op{
        case Operand(Double)
        case BinaryOperations(String,(Double,Double) -> Double)
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init(){
        knownOps["×"] = Op.BinaryOperations("×") {$0 * $1}
        knownOps["+"] = Op.BinaryOperations("+") {$0 + $1}
        knownOps["÷"] = Op.BinaryOperations("÷") {$1 / $0}
        knownOps["−"] = Op.BinaryOperations("−") {$1 - $0}
    }
    
    
    private func evaluate(ops: [Op]) -> (result: Double?,remainingOps: [Op]){
        
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return(operand,remainingOps)
            case .BinaryOperations(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double?{
        let (result,remainder) = evaluate(opStack)
        print("\(opStack)  = \(result) with \(remainder) left over")
        return result
    }
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperations(symbol: String) -> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
}