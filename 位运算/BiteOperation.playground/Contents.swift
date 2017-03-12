//: Playground - noun: a place where people can play

import UIKit

//http://swift.gg/2016/03/30/Dealing-With-Bit-Sets-In-Swift/
//https://github.com/uraimo/Bitter

/* stride : 从“T”的一个实例的开始到“Array <T>”中的下一个的开始的字节数。
     这与'UnsafePointer <T>`移动的字节数相同
      增加。 `T`可能有一个较低的最小对齐.
 
 */

/* 判断当前平台为位数 */

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

let is32Bit = MemoryLayout<Int>.stride == MemoryLayout<Int32>.stride

MemoryLayout<Int32>.stride
MemoryLayout<Int32>.size

MemoryLayout<AClass>.size
MemoryLayout<BClass>.size

MemoryLayout<AClass>.stride
MemoryLayout<BClass>.stride


//struct A {
//    var a: UInt8 = 0
//    var b: UInt32 = 0
//    var c: UInt64 = 0
//}
//
//struct B {
//    var sa: A
//    var d: UInt8 = 0
////    var f: UInt32 = 0
//}
//
//
//
//
//print(MemoryLayout<A>.size, MemoryLayout<A>.stride)
//print(MemoryLayout<B>.size, MemoryLayout<B>.stride)


/* 整型转换
  因为在把一个大尺寸的整型转换为较小的整型或者把一个无符号整型转换为一个有符号整型时，
  Swift 不会对变量内的值进行任何截短操作，所以如若转换后的整型无法装下赋给它的值，就会导致
  溢出并引发运行时错误。
 */
extension Int {
    public var toU8: UInt8{ get{return UInt8(truncatingBitPattern:self)} }
    public var to8: Int8{ get{return Int8(truncatingBitPattern:self)} }
    public var toU16: UInt16{get{return UInt16(truncatingBitPattern:self)}}
    public var to16: Int16{get{return Int16(truncatingBitPattern:self)}}
    public var toU32: UInt32{get{return UInt32(truncatingBitPattern:self)}}
    public var to32: Int32{get{return Int32(truncatingBitPattern:self)}}
    public var toU64: UInt64{get{
        return UInt64(self) //No difference if the platform is 32 or 64
        }}
    public var to64: Int64{get{
        return Int64(self) //No difference if the platform is 32 or 64
        }}
}

extension Int32 {
    public var toU8: UInt8{ get{return UInt8(truncatingBitPattern:self)} }
    public var to8: Int8{ get{return Int8(truncatingBitPattern:self)} }
    public var toU16: UInt16{get{return UInt16(truncatingBitPattern:self)}}
    public var to16: Int16{get{return Int16(truncatingBitPattern:self)}}
    public var toU32: UInt32{get{return UInt32(self)}}
    public var to32: Int32{get{return self}}
    public var toU64: UInt64{get{
        return UInt64(self) //No difference if the platform is 32 or 64
        }}
    public var to64: Int64{get{
        return Int64(self) //No difference if the platform is 32 or 64
        }}
}

var h1 = 0xFFFF04
h1
h1.toU8   // 替代 UInt8(truncatingBitPattern:h1)

var h2:Int32 = 0x6F00FF05
h2.toU16  // 替代 UInt16(truncatingBitPattern:h2)



//字节抽取
extension UInt32 {
    public subscript(index: Int) -> UInt32 {
        get {
            precondition(index<4,"Byte set index out of range")
            
            return (self & (0xFF << (index.toU32*8))) >> (index.toU32*8)
        }
        set(newValue) {
            precondition(index<4,"Byte set index out of range")
            self = (self & ~(0xFF << (index.toU32*8))) | (newValue << (index.toU32*8))
        }
    }
}

var i32:UInt32 = 982245678                       //HEX: 3A8BE12E

print(String(i32,radix:16,uppercase:true))      // Printing the hex value

i32[3] = i32[0]
i32[1] = 0xFF
i32[0] = i32[2]

print(String(i32,radix:16,uppercase:true))      //HEX: 2E8BFF8B

/*  神奇的 XOR */

/* 你们中的部分人可能通过简单而无用的 XOR 密码对 XOR 有了一些了解。XOR 密码通过对位流 XOR 上一个 key 进行加密，然后通过再次 XOR 那个 key 来获取原始数据。为了简单起见，我们以相同长度的信息和 key 为例
 */
let secretMessage = 0b10101000111110010010101100001111000 // 0x547C95878
let secretKey =  0b10101010101010000000001111111111010    // 0x555401FFA
let result = secretMessage ^ secretKey                    // 0x12894782

let original = result ^ secretKey                         // 0x547C95878
print(String(original,radix:16,uppercase:true))           // 打印16进制值


//右移一位等价于除2,但是速度上比除法快得多
let x = 0b1011
let y = x >> 1
let z = x / 2

//一个数a和数b异或2次结果仍然是a
var a = 1
var b = 2
let c = a ^ b ^ b

//XOR 的这个性质还能够用来做其他事，最简单的例子是 XOR swap, 即不使用临时变量来交换两个整型变量的值
a = a ^ b //①临时保存两个数的异或值,并保存在a中
b = a ^ b //②展开是 b = a ^ b ^ b(a、b是原始的a、b),就是将原始的a值赋值给b
a = a ^ b //③此时的b中保存的值就是原始的a值了，而a值保存的是原始a、b的异或值 所以a = a ^ b ^ a(a、b是原始的a、b), b两次异或a结果就是原始的b值，然后赋值给a，完成了交换

let color = 0x5D45BFA0

let R = color & 0xFF
print(String(R,radix:16,uppercase:true))           // 打印16进制值

let G = (color >> 8) & 0xFF
print(String(G,radix:16,uppercase:true))           // 打印16进制值

let B = (color >> 16) & 0xFF
print(String(B,radix:16,uppercase:true))           // 打印16进制值

