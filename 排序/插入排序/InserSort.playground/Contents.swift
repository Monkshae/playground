//: Playground - noun: a place where people can play

import UIKit

//插入排序

func insetSort<T: Comparable>(array: inout [T], first: Int, last: Int) {
    var j = 0
    var tmp: T    
    for i in first + 1 ..< array.count {
        tmp = array[i]
        j = i - 1
        
        //与已排序的数逐一比较，大于temp时，该数移后
        while j >= 0 && array[j] > tmp {
            array[j+1] = array[j]
            j -= 1
        }
        
        //存在大于temp的数
        if j != i - 1 {
            array[j+1] = tmp
        }
    }
}

var a = [2.4,6,2.77,4,5,8,9]
insetSort(array: &a, first: 0, last: a.count - 1)

