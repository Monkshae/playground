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



		