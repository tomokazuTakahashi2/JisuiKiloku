//
//  Task.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/22.
//  Copyright © 2020 takahashi. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
        @objc dynamic var id = 0

        // キャプション
        @objc dynamic var caption = ""

        // 画像
        @objc dynamic var imageString = ""

        // 日時
        @objc dynamic var date = ""
    
//        //材料
//        @objc dynamic var foodstuff = ""
//        //作り方
//        @objc dynamic var recipe = ""
        
        //タップ済み
        @objc dynamic var tapped1 = false
        @objc dynamic var tapped2 = false
        @objc dynamic var tapped3 = false
        @objc dynamic var tapped4 = false
        @objc dynamic var tapped5 = false

        let taps = List<StarBottun>()

        /**
         id をプライマリーキーとして設定
         */
        override static func primaryKey() -> String? {
            return "id"
        }
    }
class StarBottun: Object {
    @objc dynamic var taps: Int = 0
}
