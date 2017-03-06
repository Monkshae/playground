//: Playground - noun: a place where people can play

import UIKit
//一只青蛙一次可以跳上一级台阶，也可以跳上两级台阶。求青蛙跳上一个n级台阶共有多少种跳发。
//递归求斐波那契数列

//func Fibonacci(n: Int)  -> Int {
//    if n <= 0 { return 0}
//    if n == 1 {return 1}
//    return Fibonacci(n: n-1) + Fibonacci(n: n-2)
//}
//
//Fibonacci(n: 100)

func Fibonacci2(n: Int) -> Int {
    let result = [0,1]
    if n < 2 { return result[n] }
    var fibOne = 0, fibTwo = 1, fibN = 0
    for _ in 2...n {
        fibN = fibOne + fibTwo
        fibOne = fibTwo
        fibTwo = fibN
    }
    return fibN
}

Fibonacci2(n: 80)


func PowerWithUnsignedExponent(base: Double, exponent: UInt32) -> Double{
    if exponent == 0 {
        return 1
    }
    
    if exponent == 1 {
        return base
    }
    
    var result = PowerWithUnsignedExponent(base: base, exponent: exponent >> 1)
    result *= result
    let one: UInt32  = 1
    if exponent & one > 0  {
        result *= base
    }
    return result
}


		
