//: Playground - noun: a place where people can play

import UIKit

//http://www.jianshu.com/p/3fb6940e59cb

/*
  在Swift中，初次接触inout关键字以及它的用法，可能会让我们想起C/C++中的指针，但实际上
  Swift中inout只不过是按值传递，然后再写回原变量，而不是按引用传递:
 
  An in-out parameter has a value that is passed in to the function, is 
  modified by the function, and is passed back out of the function to 
  replace the original value.
  
  这样的好处在于它远比使用引用安全。
 */

func increase(i: inout Int){
    i += 1
}

var x = 0
increase(i: &x)
print(x)


/*
 
 参数x传入到inc函数中后，在函数内被修改为1，函数返回时这个值(1)覆盖了原来的x的值(0)，所以
 x变成了1
 
 */

/* 对比一下另一种同样能在函数内部改变变量值的实现方式——闭包 
   闭包是通过截获外部变量的引用从而实现对变量的修改的
 */
func increaseByClosures() -> () -> Int {
    var i = 0
    return {
        i = i + 1
        return i
    }
}

let f = increaseByClosures()
print(f()) // 输出结果：“1”
print(f()) // 输出结果：“2”


/*
  我们通过闭包来证明，inout参数是按值传递的
  https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID545
   捕获inout参数的闭包必须是nonescaping,对于非逃逸闭包，如果如果您需要捕获一个in-out参数而不改变它或观察其他代码所做的更改，必须显示的使用捕获列表[]来显式地捕获该参数,这个时候它不是一个数组，虽然它看起来像。现在这玩意儿叫捕获列表(capture list)是类似[unownd self]。
   如果逃逸闭包非要使用inout参数，必须显示的使用本地副本，就是复制一份新值。详见文档
 
 */


func increaseForInout(i: inout Int) -> ()-> Int {
    
    var localX = i
    return {
        localX += 1
        return localX
    }
}


/* 我们知道闭包会按引用截获变量，如果inout参数是按照引用传递,那么localX, localX操作后函数闭包返回最后修改的值，如果i是引用那么这时候的值应该是1而不是0,*/
var x2 = 0
let f2 = increaseForInout(i: &x2)
print(f2()) // 输出结果：“1”
print(x2) // 输出结果：“0”


/*
  我们梳理一下整个过程:
  1.我们在函数内创建一个副本localX,如果inout是引用传递，那么localX也会是一个引用
  2.闭包里捕获了变量localX，我们知道闭包是按引用捕获变量的，如果1成立，则这里没有产生任何副本
  3.闭包内改变了localX的值，所以对应闭包外面的变量localX也会改变，如果i是引用传递的话，i的值也会改变，但是结果是i依然为0
 */


//&并不总表示inout
func inc(i: UnsafeMutablePointer<Int>) -> () -> Int {
    //函数内存储指针i的副本，闭包截获这个副本
    return {
        i.pointee += 1
        return i.pointee
    }
}
//var x3 = 0
//let f3 = inc(i: &x3)
//print(f3())
//print(x3)


let f3: () -> Int
var x3 = [1,2,3]
f3 = inc(i: &x3)
print(f3())

