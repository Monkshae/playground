//: Playground - noun: a place where people can play

import UIKit


/* 
  二分查找
  http://www.jianshu.com/p/1146243648f6
 
 */

func binarySearch<T: Comparable>(array: [T], targetValue: T) -> Int? {
    var leftIndex = 0, rightIndex = array.count - 1
    while leftIndex < rightIndex {
        let middleIndex = (leftIndex + rightIndex) / 2
        let middleValue = array[middleIndex]
        if middleValue < targetValue {
            leftIndex = middleIndex + 1
        }else if(middleValue > targetValue) {
            rightIndex = middleIndex - 1
        }else {
            return middleIndex
        }
    }
    return nil
}

var a = [1,2,3,5,5,7,10,36,50]

binarySearch(array: a, targetValue: 30)

