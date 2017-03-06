//: Playground - noun: a place where people can play

import UIKit

//快速排序 http://www.linuxidc.com/Linux/2015-09/122778.htm


//经典版本
func quickSort<T: Comparable>(array: inout [T], left: Int, right: Int)  {
    
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


//空间换时间
func quickSort<T: Comparable>(array:[T])->[T]{
    if array.count<=1 {
        return array
    }
    var left:[T]=[]
    var right:[T]=[]
    let pivot:T = array[array.count-1]
    
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


//极简版本
extension Array  {
    /* 属性decompose的作用是返回数组中的第一个元素和剩下的元素，注意这个属性是可选型的，当count为0的时候返回nil，count是Array的属性。使用扩展的原因是这种拆分可以实现非常多的操作，一劳永逸。*/
    var decompose: (head: Element, tail: [Element])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }
    
    static func swiftQuickSort<T: Comparable>(array: [T]) -> [T] {
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







//var a = [21,36,55,71,18]
//var b =  Array<Any>.swiftQuickSort(array: a)
//
//var a1 = [21,36,55,71,18]
//quickSort(array: &a1, left: 0, right: a.count - 1)
//
//var a2 = [21,36,55,71,18]
//quickSort(array: a2)
//
//var a3 = [21,36,55,71,18]
//a3.sorted(by: { $0 > $1 })
//a3




var a4:[Float] = [1.0,3.2,2.6]
//for _ in 0..<500{
//    a4.append(Int(arc4random() % 100))
//}

var a1 = a4
quickSort(array: &a1, left: 0, right: a1.count - 1)

var b4 =  Array<Any>.swiftQuickSort(array: a4)

a4.sorted(by: { $0 > $1 })



//归并排序
func mergeSort(array: [Int]) -> [Int] {
    var helper = Array(repeating: 0, count: array.count)
    var array = array
    mergeSort(array: &array, helper: &helper, low: 0, high: array.count - 1)
    return array
}

func mergeSort( array: inout [Int], helper: inout [Int], low: Int, high: Int) {
    guard low < high else {
        return
    }
    let middle = (high - low) / 2 + low
    mergeSort(array: &array, helper: &helper, low: low, high: middle)
    mergeSort(array: &array, helper: &helper, low: middle + 1, high: high)
    merge(array: &array, helper: &helper, low: low, middle: middle, high: high)
    
}

func merge( array: inout [Int], helper: inout [Int], low: Int, middle: Int, high: Int) {
    for i in low...high {
        helper[i] = array[i]
    }
    var helperLeft = low
    var helperRight = middle + 1
    var current = low
    while helperLeft <= middle && helperRight <= high {
        if helper[helperLeft] <= helper[helperRight] {
            array[current] = helper[helperLeft]
            helperLeft += 1
        } else {
            array[current] = helper[helperRight]
            helperRight += 1
        }
        current += 1
    }
    guard middle - helperLeft >= 0 else {
        return
    }
    for i in 0...middle - helperLeft {
        array[current + i] = helper[helperLeft + i]
    }
}
let b = [4,2,6,1,3,8,9]
let b1 = mergeSort(array: b)
print(b1)


