//
//  Person.swift
//  APPSearch
//
//  Created by licong on 2017/3/21.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name = ""
    var identifer = ""
    var icon = ""
    init(_ name: String, _ identifer: String, _ icon: String) {
        self.name = name
        self.identifer = identifer
        self.icon = icon
    }
}
