//: Playground - noun: a place where people can play

import UIKit

//http://swift.gg/2016/04/18/10-Swift-One-Liners-To-Impress-Your-Friends/

//证明字符串中含有某个单词

let words = ["Swift","iOS","cocoa","OSX","tvOS"]
let tweet = "This is an example tweet larking about Swift"

// ①
let valid = !words.filter({tweet.contains($0)}).isEmpty
// ②
tweet.characters
    .split(separator: " ")
    .lazy
    .map(String.init)
    .contains(where: Set(words).contains)


//拓展。找出指定的字符串 第一个出现的的位置
let name = "Marie Curie"
if let firstSpace = name.characters.index(of: " ") {
    let firstName = String(name.characters.prefix(upTo: firstSpace))
    print(firstName)
}

//祝你生日快乐
let name1 = "uraimo"
(1...4).forEach{print("Happy Birthday " + (($0 == 3) ? "dear \(name)":"to You"))}

//数组过滤
var part3 = [82, 58, 76, 49, 88, 90].reduce( ([],[]), {
    (a:([Int],[Int]),n:Int) -> ([Int],[Int]) in
    (n<60) ? (a.0+[n],a.1) : (a.0,a.1+[n])
})