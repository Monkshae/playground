//: Playground - noun: a place where people can play

import UIKit


/* 
 （“The lazy initializer for a global variable (also for static members of structs and enums) is run the first time that global is accessed, and is launched as `dispatch_once` to make sure that the initialization is atomic. This enables a cool way to use `dispatch_once` in your code: just declare a global variable with an initializer and mark it private.”）
 这就是Apple官方文档给我们的所有信息，但这些已经足够证明全局变量和结构体／枚举体的静态成员是支持”dispatch_once”特性的。
 */
class Single: NSObject {
    //声明为静态成员
    static let shareSingleOne = Single()
    //不要忘记设置初始化方法为私有
    private override init(){
        
    }
}


let str = "http://www.example.com/栗子/"
let a = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//let encodedStr = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
let url = NSURL.init(string: a!)