//: Playground - noun: a place where people can play

import UIKit

/* Swift 烧脑体操（一） - Optional 的嵌套
    http://chuansong.me/n/2248207
 */

print(1.description)


let a: Int? = nil
let b: Int?? = a
let c: Int??? = b
let d: Int??? = nil
if let _ = c {
    print("c is not none")
}

if let _ = b {
    print("b is not none")
}

var dict:[String: String?] = [:]

dict = ["key":"value"]
func justResultNil() -> String?{
    return nil
}

dict["key"] = Optional.none
dict