//: Playground - noun: a place where people can play

import UIKit


var name:String? = "Oc"
var age: Int? = 15


/* if var对{}中的值可做修改 */

//例1:   只对name的值做修改
if var name1 = name, let age1:Int = age {
    //只对name对修改age不做修改那么在age1要给予let告诉编译器age不做修改
    name1 = "Swift"
    print(name1 + String(age1))
}
//结果: Swift15

//例2： 对name和age都做修改
if var name1 = name, var age1:Int = age {
    //age没有声明let 编译器会认为此时age是可以修改的
    name1 = "Swift"
    age1 = 20
    print(name1 + String(age1))
}


/* if let 对{}中的值不能做修改 */
if let name1 = name, let age1 = age{
    print(name1 + String(age1))
}

/* guard let   
    1.guard let 和 if let刚好相反 guarg 守护一定有值，如果没有值 就直接返回
    2.通常判断后有值就直接做逻辑处理
    3.guard let 降低分支，if let 会凭空多一条分支 
 */

func demo() {
    //guard let name和age都不可以改变
    guard let name1 = name,let age1 = age else {
        print("ssssss")
        return
    }
    print(name1 + String(age1))
}


/* guard var */
func demo1() {
    //guard var可以改变一个或者两个的值(name/age)
    guard var name1 = name, var age1 = age else {
        print("其中有个值为ni")
        return
    }
    name1 = "Swift"
    age1 = 2
    print(name1 + String(age1))
}

demo()
demo1()


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





