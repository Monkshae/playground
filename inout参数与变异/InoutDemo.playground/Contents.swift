//: Playground - noun: a place where people can play

import UIKit

//http://www.jianshu.com/p/3fb6940e59cb

/*
  在Swift中，初次接触inout关键字以及它的用法，可能会让我们想起C/C++中的指针，但实际上
  Swift中inout只不过是按值传递，然后再写回原变量，而不是按引用传递:
 
  An in-out parameter has a value that is passed in to the function, is 
  modified by the function, and is passed back out of the function to 
  replace the original value.
  
  这样的好处在于它远比使用引用安全。
 */

func increase