//: Playground - noun: a place where people can play

import UIKit

//给一个数组，要求写一个函数，交换数组中的两个元素

//简单的写法
func swap(nums: inout [Int], a: Int, b: Int){
    guard nums.count > 0 else { return }
    //这里a、b都有前置条件，如果这么写表示这是一个不完全函数。更好的方式比较麻烦，需要在外部重新定义的输入值得定义域
    //http://www.cocoachina.com/swift/20160318/15729.html
    //http://www.cocoachina.com/swift/20160323/15751.html?utm_source=tuicool&utm_medium=referral
    
    assert((a >= 0 && a < nums.count), "a必须大于等于0且不能越界")
    assert((b >= 0 && b < nums.count), "b必须大于等于0且不能越界")
    let tmp  = nums[a]
    nums[a] = nums[b]
    nums[b] = tmp
}


//使用泛型的加强版
func swap<T>(nums: inout [T], a: Int, b: Int) {
    guard nums.count > 0 else { return }
    assert((a >= 0 && a < nums.count), "a必须大于等于0且不能越界")
    assert((b >= 0 && b < nums.count), "b必须大于等于0且不能越界")
    let tmp = nums[a]
    nums[a] = nums[b]
    nums[b] = tmp
}

var array = [1.2,4,5,7,97,32,23]
swap(nums: &array, a: 0, b: 3)


//如果仅仅比较的是整数 最简单的是 泛型+位操作
func swapWithBit(nums: inout [Int], a:Int, b: Int) {
    guard nums.count > 0 else { return }
    assert((a >= 0 && a < nums.count), "a必须大于等于0且不能越界")
    assert((b >= 0 && b < nums.count), "b必须大于等于0且不能越界")
    nums[a] = nums[a] ^ nums[b]
    nums[b] = nums[a] ^ nums[b]
    nums[a] = nums[a] ^ nums[b]
}

var array1 = [1,4,5,-7,97,32,23]
swapWithBit(nums: &array1, a: 0, b: 3)


//终极版本大boss
func swapWithTuple<T>(nums: inout [T], a: Int, b: Int){
    guard nums.count > 0 else { return }
    assert((a >= 0 && a < nums.count), "a必须大于等于0且不能越界")
    assert((b >= 0 && b < nums.count), "b必须大于等于0且不能越界")
    (nums[a], nums[b]) = (nums[b], nums[a])
}
var array2 = [1,4.3,-5.7,7,9.6,32,23]
swapWithTuple(nums: &array2, a: 0, b: 2)
	
