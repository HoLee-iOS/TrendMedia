//
//  ShoppingRealm.swift
//  TrendMedia
//
//  Created by 이현호 on 2022/08/22.
//

import UIKit

import RealmSwift

class ShoppingList: Object {
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    @Persisted var check: Bool
    @Persisted var content: String
    @Persisted var favorite: Bool
    
    convenience init(content: String) {
        self.init()
        self.check = false
        self.content = content
        self.favorite = false
    }
}
