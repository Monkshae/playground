//: Playground - noun: a place where people can play

import UIKit

// 道长的 Swift 面试题 http://www.jianshu.com/p/07c9c6464f83

//第一题见 两个元素的交换文件夹下

//第二题 下面的代码有什么问题
public class Node {
    public var value: Int
    weak public var prev: Node?
    weak public var post: Node?
    
    public init(_ value: Int) {
        self.value = value
    }
}

/*  答案：应该是var prev 或者 var post 前面加上weak~
    原因：表面上看，以上代码毫无问题，但是我这样一下，问题就来了
 */

let head = Node(0)
let tail = Node(1)
head.post = tail
tail.prev = head


// 第三题 实现一个函数，输入是任意整数，输出要求返回输入的整数 + 2
//很多人上来就会这么写
func addTwo(num: Int) -> Int{
    return num + 2
}

//接下来面试官会说，那假如我要实现 + 4 呢？程序员想了一想，又定义了另一个方法
func addFour(num: Int) -> Int{
    return num + 4
}

//那如果我要实现返回+6 +8的操作呢？能不能之定义一次方法。正确是利用柯西特性，就是返回一个闭包函数

func add(value: Int) -> (Int) -> Int {
    return { value + $0 }
}

let addTwo = add(value: 2)
addTwo(4)


//精简以下代码,这题考察的是 guard let 语句以及 optional chaining，最佳答案是

func divide(dividend: Double?, by divisor: Double?) -> Double? {
    if dividend == nil {
        return nil
    }
    if divisor == nil {
        return nil
    }
    if divisor == 0 {
        return nil
    }
    return dividend! / divisor!
}

func divide1(dividend: Double?, by divisor: Double?) -> Double? {
    
    guard let dividend = dividend, let divisor = divisor, divisor != 0  else {
        return nil
    }
    return dividend / divisor
}

//以下函数会打印出什么?
var car = "Benz"
let closure = { [car] in
    print("I drive \(car)")
}
car = "Tesla"
closure()


var car1 = "Benz"
let closure1 = {
    print("I drive \(car)")
}
car1 = "Tesla"
closure1()


//
//print(Unmanaged<AnyObject>.passUnretained(array as AnyObject).toOpaque())
//print(Unmanaged<AnyObject>.passUnretained(array1 as AnyObject).toOpaque())
//
