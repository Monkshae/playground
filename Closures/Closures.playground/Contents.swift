//: Playground - noun: a place where people can play

import UIKit

/*
    问题来源 http://stackoverflow.com/questions/27364117/is-swift-pass-by-value-or-pass-by-reference
 */


//数组和数组之间赋值是属于值传递
var a = [1, 2, 3]
var b = a
let c = a
a[0] = 42

print(a[0])
// 42
print(b[0])
// 42
print(c[0])



//当一个常量或者变量作为数组、字典、集合等集合类型的元素时。属于值传递，只不过编译器会优化，只有值改变的时候才会立即copy


//class和class之间是引用传递
class Student {
    var age:[Int]
    init(age: [Int]) {
        self.age = age
    }
}

var student1 = Student(age: [23])
let student2 = student1
if student1 === student2 {
    print("student1 和 student2 指向的是同一个地址")
}

student1.age = [23,45]
student1.age
student2.age



func test(some: inout [Int]){
    
    print(Unmanaged<AnyObject>.passUnretained(some as AnyObject).toOpaque())
    print(Unmanaged<AnyObject>.passUnretained(b as AnyObject).toOpaque())

}

test(some: &b)



/*
 http://blog.stablekernel.com/when-to-use-value-types-and-reference-types-in-swift
 大概翻译如下:
 因为引用类型管理共享内存，所以需要做一些工作来为对象分配堆内存，并在不再需要时清除该内存。这通过跟踪对每个引用类型的引用的数量并在引用计数达到0时清除该存储器来完成。这WWDC谈话是伟大的更好地了解内存和值和参考类型的性能。而两者之间的基本差异相当直接，当它们混合在一起时它们如何相互作用是重要的。
 
 具有多个引用类型属性的值类型将比具有引用类型具有更多的内存开销。无论何时复制值类型，都会创建一个新实例，并且每个引用类型属性都有引用计数开销。此外，对值类型使用引用类型否定了下面将介绍的具有值类型的几个好处。
 
 将值类型包括为引用类型的属性实际上可以提高性能，因为在复制引用类型时不会为引用类型创建新实例。因此，将此引用类型传递到函数中，或将其分配给另一个变量也不会导致其值类型属性被复制。好吧，到目前为止那么好，对吧？如果你混合类型，只要确保使用引用类型作为顶级对象，一切都应该确定。还是会呢？这是一些混乱开始的地方...
 
 作为集合的Swift值类型：数组，字典，集合和字符串，它们是字符集合，都由引用类型支持。 使用引用类型来备份这些集合只允许它们在更改时进行复制。意思是：将不会导致初始数组的任何副本。这对于传递大集合时的性能非常有帮助，因为在修改集合的内容之前不会复制它们。但是，当您将这些集合作为其他值类型的属性时，您会遇到相同的引用计数开销，包括引用类型作为值类型上的属性。
 
 这些集合和其他价值类型之间的差异似乎是在我看到过这个话题的不同会话和博客帖子中最被误解或误解。然而，理解这一点似乎清除了很多混乱和看似矛盾的观点。所以什么时候应该使用值类型？一些博客或谈话将告诉你，值类型应该只用于小的，基本的模型对象。其他人会告诉你，你应该只使用值类型，除非类是绝对必要的。一个同意我对这个问题的答案，我经常遇到，是开始一个值类型，直到需要一个引用类型。 '放弃'点是个人与人之间似乎有所不同，作为一个程序员来自Objective-C，我发现我有一个倾向，放弃太快，只是移动到一个类，似乎方便。
 
 我特别不喜欢制作的想法，我认为是不必要的，模型对象的副本不断。然而，这是否真的是远离价值类型的好理由？正如苹果在上面提到的WWDC视频中指出的，在Swift中拷贝很便宜。当然，它们中的引用类型的值类型和值类型集合会带来一些引用计数开销，但是与使用值类型的好处相比，这真的很重要吗？在某些情况下，是的，这绝对可以是重要的，但值得探索价值类型和引用类型的好处，以便您可以做出明智的决定，使用
 
 引用类型的额外内存和性能开销提供了更多的功能，特别是继承和其他选项继承提供，如动态分派的方法。根据定义，它们还具有多个所有者的能力，这对于从其他来源接收动作，事件和消息是有用的。
 
 引用类型的额外内存和性能开销提供了更多的功能，特别是继承和其他选项继承提供，如动态分派的方法。根据定义，它们还具有多个所有者的能力，这对于从其他来源接收动作，事件和消息是有用的。
 
 如果你需要为你的对象继承或多个所有者，类肯定是要走的路;如果你不需要这些东西，有一个很好的机会，你会更好地服务一个值类型。也许你实际上不需要继承，但你需要动态调度的方法。这也可以使用值类型和原始调度方法来完成。这也可以使用值类型和协议
 
 因为引用类型可能指同一个实例，identity（===）有意义。所以在我们的初始Person示例中，如果我们想知道我的邻居是否是Bob，我们想知道它是否是完全相同的人，而不仅仅是任何具有相同姓名和年龄的人。
 
 对于值类型，由于我们在复制时创建新实例，我们需要能够比较它们而不是它们的身份，而是他们的值。因此，在这种情况下，使用等号（==）来比较值类型通常是有意义的。
 
 如果我有一个20美元的钞票，有人拿它，并用另一个20美元的钞票替换，我可能甚至不注意。票据的身份不重要，价值是。当考虑你的模型，并试图找出使用哪种类型，看看是否有意义的比较对象与身份或平等。如果它显然是一个或另一个，它可以使参考和值类型之间的决定容易。
 
 这是另一个反对将引用类型作为值类型上的属性的参数，因为这使得难以将值类型与等号进行比较。如果你不能使用平等来比较它的属性，它使得很难使对象本身等同。 同时可以有利于允许对象具有多个所有者，如果这不是必要的，则它只会导致问题。当您的对象有多个所有者时，它们隐含地依赖于其他所有者，这些所有者可以随时从对象下方将对象更改。这会创建更难跟踪和删除的错误。它也使你的代码更难理解，当你使用一个对象;你不知道它的其他所有者可能在哪里，它可能会改变。当使用值类型时，你总是知道你是它的唯一所有者，并使得围绕它的代码的推理更容易。类似地，仅具有单个所有者的值类型使得线程更容易，因为您不需要锁定，以防止其他线程在使用它时修改值类型。这些优点甚至对于由引用类型支持的值类型存在，并且可以大大超过将这些包括在其他值类型中所引起的引用计数开销。
 
 vaule类型给你更好的控制可变性。当声明一个引用类型时，你只需要确保对对象的引用不会改变。但是，用let声明的值类型根本不能修改。你可以创建类的所有属性声明with let使类不可变（这也有助于线程和多个所有者问题），你失去了对价值类型的控制，使他们可变或不可变的需要。这个不可变性也更难执行，因为其他程序员（或未来你）可以添加可变属性到类或使一个具有可变属性的子类。修改其值的值类型的方法必须明确标记为mutating，使它更清楚函数的作用，并使其更容易控制对象的可变性
 
 引用类型导致更多的内存开销，从引用计数和用于将其数据存储在堆上。值得了解的是，在Swift中复制值类型相对便宜，但重要的是要记住，如果你的值类型变得太大，复制的性能成本可能会大于使用引用类型的成本。
 
 苹果在其Swift Github库和一些WWDC会议上提出的一个技巧是将一个结构体包装在一个引用类型中，并创建你自己的copy-on-write行为，如集合值类型。这防止结构在赋值时复制，或者当作为参数传递给函数时。这很容易使用isKnownUniquelyReferenced函数和内部引用类型：
 
 上面的代码来自上面链接的优化提示文档，但是为Swift 3更新。本文档是深入了解Swift性能的另一个很好的地方。有没有容易的快速石蕊测试知道什么时候使用引用类型而不是值类型，但如果你了解两者之间的折衷，并记住默认值类型，你应该有足够的能力作出正确的决定时，写作你的代码。
 
 */


class Ref<T> {
    var val : T
    init(_ v : T) {val = v}
}

struct Box<T> {
    var ref : Ref<T>
    init(_ x : T) { ref = Ref(x) }
    
    var value: T {
        get { return ref.val }
        set {
            if (!isKnownUniquelyReferenced(&ref)) {
                ref = Ref(newValue)
                return
            }
            ref.val = newValue
        }
    }
}




//swift3 类和结构体官方文档 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_145


/*
 Swift中除了类和闭包是引用类型以外，其余的都是值类型(Int,String,Array,Dictionary等)。
 值类型和引用类型、值传递和引用传递是两回事。
 1.当作为普通的赋值的时候,值类型是值传递，引用类型是引用传递。
 2.当值类型作为参数传递给函数的时候，默认是值传递，但是加上inout修饰符后，就是引用传递。调用的时候参数前需要加&
 3.引用类型的变量a赋值给引用类型的常量b，当变量a值改变的时候，常量b也会改变。虽然无法直接修改b
 4.类虽然是引用类型，但是let实例化后的对象属性可以修改，对象本身不能改变。但是结构体就不能修改
 5.作为集合的值类型：数组，字典，集合和字符串，它们是字符集合，都由引用类型支持。使用引用类型来备份这些集合只允许它们在更改时进行复制。
 */



struct SomeStruct {
    var value: Int
}

var aStruct = SomeStruct(value: 0)
aStruct.value = 1 // The compiler won't let you do this

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    //系统会初始化为nil，一旦初始化成功后，就不能为nil
    var name: String!
}


let  v = VideoMode()
v.name

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}



func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    print(runningTotal)
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()



/*  swift3闭包官方文档 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID94
    对照的中文翻译
    http://howrudatou.blogspot.jp/2015/12/iosswift3.html
 */


//逃逸闭包和非逃逸闭包
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"



//自动闭合

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
 //Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)


func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"



// customersInLine is ["Ewa", "Barry", "Daniella"]
//@autoclosure and Nonescaping
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"


//@autoclosure and @escaping
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"

