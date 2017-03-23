//: Playground - noun: a place where people can play

import UIKit

enum DAOError: Error {
    case NoData
}

struct Note {
    var a = 1
}

let listData = [Note]()

func findAll() throws -> [Note] {
    
    guard listData.count > 0 else {
        
        //抛出"没有数据"错误。
        
        throw DAOError.NoData
    }
    return listData 
}

let datas  = try? findAll()
print(datas ?? "qa")




func findAll1() throws -> [Note] {
    guard listData.count > 0 else {
        //抛出"没有数据"错误。
        
        throw DAOError.NoData
    }
    return listData
}



func printNotes() {
    
    let datas  = try! findAll1()
    for note in datas {
        print("\(note.a)")
    }
    
}  

printNotes()