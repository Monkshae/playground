//: Playground - noun: a place where people can play

import UIKit

//http://www.hangge.com/blog/cache/detail_1377.html#

//普通的循环方式打印1到100范围内所有2的n次方数
var i = 1
repeat {
//    print(i)
    i *= 2
} while i <= 100

//利用swift3的sequence
for i in sequence(first: 1, next: { (a: Int) -> Int? in
    return 2 * a
}) {
    if i > 100  { break }
}

//简化版本
for i in sequence(first: 1, next: { return $0 * 2 }) {
    if  i > 100 { break }
//    print(i)
}


//我们还可以将所有的处理逻辑、状态判断都放在next闭包里
for i in sequence(first: 1, next: {
//    print($0)
    let value = $0 * 2
    return value <= 100 ? value : nil
}){}


//Sequence和Iterator
/* Swift 语言中提供了一种 for .. in 语法的形式，用于遍历集合，比如对于 Array 类型，就可以用 for .. in 来进行遍历。这个语法在很多其他语言中也有提供，省去了我们定义下标的操作。今天我们要了解的就是关于 for .. in 语法的原理，我们可以让我们自己的类也支持这个语法。
   其实关键就在于这个 SequenceType，一个类如果实现了 SequenceType 协议，那么他就可以使用 for ... in 语法进行遍历了。包括我们自己的定义的类。
    http://www.cnblogs.com/theswiftworld/p/swift-sequence.html
*/

class Book {
    var name:String = ""
    var price:Float = 0.0
    init(name: String, price: Float) {
        self.name = name
        self.price = price
    }
}

class BookListIterator : IteratorProtocol {
    
    typealias Element = Book
    var currentIndex:Int = 0
    var bookList:[Book]?
    init(bookList: [Book]) {
        self.bookList = bookList
    }
    
    func next() -> Element? {
        guard let list = bookList else { return  nil }
        if currentIndex < list.count {
            let element = list[currentIndex]
            currentIndex += 1
            return element
        }else {
            return nil
        }
    }
}

class BookList: Sequence {
    
    typealias Iterator = BookListIterator
    private var bookList:[Book]?
    
    init() {
        self.bookList = [Book]()
    }
    
    func addBook(book:Book){
        self.bookList?.append(book)
    }
    
    func makeIterator() -> Iterator {
        return BookListIterator(bookList:self.bookList!)
    }
}

let bookList = BookList()

bookList.addBook(book: Book(name: "Swift", price: 12.5))
bookList.addBook(book: Book(name: "iOS" , price: 10.5))
bookList.addBook(book: Book(name: "Objc", price: 20.0))


for book in bookList {
    print("\(book.name) 价格 ￥\(book.price)")
}

 let numbers = [1, 2, 3, 4]
 let flatMap = numbers.flatMap { $0 * 2}

 let map = numbers.map { $0 * 2}
map
flatMap