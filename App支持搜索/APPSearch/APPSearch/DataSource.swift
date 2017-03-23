//
//  DataSource.swift
//  APPSearch
//
//  Created by licong on 2017/3/21.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import CoreSpotlight

class DataSource: NSObject {
    var dataList: [Person] {
        let becky = Person("becky", "1", "becky")
        let ben = Person("ben", "2", "ben")
        let jane = Person("jane", "3", "jane")
        return[becky,ben,jane]
    }
    
    func findFriend(identifer: String) -> Person? {
        let person = dataList.filter { $0.identifer == identifer }
        return person.first
    }
    
    func savePeople() {
        var searchableItems = [CSSearchableItem]()
        //prepare
        for p in dataList {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: "image")
            attributeSet.title = p.name
            attributeSet.contentDescription = "This is an entry all about the interesting person called" + p.name
            attributeSet.thumbnailData = UIImagePNGRepresentation(UIImage(named: p.icon)!)
            let item = CSSearchableItem(uniqueIdentifier: p.identifer, domainIdentifier: "com.iosdaybyday", attributeSet: attributeSet)
            searchableItems.append(item)
            
        }
        //save
        CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) in
            print(error.debugDescription)
        }
        
    }
    
    
}
