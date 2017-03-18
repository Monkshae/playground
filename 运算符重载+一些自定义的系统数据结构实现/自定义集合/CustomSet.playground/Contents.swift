//: Playground - noun: a place where people can play

import UIKit
import Foundation

/*
    一个Bag对象就像一个Set,用于存储不会重复的对象。在一个Set集合中，重复对象会被忽略。在一个Bag中，每个对象都会被算进去
 */
struct Bag<Element: Hashable> {
    
    fileprivate var contents: [Element: Int] = [:]
    var uniqueCount: Int {
        return contents.count
    }
    //totalCount 返回的是Bag中所有对象的总计。以同一个例子为例，totalCount返回值为6
    var totalCount: Int {
        return contents.values.reduce(0) { $0 + $1 }
    }
    //现在，需要几个方法以便增减 Bag 中的内容。在属性声明下面加入
    mutating func add(_ member: Element, occurences: Int = 1)  {
        precondition(occurences > 0, "只能是正数的次数")
        if let currentCount = contents[member] {
            contents[member] = currentCount + occurences
        } else {
            contents[member] = occurences
        }
    }
}

let arr = ["a", "b", "c"]

let dict = [
    "a": [
        "b": [
            "c": [:]
        ]
    ]
]