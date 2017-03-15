//: Playground - noun: a place where people can play

import UIKit

//Sequence
//Iterator



/* 如何自己实现一个Swift数组
 为了简单，这里通过字典来存储数据,约定字典的key为从0开始的连续数字。就可以这样来实现IteratorProtocol:
 文章来源: http://www.jianshu.com/p/cd0e83f7f903 不过由于swift的升级，部分语法和原文有出入
 */

struct MyArrayIterator<T>: IteratorProtocol {
    private let dic: [Int: T]
    private var index = 0
    
    init(dic: [Int: T]) {
        self.dic = dic
    }
    
    mutating func next() -> T? {
        let element = dic[index]
        index += 1
        return element
    }
}


/*
 实现了IteratorProtocol，有了Iterator后，接下来实现Sequence协议
 */
struct MyArray<T>: Sequence {
    fileprivate  var dic: [Int: T]
    
    init(elements: T...) {
        dic = [Int: T]()
        for (i, element) in elements.enumerated() {
            dic[i] = element
        }
    }
    
    
    func makeIterator() ->  MyArrayIterator<Any> {
        return MyArrayIterator(dic: dic)
    }
}


extension MyArray: ExpressibleByArrayLiteral {
    
    typealias Element = T
    init(arrayLiteral elements: MyArray.Element...) {
        dic = [Int: T]()
        elements.forEach { dic[dic.count] = $0 }
        
        for (i, element) in elements.enumerated() {
            dic[i] = element
        }
    }
}



extension MyArray {
    subscript(index: Int) -> Element {
        precondition(index < dic.count, "Index out of bounds")
        return dic[index]!
    }
}


let array = MyArray(elements: "XiaoHong", "XiaoMing", "XiaoWang", "XiaoHuang", "XiaoLi")
print(array)
print(array[2])
array.map {_ in }

/*
 至此，一个自定义的数组就基本实现了，我们可以通过字面量来创建一个数组，可以通过下标来取值，可以通过for循环来遍历数组，可以使用map、forEach等高阶函数。
 */


/*
 上面我们为了弄清楚Sequence的实现原理，通过实现Sequence和Iterator来实现数组，但实际上Swift系统的Array类型是
 通过实现Collection来获得这些特性的，而Collection协议又遵守Indexable和Sequence这两个协议。并扩展了两个关联类
 型Iterator和SubSequence，以及9个方法，但这两个关联类型都是默认值，而且9个方法也都在协议扩展中有默认实现。
 因此，我们只需要为Indexable协议中要求的 startIndex 和 endIndex 提供实现，并且实现一个通过下标索引来获取对应索引的元素的方
 法。只要我们实现了这三个需求，我们就能让一个类型遵守 CollectionType 了。因此这个自定义的数组可以这样实现
 */



struct MyArray2<Element>: Collection {
    
   
    fileprivate var dic: [Int: Element]
    
    init(elements: Element...) {
        dic = [Int: Element]()
        elements.forEach { dic[dic.count] = $0 }
    }
    
    var startIndex: Int { return 0 }
    var endIndex: Int { return dic.count }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    public subscript(position: Int) -> Element {
        precondition(position < endIndex, "Index out of bounds")
        return dic[position]!
    }
}

extension MyArray2: ExpressibleByArrayLiteral {
    
    init(arrayLiteral elements: Element...) {
        dic = [Int: Element]()
        elements.forEach { dic[dic.count] = $0 }
    }
}



let array2 = MyArray2(elements: "XiaoHong1", "XiaoMing1", "XiaoWang1", "XiaoHuang1", "XiaoLi1")
print(array2)
print(array2[2])

for  i in array2 {
    print(i)
}
