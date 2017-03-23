//: Playground - noun: a place where people can play

import UIKit

/*
  Swift 3中 - C与语言风格的循环已经成为历史
  大多数语言都是使用C语言风格的操作符来表示循环。移除这个操作意味着以后就不能用了。因为用for-in操作完全可以替代的
  以前可以写：
 
  for (i = 1; i <= 10; i++) {
    print(i)
  }
  在Swift3中，不允许这样的写法，用...表示的范围
 */

let array = Array(0...10)
for i in array {
    print(i)
}

//为啥这里会多一次？？？
array.forEach {  print($0) }


//关于倒序遍历的问题
array.reversed().forEach { print($0)}



/* 步长为-2的倒叙呢？如果生成等差数列的时候，(from - through) % by == 0, (from - to) % by == 0
   前者要比后者多一个元素,文档说并不保证through在数列中（比如设置步长为3）
 */

for i in stride(from: 10, through: 0, by: -2) {
//    print(i)
}

//to一定不再生成的数列中
for i in stride(from: 10, to: 0, by: -2) {
//    print(i)
}

let a = stride(from: 10, to: 0, by: -2)

//倒叙
array.reduce([Int]()) {
    [$1] + $0
}

//取出公约数
let b = array.reduce([Int]()) {
    if($1 % 2 == 0  && $1 % 5 == 0){
        return  [$1] + $0
    } else{
        return $0
    }
}


