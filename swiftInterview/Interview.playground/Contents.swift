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
//闭包是通过截获外部变量的引用从而实现对变量的修改的
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


var car2 = "Benz"
typealias PrintClosure = ([String]) -> Void
let closure2: PrintClosure = { a in
    print("I drive \(a[0])")
}
car = "Tesla"
closure2([car2])

//
//print(Unmanaged<AnyObject>.passUnretained(array as AnyObject).toOpaque())
//print(Unmanaged<AnyObject>.passUnretained(array1 as AnyObject).toOpaque())
//


protocol Pizzeria {
    func makePizza(_ ingredients: [String])
}

extension Pizzeria {
    func makeMargherita() {
        return makePizza(["tomato", "mozzarella"])
    }
}

struct Lombardis: Pizzeria {
    func makePizza(_ ingredients: [String]) {
        print(ingredients)
    }
    func makeMargherita() {
        return makePizza(["tomato", "basil", "mozzarella"])
    }
}

let lombardis1: Pizzeria = Lombardis()
let lombardis2: Lombardis = Lombardis()
lombardis1.makeMargherita()
lombardis2.makeMargherita()




/*
  给你加一题,写个方法，将下面数组转换为以下结构的字典
  let arr = ["a", "b", "c"]
  let dic =["c": ["b": ["a": [:]]]]

 */

func convert<T: Hashable>(array: inout [T]) -> [T: Any] {
    
    guard array.count > 0 else {
        return [T: Any]()
    }
    
    if array.count == 1 {
        return [array.last!: [:]]
    }
    let key = array.removeLast()
    let value = convert(array: &array)
    return [key: value]
}

var arr = ["a", "b", "c"]
let x =  convert(array: &arr)
print(x)


func isNumber<T: SignedNumber>(_ number: T){
    print("yes,It's a number ")
}



//如果截取一个字符串
let sessionId = "this is a test"
let index = sessionId.index(sessionId.endIndex, offsetBy: -2)
let suffix = sessionId.substring(from: index)

class Object : NSObject {
    var x = 1
    init(x: Int) {
        self.x = x
    }
}

//如果数组元素是引用类型，最好使用ContiguousArray
let xObject = Object(x: 2)
let yObject = Object(x: 3)
var array: ContiguousArray = [xObject,yObject]
var array1: Array = [xObject,yObject]

array[0] = Object(x: 6)
print(array[0].x)
print(xObject.x)

//array1[0] = Object(x: 6)
//print(array1[0].x)
//print(xObject.x)
let titles  = ["title1","title2"]
var copyTitles = titles

print(Unmanaged<AnyObject>.passUnretained(titles as AnyObject).toOpaque())
print(Unmanaged<AnyObject>.passUnretained(copyTitles as AnyObject).toOpaque())


//
protocol Number {
    
    static func +(lhs: Self, rhs: Self) -> Self // 2
    
    static func -(lhs: Self, rhs: Self) -> Self
    
    static func *(lhs: Self, rhs: Self) -> Self
    
    static func /(lhs: Self, rhs: Self) -> Self
    
    static func +=(lhs: inout Self, rhs: Self)
    
    static func -=(lhs: inout Self, rhs: Self)

    static func *=(lhs: inout Self, rhs: Self)
    
    static func /=(lhs: inout Self, rhs: Self)

}
extension Double : Number {}   // 3
extension Float  : Number {}
extension Int    : Number {}

let a = 93 + 4.787 + 56


//Slice的索引并不是总是从0开始
var o = [1,2,3,4,5]
let ary = Array(1...100)

let s:ArraySlice<Int> = ary[10..<20]
s.startIndex            // 0
ary[10..<20].startIndex // 0
(10..<20).startIndex

//如何声明一个只能被类 conform 的 protocol

protocol OnlyClassProtocol : class {
    
}





