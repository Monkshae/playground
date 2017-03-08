//: Playground - noun: a place where people can play

import UIKit

//给一个数组，要求写一个函数，交换数组中的两个元素

//简单的写法
func swap(num: inout [Int], a: Int, b: Int){
    guard num.count > 0 else {
        return
    }
    assert((a >= 0 && a < num.count), "a必须大于等于0且不能越界")
    assert((b >= 0 && b < num.count), "b必须大于等于0且不能越界")
    let tmp  = num[a]
    num[a] = num[b]
    num[b] = tmp
}


//加强版


var a = [1,2,3,4,5]
swap(num: &a, a: 0, b: 3)

