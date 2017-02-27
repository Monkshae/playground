//: Playground - noun: a place where people can play

import UIKit


var array = [1,2,3,5,6,7,8]
array.map({ return $0 * 2})


/*
 Swift异常处理体现了函数式语言的特性，因此我们可以传一个会抛出异常的函数闭包（高阶函数）作为参数传到另一个函数中（父函数），父函数可以在
 子函数抛出异常时直接向上抛出异常，这时用rethrow关键字表示引用闭包时抛出的异常。
 
 */


extension Array {
    func myMap<T>(_ transform: (Element)  -> T)  -> [T] {
        var ts = [T]()
        for e in self {
            ts.append(transform(e))
        }
        return ts
    }
    
    func myMapThrow<T>(_ transform: (Element)  throws -> T) throws -> [T] {
        var ts = [T]()
        for e in self {
            ts.append(try transform(e))
        }
        return ts
    }
    
    func _map<T>(_ transform: (Element)  throws -> T) rethrows -> [T]  {
        var ts = [T]()
        for e in self {
            ts.append(try transform(e))
        }
        return ts
    }
    
}

enum CalculationError: Error {
    case DivideByZero
}

func squareOf(x: Int) -> Int {
    return x * x
}

func divideTenBy(x: Int) throws -> Double {
    guard x != 0 else {
        throw CalculationError.DivideByZero
    }
    return 10.0 / Double(x)
}

let xs = [1,2,3,4]
//let a = xs.myMap({squareOf(x: $0)})
let a1 = xs.myMap(squareOf)
//let a2 = xs.myMap(divideTenBy)


//let b1 = xs.myMapThrow(squareOf)
//let b2 = xs.myMapThrow(divideTenBy)


//let c1 = xs._map(squareOf)
//let c2 = xs._map(divideTenBy)


let c3: [Double]
do {
    try c3 = xs._map(divideTenBy)

} catch {

}

/* 如果不用rethrows而用了throws，当传递进来的闭包不产生异常的时候,也会产生异常 
   而throw和rethrow的区别最明显的区别在于myMapThrow()每次调用必须try，而_map()仅仅当transform是一个异常抛出的函数(闭包)的时候才需要try。单transform不是异常闭包的时候，调用的时候不需要try
 */

/* 总结下来就是三点,一个接受闭包作为参数的函数有下面三种throw选择
 
  1.它能throws.那意味着无论闭包是否抛出异常，函数都将跑出异常
  2.它能像map一样rethrow.那就意味着函数不能产生任何他自己的异常,但有可能从闭包传递过来异常。没有的话就不用抛异常
  3.它不能rethow.那意味着要么是闭包自己处理异常，要么就是不会计算闭包。例如属性闭包，仅仅是作为设置属性值和返回，就没有处理闭包异常
 
 */



//相关链接 https://forums.developer.apple.com/thread/8302

func receiveThrower(f:(String) throws -> ()) throws {
    try f("ok?")
}
func receiveThrower2(f:(String) throws -> ()) rethrows {
    try f("ok?")
}


do {
    try receiveThrower { (string) in
        print(string)
    }
} catch{
    
}

receiveThrower2 { (string) in
    print(string)
}




