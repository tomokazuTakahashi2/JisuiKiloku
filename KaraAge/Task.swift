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

        /// 日時
        @objc dynamic var date = ""

        /**
         id をプライマリーキーとして設定
         */
        override static func primaryKey() -> String? {
            return "id"
        }
    }
