//: Playground - noun: a place where people can play

import UIKit

//https://github.com/bestswifter/WeeklySwift/blob/master/week-2/%E4%B8%83%E4%B8%AASwift%E4%B8%AD%E7%9A%84%E9%99%B7%E9%98%B1%E4%BB%A5%E5%8F%8A%E9%81%BF%E5%85%8D%E6%96%B9%E6%B3%95.md

enum Grain { case Wheat, Corn }

protocol Pizza {}

extension Pizza {  var crustGrain: Grain { return .Wheat }  }

struct  NewYorkPizza: Pizza { }
struct  ChicagoPizza: Pizza { }
//这里重写了结构体的协议的属性，但是写错了，少了一个r
//struct  CornmealPizza: Pizza {  let crustGain: Grain = .Corn }

//print(NewYorkPizza().crustGrain)       // returns Wheat
//print(ChicagoPizza().crustGrain)       // returns Wheat
//print(CornmealPizza().crustGrain)      // returns Wheat  What?!

//通过打印，我们可以看见结构体，当重写协议属性的时候，不像Class那样会通过override来让编译器发现错误，在协议扩展中重写协议中的属性时要仔细核对




//现在我们把拼写错误改过来(注释掉上面错误的)
struct  CornmealPizza: Pizza {  let crustGain: Grain = .Corn }
var pie: Pizza
pie =  NewYorkPizza(); pie.crustGrain  // returns Wheat 
pie =  ChicagoPizza(); pie.crustGrain  // returns Wheat 
pie =  CornmealPizza(); pie.crustGrain  // returns Wheat    Not again?!
/*
 为什么这个程序显示cornmeal pizza 包含wheat？Swift编译代码的时候忽略了变量的目前实际值。代码只能够使用编译时期的知道的信息，并不知道运行时期的具体信息。程序中可以在编译时期得到的信息是pie是pizza类型，pizza协议扩展返回wheat，所以在结构体CornmealPizza中的重写起不到任何作用。虽然编译器本能够在使用静态调度替换动态调度时，为潜在的错误提出警告，但它实际上并没有这么做。这里的粗心将带来巨大的陷阱
 */


//在这种情况下，Swift提供一种解决方案，除了在协议扩展中（extension）定义crustGrain属性之外，还可以在协议中声明。
/*
    在协议内声明变量并在协议拓展中定义，这样会告诉编译器关注变量pie运行时的值,在协议中一个属性的声明有两种不同的含义，
    态还是动态调度，取决于是否这个属性在协议扩展中定义。补充了协议中变量的声明后，代码可以正常运行了
 */
protocol  Pizza1 {  var crustGrain: Grain { get }  }
extension Pizza1 {  var crustGrain: Grain { return .Wheat }  }
struct  CornmealPizza1: Pizza1 {  let crustGrain: Grain = .Corn }
var pie1 =  CornmealPizza1()
print(pie1.crustGrain)  // returns Corn    Whew!




/*
 然而这个设法避免陷阱的方式并不总是有效的。
 
 导入的协议不能够完全扩展。
 
 框架（库）可以使一个程序导入接口去使用，而不必包含相关实现。例如苹果提供给我们提供了需要框架，实现了用户体验、系统设施和其他功能。Swift的扩展允许程序向导入的类、结构体、枚举和协议中添加自己的属性(这里的属性并不是存储属性)。通过协议拓展添加的属性，就好像它原来就在协议中一样。但实际上定义在协议拓展中的属性并非一等公民，因为通过协议拓展无法添加属性的声明。
 
 我们首先实现一个框架，这个框架定义了Pizza协议和具体的类型
 
*/

/* 不要对导入的协议进行扩展，新增可能需要动态调度的属性,因为没有在协议中声明 */
/* 如果一个新的属性需要动态调度，避免使用约束性协议扩展 ，因为约束性扩展的定义总是静态调度的 */

