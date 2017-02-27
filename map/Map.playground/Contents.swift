//: Playground - noun: a place where people can play

import UIKit

/*
    map 方法接受一个闭包作为参数， 然后它会遍历整个 numbers 数组，并对数组中每一个元素执行闭包中定义的操作。 相当于对数组中的所有元素做了一个映射。 比如咱们这个例子里面的闭包是讲所有元素都加 2 。 这样它产生的结果数据就是 [3,4,5,6]
 */
let numbers = [1,2,3,4]
let result = numbers.map { $0 + 2 }

/*
     map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>)表示这个闭包的返回值，是可以和传递进来的值不同
 */
let stringResult = numbers.map { "No.\($0)" }
stringResult



/* 
    numbersCompound.map { … } 这个调用实际上是遍历了这里两个数组元素 [1,2,3] 和 [4,5,6]。 因为这两个元素依然是数
    组，所以我们可以对他们再次调用 map 函数：$0.map{ $0 + 2 }。 这个内部的调用最终将数组中所有的元素加2
    flatMap 依然会遍历数组的元素，并对这些元素执行闭包中定义的操作。 但唯一不同的是，它对最终的结果进行了所谓的 “降维” 操
    作。 本来原始数组是一个二维的， 但经过 flatMap 之后，它变成一维的了
 
 */

let numbersCompound = [[1,2,3],[4,5,6]];
var res = numbersCompound.map { $0.map{ $0 + 2 } }
res
var flatRes = numbersCompound.flatMap { $0.map{ $0 + 2 } }
flatRes

Collection


