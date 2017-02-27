//: Playground - noun: a place where people can play

import UIKit

//筛选关联值枚举数组

enum Enum{
    case foo(Int)
    case bar(String)
    case qux(Int)
}

let items :[Enum] = [.foo(1),.bar("hi"),.foo(2),.qux(3)]

let filteres0 = items.filter({
    switch $0 {case .foo: return true; default: return false}
})

let filteres1 = items.filter({
    if case .foo = $0 {return true};
    return false
})

let filteres2 = items.filter({
    guard case .foo = $0 else {
        return false
    }
    return true
})



/* 字典本身是哈希的，但是添加元素的时候，会扩容，而且哈希函数算的哈希值取于元素的位置就重拍了.但是一个元素已经放好了的字典，元素位置在内存中是固定的。
 */
var a = ["2r":3,"4x":5,"6c":7,"df":45]
print(a)
a["gg"] = 4
print(a)




/* 一个可变对象加入一个可变的集合中，成为集合的一个元素后，改变这个可变对象，可变集合不会改变*/
var dic = ["2":3]
var set = NSMutableSet(arrayLiteral: dic,"b","a")
dic["rt"] = 45
set

