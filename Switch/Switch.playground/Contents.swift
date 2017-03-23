//: Playground - noun: a place where people can play

import UIKit
//http://swift.gg/2017/03/17/enums-equatable-exhaustiveness/?utm_source=tuicool&utm_medium=referral
enum Expression {
    case number(Double)
    case string(String)
    case bool(Bool)
}

//extension Expression: Equatable {
//    static func ==(lhs: Expression, rhs: Expression)
//        -> Bool {
//            switch (lhs, rhs) {
//            case let (.number(l), .number(r)): return l == r
//            case let (.string(l), .string(r)): return l == r
//            case let (.bool(l), .bool(r)): return l == r
//            case (.number, .string),
//                 (.number, .bool),
//                 (.string, .number),
//                 (.string, .bool),
//                 (.bool, .number),
//                 (.bool, .string): return false
//            }
//    }
//}

extension Expression: Equatable {
    static func ==(lhs: Expression, rhs: Expression)
        -> Bool {
            switch (lhs, rhs) {
            case let (.number(l), .number(r)): return l == r
            case let (.string(l), .string(r)): return l == r
            case let (.bool(l), .bool(r)): return l == r
            case (.number, _),
                 (.string, _),
                 (.bool, _): return false
            }
    }
}