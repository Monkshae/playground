//: Playground - noun: a place where people can play

import UIKit


//http://www.qingpingshan.com/m/view.php?aid=200326

/* stride: 从“T”的一个实例的开始到“Array <T>”中的下一个的开始的字节数。
     这与'UnsafePointer <T>`移动的字节数相同
      增加。 `T`可能有一个较低的最小对齐.
   size:占用的连续内存,不包括任何动态分配或者远程的存储。当泛型是类类型的时候。size都是相同的，不论有多少存储属性
 */

/* 判断当前平台为位数 */

//class AClass {
//    var a: UInt8 = 0
//    var b: UInt32 = 0
//    var c: UInt64 = 0
//}
//
//class BClass {
//    var sa: AClass
//    var d: UInt8 = 0
//    init(aClass: AClass, value: UInt8) {
//        sa = AClass()
//        d = value
//    }
//}
//
//let is32Bit = MemoryLayout<Int>.stride == MemoryLayout<Int32>.stride
//
MemoryLayout<Int32>.stride
MemoryLayout<Int32>.size
//
//MemoryLayout<AClass>.size
//MemoryLayout<BClass>.size
//
//MemoryLayout<AClass>.stride
//MemoryLayout<BClass>.stride


//
//struct A {
//    var a: UInt8 = 0
//}
//
//
//struct A0 {
//    var a: UInt8 = 0
//    var b: UInt8 = 0
//}
//
//struct A1 {
//    var a: UInt8 = 0
//    var b: UInt32 = 0
//    var c: UInt8 = 0
//}
//
//struct B {
//    var a: A
//    var b: UInt16 = 0
//}
//
//struct C {
//    var b: B
//    var c: UInt16 = 0
//}

struct C0 {
    var a: UInt8
    var b: UInt64
    var c: UInt16
}

//struct D {
//    var c:C
//    var d: UInt8 = 0
//}
//
//
//struct E {
//    var d:D
//    var e: UInt8 = 0
//}
//
//struct F {
//    var e: E
//    var f: UInt8 = 0
//}
//
//struct G {
//    var e: E
//    var f: UInt16 = 0
//}
//
//struct H {
//    var g: G
//    var f: UInt8 = 0
//}

//func showMemory<T>(_ ptr: UnsafePointer<T>) {
//    let data = Data(bytes: UnsafeRawPointer(ptr), count: MemoryLayout<T>.size)
//    print(data as NSData)
//}

//var a = A(a: 0xaa)
////showMemory(&a)
//print(MemoryLayout<A>.size, MemoryLayout<A>.stride)
//
//
//var a0 = A0(a: 0xaa, b: 0xbb)
////showMemory(&a0)
//print(MemoryLayout<A0>.size, MemoryLayout<A0>.stride)
//
//var a1 = A1(a: 0xaa, b: 0xbbbbbbbb, c: 0xcc)
////showMemory(&a1)
//print(MemoryLayout<A1>.size, MemoryLayout<A1>.stride)
//
//
//var b = B(a: a, b: 0xbbbb)
////showMemory(&b)
//print(MemoryLayout<B>.size, MemoryLayout<B>.stride)
//
//
//var c = C(b:b, c:0xcccc)
////showMemory(&c)
//print(MemoryLayout<C>.size, MemoryLayout<C>.stride)

var c0 = C0(a:0xaa, b:0xbbbb, c:0xcccc)
//showMemory(&c0)
print(MemoryLayout<C0>.size, MemoryLayout<C0>.stride)

//var d = D(c: c, d: 0xcc)
//showMemory(&d)
//print(MemoryLayout<D>.size, MemoryLayout<D>.stride)
//
//
//var e = E(d: d, e: 0xdd)
//showMemory(&e)
//print(MemoryLayout<E>.size, MemoryLayout<E>.stride)
//
//var f = F(e: e, f:0xee)
//showMemory(&f)
//print(MemoryLayout<F>.size, MemoryLayout<F>.stride)
//
//var g = G(e: e, f:0xee)
//showMemory(&g)
//print(MemoryLayout<G>.size, MemoryLayout<G>.stride)
//
//var h = H(g: g, f:0xff)
//showMemory(&h)
//print(MemoryLayout<H>.size, MemoryLayout<H>.stride)


/* 对于类而言,size和stride是相同的等于8，不管有多少存储属性 */
class AClass {
    var a: UInt8 = 0
    var b: UInt32 = 0
    var c: UInt64 = 0
}

class BClass {
    var sa: AClass
    var d: UInt8 = 0
    init(aClass: AClass, value: UInt8) {
        sa = AClass()
        d = value
    }
}
//print(MemoryLayout<AClass>.size, MemoryLayout<AClass>.stride)
//print(MemoryLayout<BClass>.size, MemoryLayout<BClass>.stride)

/* 判断当前平台为位数 */
let is32Bit = MemoryLayout<Int>.stride == MemoryLayout<Int64>.stride
let is32Bit1 = MemoryLayout<Int>.size == MemoryLayout<Int64>.size

MemoryLayout<Int8>.alignment
/*
    对于结构体而言 size一定是小于或者等于stride，swift结构体里面是末尾直接拼接，而C语言是对齐后再拼接。对于简单的类型比如Intn，这种情况size和stride是相等的
 */

