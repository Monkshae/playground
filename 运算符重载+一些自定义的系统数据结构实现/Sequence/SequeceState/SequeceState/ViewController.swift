//
//  ViewController.swift
//  SequeceState
//
//  Created by licong on 2017/3/6.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

//http://www.hangge.com/blog/cache/detail_1377.html# 的第二部分

//通过指定最大的x轴，y轴坐标值，列出其内部所有的整点

class ViewController: UIViewController {

    //命名一个坐标点类型
    typealias PointType = (x: Int, y: Int)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //遍历序列并打印出所有坐标
        for point in cartesianSequence(xCount: 5, yCount: 3) {
            print("(x: \(point.x), y: \(point.y))")
        }
        
        createBookShelf()
    }
    
    //返回所有符合条件的坐标点序列
    func cartesianSequence(xCount: Int, yCount: Int) -> UnfoldSequence<PointType, Int> {
        assert(xCount > 0  && yCount > 0,
               "必须使用正整数创建序列。")
        return sequence(state: 0, next: {
            (index: inout Int) -> PointType? in
            guard index < xCount * yCount else { return nil }
            defer { index += 1 }
            return (x: index % xCount, y: index / xCount)
        })
    }
    
    
    func createBookShelf() {
        //中文书架
        let bookShelf1 = BookShelf()
        bookShelf1.append(book: Book(name: "平凡的世界"))
        bookShelf1.append(book: Book(name: "活着"))
        bookShelf1.append(book: Book(name: "围城"))
        bookShelf1.append(book: Book(name: "三国演义"))
        
        //外文书架
        let bookShelf2 = BookShelf()
        bookShelf2.append(book: Book(name: "The Kite Runner"))
        bookShelf2.append(book: Book(name: "Cien anos de soledad"))
        bookShelf2.append(book: Book(name: "Harry Potter"))
        
        //创建两个书架图书的交替序列
        for book in sequence(state: (false, bookShelf1.makeIterator(), bookShelf2.makeIterator()),
                             next: { (state:inout (Bool,AnyIterator<Book>,AnyIterator<Book>)) -> Book? in
                                state.0 = !state.0
                                return state.0 ? state.1.next() : state.2.next()
        }) {
            print(book.name)
        }
    }
}



// 图书
struct Book {
    var name: String
}

// 书架
class BookShelf {
    //图书集合
    private var books: [Book] = []
    
    //添加新书
    func append(book: Book) {
        self.books.append(book)
    }
    
    //创建Iterator
    func makeIterator() -> AnyIterator<Book> {
        var index : Int = 0
        return AnyIterator<Book> {
            defer {
                index = index + 1
            }
            return index < self.books.count ? self.books[index] : nil
        }
    }
}


