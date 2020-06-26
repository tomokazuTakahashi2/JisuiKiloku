//
//  ActivityItemsorce.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/26.
//  Copyright © 2020 takahashi. All rights reserved.
//
import Foundation
import UIKit
protocol UIActivityItemSource{}

class ActivityItemSorce:NSObject, UIActivityItemSource {
    var messsage: String!
    var image: UIImage!

    init(messsage: String, image: UIImage) {
        self.messsage = messsage
        self.image = image
    }

    // デフォルトのアイテム
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return messsage
    }

    // アプリ選択時に呼ばれる
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType) -> Any? {

        switch activityType {
        case .postToFacebook:
            return image
        case .postToTwitter:
            return "Twitter"
        default:
            return messsage
        }
    }
}
