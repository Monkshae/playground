//
//  SortAlgorithm.swift
//  someCase
//
//  Created by licong on 2017/2/22.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class SortAlgorithm: NSObject {

    /*
        快速排序
     设置两个变量i、j，排序开始的时候：i=0，j=N-1；
     2）以第一个数组元素作为关键数据，赋值给key，即key=A[0]；
     3）从j开始向前搜索，即由后开始向前搜索(j--)，找到第一个小于key的值A[j]，将A[j]和A[i]互换；
     4）从i开始向后搜索，即由前开始向后搜索(i++)，找到第一个大于key的A[i]，将A[i]和A[j]互换；
     5）重复第3、4步，直到i=j； (3,4步中，没找到符合条件的值，即3中A[j]不小于key,4中A[i]不大于key的时候改变j、i的值，使得j=j-1，
        i=i+1，直至找到为止。找到符合条件的值，进行交换的时候i， j指针位置不变。另外，i==j这一过程一定正好是i+或j-完成的时候，此时令循环结束）。
     627389
     */
    
    
    static func quickSort(array: inout [Int], left: Int, right: Int)  {

        guard array.count > 0 else { return  }
        guard left  < array.count  else { return  }
        guard right < array.count  else { return  }

        //如果左边索引大于或者等于右边索引就代表已经整理完成一个组了
        guard   left < right  else {  return   }
        var i = left, j = right
        let key = array[left]
        
        //当i,j相遇的时候表示，现在以中间值为准，已经分出来了两半。如果是升序排列，中间值左边的都比它小，右边的都比它大
        while i < j {
            //从数组尾部开始遍历找到第一个比key小的数就退出循环,并且叫唤array[i],array[j]
            while  i < j && key <= array[j] {
                j -= 1
            }
            array[i] = array[j]
            
            while  i < j && key >= array[i] {
                i += 1
            }
            array[j] = array[i]
        }
        array[i] = key
        quickSort(array: &array, left: left, right: i - 1)
        quickSort(array: &array, left: i + 1, right: right)
        
    }
 
    
    //辅助空间
    func quickSort(array:[Int])->[Int]{
        if array.count<=1 {
            return array
        }
        var left:[Int]=[]
        var right:[Int]=[]
        let pivot:Int = array[array.count-1]
        
        for index in 0 ..< array.count-1 {
            if array[index] < pivot {
                left.append(array[index])
            }else{
                right.append(array[index])
            }
        }
        var result = quickSort(array: left)
        result.append(pivot)
        let rightResult = quickSort(array: right)
        result.append(contentsOf: rightResult)
        return result
    }
    
}


extension Array {
    /* 属性decompose的作用是返回数组中的第一个元素和剩下的元素，注意这个属性是可选型的，当count为0的时候返回nil，count是Array的属性。使用扩展的原因是这种拆分可以实现非常多的操作，一劳永逸。*/
    var decompose: (head: Element, tail: [Element])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }
    
    static func swiftQuickSort(array: [Int]) -> [Int] {
        if let (pivot, rest) = array.decompose {
            //这里是小于于pivot基数的分成一个数组
            let lesser = rest.filter{ $0 < pivot}
            //这里是大于等于pivot基数的分成一个数组
            let greater = rest.filter{ $0 > pivot}
            let a = [pivot]
            //递归 拼接数组
            return swiftQuickSort(array: lesser) + a + swiftQuickSort(array: greater)
        }else {
            return []
        }
    }
    
}

