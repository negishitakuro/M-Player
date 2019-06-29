//
//  MusicEntity.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/23.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import Foundation
import RealmSwift

class MusicEntity: Object {
    @objc dynamic var title = ""
    @objc dynamic var isFavorite = false
    
    // プライマリキーに設定
    override static func primaryKey() -> String? {
        return "title"
    }
}
