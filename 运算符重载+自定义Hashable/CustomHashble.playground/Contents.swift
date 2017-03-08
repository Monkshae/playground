//: Playground - noun: a place where people can play

import UIKit

//https://www.swiftmi.com/topic/89.html


/*
    假如有个Bit类，其中含有CGPoint类型的point属性
    疑问:Bit之间怎么实现比较？ 答案:实现Hashable协议就可以,而Hashable实际上又需要实现 Equatable协议
 */

class Bit: Hashable {
    var point : CGPoint
    init(point : CGPoint) {
        self.point = point
    }
    
    /* 我们需要实现hashValue属性的getter,总所周知String类型是实现了Hashable的(String类型之间是可以直接比较,排序),所以可以利用String这点来实现Getter
    */
    var hashValue : Int {
        get {
            return "\(self.point.x),\(self.point.y)".hashValue
        }
    }
}


func ==(lhs: Bit, rhs: Bit) -> Bool {
    return lhs.hashValue == rhs.hashValue
}


var point_a_1_0 = Bit(point: CGPoint(x: 1, y: 0))
var point_b_1_0 = Bit(point: CGPoint(x: 1, y: 0))
var point_c_0_1 = Bit(point: CGPoint(x: 0, y: 1))

point_a_1_0 == point_b_1_0
point_a_1_0 == point_c_0_1


/*
  与 Objective-C 不同，Swift 支持重载操作符这样的特性，最常见的使用方式可能就是定义一些简便的计算了
   http://swifter.tips/operator/
 */

//二维向量的数据结构
struct Vector2D {
    var x = 0.0
    var y = 0.0
}

/*
 一个很简单的需求是两个 Vector2D 相加：
 // v3 为 {x 3.0, y 7.0}
 如果只做一次的话似乎还好，但是一般情况我们会进行很多这种操作。这样的话，我们可能更愿意定义一个 Vector2D 相加的操作，来让代码简化清晰。
 */

let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)
let v3 = Vector2D(x: v1.x + v2.x, y: v1.y + v2.y)

//两个向量相加，我们可以重载加号操作符
func +(left: Vector2D, rigth: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + rigth.x, y: left.y + rigth.y)
}
let v4 = v1 + v2

/* 
 类似地，我们还可以为 Vector2D 定义像 - (减号，两个向量相减) ，- (负号，单个向量 x 和 y 同时取负) 等等这样的运算符。这个就作为练习交给大家。
 
 上面定义的加号，减号和负号都是已经存在于 Swift 中的运算符了，我们所做的只是变换它的参数进行重载。如果我们想要定义一个全新的运算符的话，要做的事情会多一件。比如点积运算就是一个在矢量运算中很常用的运算符，它表示两个向量对应坐标的乘积的和。根据定义，以及参考重载运算符的方法，我们选取 +* 来表示这个运算的话，不难写出
 */
func +* (left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y + right.y
}

/* 
  这是因为我们没有对这个操作符进行声明。之前可以直接重载像 +，-，* 这样的操作符，是因为 Swift 中已经有定义了，如果我们要新加操作符的话，需要先对其进行声明，告诉编译器这个符号其实是一个操作符。添加如下代码
 */

infix operator +* : ATPrecedence
precedencegroup ATPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

let v5 = v1 +* v2

/* 
    infix
 
    表示要定义的是一个中位操作符，即前后都是输入；其他的修饰子还包括 prefix 和 postfix，不再赘述；
    
    associativity
    定义了结合律，即如果多个同类的操作符顺序出现的计算顺序。比如常见的加法和减法都是 
    left，就是说多个加法同时出现时按照从左往右的顺序计算 (因为加法满足交换律，所以这个顺序
    无所谓，但是减法的话计算顺序就很重要了)。点乘的结果是一个 Double，不再会和其他点乘结
    合使用，所以这里写成 none
 
    precedence
    运算的优先级，越高的话越优先进行运算。Swift 中乘法和除法的优先级是 150，加法和减法是 
    140，这里我们定义点积优先级 160，就是说应该早于普通的乘除进行运算。
 
 
 
     直接指定操作符的类型，对这个类型进行定义，associativity: left 表示左结合
     higherThan 优先级高于 AdditionPrecedence 这个是加法的类型
     lowerThan 优先级低于 MultiplicationPrecedence 乘除
 
     这里给出常用类型对应的group

     infix operator || : LogicalDisjunctionPrecedence
     infix operator && : LogicalConjunctionPrecedence
     infix operator < : ComparisonPrecedence
     infix operator <= : ComparisonPrecedence
     infix operator > : ComparisonPrecedence
     infix operator >= : ComparisonPrecedence
     infix operator == : ComparisonPrecedence
     infix operator != : ComparisonPrecedence
     infix operator === : ComparisonPrecedence
     infix operator !== : ComparisonPrecedence
     infix operator ~= : ComparisonPrecedence
     infix operator ?? : NilCoalescingPrecedence
     infix operator + : AdditionPrecedence
     infix operator - : AdditionPrecedence
     infix operator &+ : AdditionPrecedence
     infix operator &- : AdditionPrecedence
     infix operator | : AdditionPrecedence
     infix operator ^ : AdditionPrecedence
     infix operator * : MultiplicationPrecedence
     infix operator / : MultiplicationPrecedence
     infix operator % : MultiplicationPrecedence
     infix operator &* : MultiplicationPrecedence
     infix operator & : MultiplicationPrecedence
     infix operator << : BitwiseShiftPrecedence
     infix operator >> : BitwiseShiftPrecedence
     infix operator ..< : RangeFormationPrecedence
     infix operator ... : RangeFormationPrecedence
     infix operator *= : AssignmentPrecedence
     infix operator /= : AssignmentPrecedence
     infix operator %= : AssignmentPrecedence
     infix operator += : AssignmentPrecedence
     infix operator -= : AssignmentPrecedence
     infix operator <<= : AssignmentPrecedence
     infix operator >>= : AssignmentPrecedence
     infix operator &= : AssignmentPrecedence
     infix operator ^= : AssignmentPrecedence
     infix operator |= : AssignmentPrecedence
 
    //https://github.com/apple/swift/blob/master/stdlib/internal/SwiftExperimental/SwiftExperimental.swift
    //关于+,-,*,/等的操作符源码定义地址
    //https://github.com/apple/swift/blob/928a3193ebe4897c23830da6b27ebd708459c3ad/stdlib/public/core/Policy.swift
    最后需要多提一点的是，Swift 的操作符是不能定义在局部域中的，因为至少会希望在能在全局范
    围使用你的操作符，否则操作符也就失去意义了。另外，来自不同 module 的操作符是有可能冲
    突的，这对于库开发者来说是需要特别注意的地方。如果库中的操作符冲突的话，使用者是无法像
    解决类型名冲突那样通过指定库名字来进行调用的。因此在重载或者自定义操作符时，应当尽量将
    其作为其他某个方法的 "简便写法"，而避免在其中实现大量逻辑或者提供独一无二的功能。这样
    即使出现了冲突，使用者也还可以通过方法名调用的方式使用你的库。运算符的命名也应当尽量明
    了，避免歧义和可能的误解。因为一个不被公认的操作符是存在冲突风险和理解难度的，所以我们
    不应该滥用这个特性。在使用重载或者自定义操作符时，请先再三权衡斟酌，你或者你的用户是否
    真的需要这个操作符。
 */



// http://www.jianshu.com/p/76d81df3b747
// http://www.jianshu.com/p/b3d7536b3858



/* Swift教程之运算符重载 http://www.cocoachina.com/swift/20150204/11091.html
    强烈推荐
 */
protocol Number {  // 1
     static func +(l: Self, r: Self) -> Self // 2
}

extension Double : Number {} // 3
extension Float  : Number {}
extension Int    : Number {}

infix operator ⊕: ArrayAddPrecedence
precedencegroup ArrayAddPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

//泛型遵守一个协议
func ⊕<T:Number>(left: [T], right: [T]) -> [T] { // 4
    var minus = [T]()
    assert(left.count == right.count, "vector of same length only")
    for (key, _) in left.enumerated(){
        minus.append(left[key] + right[key])
    }
    return minus
}

var doubleArray = [2.4, 3.6] ⊕ [1.6, 2.4]
var intArray = [2, 4] ⊕ [1, 2]
