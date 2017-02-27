//: Playground - noun: a place where people can play

import UIKit


//Swift 烧脑体操（二） - 函数的参数

func doIt(code: () -> ()) {
    /* what we CAN */
    
    // just call it
    code()
    // pass it to another function as another `@noescape` parameter
    doItMore(code: code)
    // capture it in another `@noescape` closure
    doItMore {
        code()
    }
    
    /* what we CANNOT do *****
     
     // pass it as a non-`@noescape` parameter
     dispatch_async(dispatch_get_main_queue(), code)
     // store it
     let _code:() -> () = code
     // capture it in another non-`@noescape` closure
     let __code = { code() }
     
     */
}

func doItMore(code: () -> ()) {}

func methond(string: String) -> String {
    return string
}


func memoize<T: Hashable, U>( body: @escaping (T)->U ) -> ((T)->U) {
    var memo = Dictionary<T, U>()
    return {
        if let q = memo[$0] { return q }
        let r = body($0)
        memo[$0] = r
        return r
    }
}

let a = memoize(body: methond)
a("li cong")