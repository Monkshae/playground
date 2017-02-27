//: Playground - noun: a place where people can play

import UIKit

/*
  Swift化零为整：Reduce方法详解 http://www.jianshu.com/p/671760c26061
  原文链接=http://appventure.me/2015/11/30/reduce-all-the-things/
 */


//最原始的写法
//func rmap(elements: [Int], transform: @escaping (Int) -> Int) -> [Int] {
//    return elements.reduce([Int](), { ( acc: [Int], obj: Int) -> [Int] in
//        var a = acc
//        a.append(transform(obj))
//        return a
//    })
//}

//改进写法
//func rmap(elements: [Int], transform: @escaping (Int) -> Int) -> [Int] {
//    return elements.reduce([Int](), { $0 + [transform($1)] })
//}

/* 
 这里有个地方需要引起注意：[1,2,3] + [4] 执行速度要慢于 [1,2,3].append(4)。倘若你正在处理庞大的列表，应取代集合 + 集合的方式，转而使用一个可变的 accumulator 变量进行递增：
 */
// 作者提倡使用这种，因为执行速度更快
func rmap(elements: [Int], transform: @escaping (Int) -> Int) -> [Int] {
    return elements.reduce([Int](), {
        var arr = $0
        arr.append($1)
        return arr
    })
}

//print(rmap(elements: [1, 2, 3, 4], transform: { $0 * 2}))

let mapped = [1, 2, 3, 4].map { Array(repeating: $0, count: $0) }
//Reduce 范例

// 初始值 initial 为 0，每次遍历数组元素，执行 + 操作
[0, 1, 2, 3, 4].reduce(0, +)


/*
 仅传入 + 作为一个 combinator 函数是有效的，它仅仅是对 lhs（Left-hand side，等式左侧） 和 rhs（Right-hand side，等式右侧） 做加法处理，最后返回结果值，这完全满足 reduce 函数的要求。
 
 另外一个范例：通过一组数字计算他们的乘积：
 */


// 初始值 initial 为 1，每次遍历数组元素，执行 * 操作
[1, 2, 3, 4].reduce(1, *)


//甚至我们可以反转数组：

// $0 指累加器（accumulator），$1 指遍历数组得到的一个元素
[1, 2, 3, 4, 5].reduce([Int](),  { [$1] + $0 })
// 5, 4, 3, 2, 1
//最后，来点有难度的任务。我们想要基于某个标准对列表做划分（Partition）处理：
// 为元组定义个别名，此外 Acc 也是闭包传入的 accumulator 的类型
typealias Acc = (l: [Int], r: [Int])
func partition(lst: [Int], criteria: (Int) -> Bool) -> Acc {
    return lst.reduce((l: [Int](), r: [Int]()), { (ac: Acc, o: Int) -> Acc in
        if criteria(o) {
            return (l: ac.l + [o], r: ac.r)
        } else {
            return (r: ac.r + [o], l: ac.l)
        }
    })
}
partition(lst: [1, 2, 3, 4, 5, 6, 7, 8, 9], criteria: { $0 % 2 == 0 })
//: ([2, 4, 6, 8], [1, 3, 5, 7, 9])
//上面实现中最有意思的莫过于我们使用 tuple 作为 accumulator。你会渐渐发现，一旦你尝试将 reduce 进入到日常工作流中，tuple 是一个不错的选择，它能够将数据与 reduce 操作快速挂钩起来。

//执行效率对比：Reduce vs. 链式结构

//reduce 除了较强的灵活性之外，还具有另一个优势：通常情况下，map 和 filter 所组成的链式结构会引入性能上的问题，因为它们需要多次遍历你的集合才能最终得到结果值，这种操作往往伴随性能损失，比如以下代码：

[0, 1, 2, 3, 4].map({ $0 + 3}).filter({ $0 % 2 == 0}).reduce(0, +)
//除了毫无意义之外，它还浪费了 CPU 周期。初始序列（即 [0,1,2,3,4]）被重复访问了三次之多。首先是 map，接着 filter，最后对数组内容求和。其实，所有这一切操作我们能够使用 reduce 完全替换实现，极大提高执行效率：

// 这里只需要遍历 1 次序列足矣
[0, 1, 2, 3, 4].reduce(0, { (ac: Int, r: Int) -> Int in
    if (r + 3) % 2 == 0 {
        return ac + r + 3
    } else {
        return ac
    }
})
//这里给出一个快速的基准运行测试，使用以上两个版本以及 for-loop 方式对一个容量为 100000 的列表做处理操作：

// for-loop 版本
var ux = 0
for i in Array(0...100000) {
    if (i + 3) % 2 == 0 {
        ux += (i + 3)
    }
}



//不过，在某些情况中，链式操作是优于 reduce 的。思考如下范例：

//let a = Array(0...100000).map({ $0 + 3}).reversed().prefix(3)
//a
//Array(0...100000).reduce([], { (ac: [Int], r: Int) -> [Int] in
//    var a = ac
//    a.insert(r + 3, at: 0)
//    return a
//}).prefix(3)



let persons: [[String: Any]] = [
    ["name": "Carl Saxon", "city": "New York, NY", "age": 44],
    ["name": "Travis Downing", "city": "El Segundo, CA", "age": 34],
    ["name": "Liz Parker", "city": "San Francisco, CA", "age": 32],
    ["name": "John Newden", "city": "New Jersey, NY", "age": 21],
    ["name": "Hector Simons", "city": "San Diego, CA", "age": 37],
    ["name": "Brian Neo", "age": 27]]
//注意这家伙没有 city 键值

func infoFromState(state: String, persons: [[String: Any]])
    -> (count: Int, age: Float) {
        
        // 在函数内定义别名让函数更加简洁
        typealias Acc = (count: Int, age: Float)
        
        // reduce 结果暂存为临时的变量
        let u = persons.reduce((count: 0, age: 0.0)) {
            (ac: Acc, p) -> Acc in
            
            let a = (p["city"] as? String)?.components(separatedBy: ", ").last
            let b = p["age"] as? Int
            
            /* 获取地区和年龄，奇怪的是不写临时变量的时候有问题 
             guard let personState = (p["city"] as? String)?.components(separatedBy: ", ").last, let personAge = p["age"] as? Int, personState == state
            */
            guard let personState = a, let personAge = b, personState == state
                // 如果缺失年龄或者地区，又或者上者比较结果不等，返回
                else {
                    return ac
            }

            // 最终累加计算人数和年龄
            return (count: ac.count + 1, age: ac.age + Float(personAge))
        }
        
        // 我们的结果就是上面的人数和除以人数后的平均年龄
        return (age: u.age / Float(u.count), count: u.count)
}
print(infoFromState(state: "CA", persons: persons))
// prints: (count: 3, age: 34.3333)

