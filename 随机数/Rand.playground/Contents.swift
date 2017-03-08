//: Playground - noun: a place where people can play

import UIKit

// http://www.cocoachina.com/swift/20151013/13624.html
// http://eternallyconfuzzled.com/arts/jsw_art_rand.aspx
/*这个函数在upper_bound不是2的幂次方时，会产生一个所谓Modulo bias(模偏差)的问题 *
 因为这个时候比如说在32位机器上表示的最大数是2^32。如果upper_bound不能被这个2^32出尽，则这个时候随机数分布就不是均匀的，每个数出现的概率就不是等概率的
 */
arc4random()
arc4random() % 10

/* 
 因此可以使用arc4random_uniform，它接受一个UInt32类型的参数，指定随机数区间的上边界upper_bound，该函数生成的随机数范围是[0, upper_bound)
 */
arc4random_uniform(10)

//而如果想指定区间的最小值（如随机数区间在[5, 100)），则可以如下处理
let max: UInt32 = 100
let min: UInt32 = 5
arc4random_uniform(max - min) + min


/* 64位整型随机数 */

func arc4random1<T>(type: T.Type) -> T {
    var r: T = 0 as! T
    arc4random_buf(&r, MemoryLayout<T>.size)
    return r
}
