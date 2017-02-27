//
//  Iterator.swift
//  someCase
//
//  Created by licong on 2017/2/21.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit


/*  给你一个嵌套的 NSArray 数据，实现一个迭代器类，该类提供一个 next() 方法，可以依次的取出这个 NSArray 中的数据。
 比如 NSArray 如果是 [1,[4,3],6,[5,[1,0]]]， 则最终应该输出：1, 4, 3, 6, 5, 1, 0 。
 另外，实现一个 allObjects 方法，可以一次性取出所有元素。
 给你一个嵌套的 NSArray 数据，实现一个迭代器类，该类提供一个 next() 方法，可以依次的取出这个 NSArray 中的数据。
 */

class IteratorCursor: NSObject {

    var index: Int
    var array = [Any]()
    /*
      定义了一个名为 NSArrayIteratorCursor 的类来记录遍历的位置，和当前位置的子数组(如果当前位置是数字，就没有子数组)
     */
    init(array:[Any]) {
        index = 0
        self.array = array
        super.init()

    }
}



class Iterator: NSObject {

    var result = [Any]()
    var stack: [IteratorCursor]
    var originArray: [Any]
    
    init(array:[Any]) {
        stack = [IteratorCursor]()
        originArray = array
        super.init()
        setupStack(array: array)


    }
    
    func setupStack(array:[Any]) {
        let cursor = IteratorCursor(array: array)
        stack.append(cursor)
    }
    
    func next() -> Int? {
        
        //判断栈里是否为空，如果是空返回nil
        guard stack.count > 0 else {
            return nil
        }
        //判断是否到了栈结尾,如果是就出栈
        var curser = stack.last
        guard curser != nil else {
            return nil
        }
        
        while stack.count > 0 && curser!.index == curser!.array.count{
            stack.removeLast()
            curser = stack.last
        }
        
        //判断栈里是否为空，如果是空返回nil
        guard stack.count > 0 else {
            return nil
        }
        
        //终于拿到元素了，需要判断拿到的是数组还是数子
        let item = curser!.array[curser!.index]
        if item is Array<Any> {
            curser!.index =  curser!.index + 1
            //如果是数组，则重新生成一个遍历的IteratorCursor对象，放到栈中，然后递归调用next方法
            setupStack(array: item as! Array<Any>)
            return next()
        }
        curser!.index =  curser!.index + 1
        return item as? Int;
    }
 
}



extension Iterator {
    
    func allObjects() {
        fillArray(array: originArray)
        print(result)
    }
    
    func fillArray(array:[Any]){
        for i in 0..<array.count {
            if array[i] is NSArray {
                fillArray(array: array[i] as! [Any])
            }else{
                result.append(array[i])
            }
        }
    }
}
