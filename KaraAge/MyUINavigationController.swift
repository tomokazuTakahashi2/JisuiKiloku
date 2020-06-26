//
//  MyUINavigationController.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/27.
//  Copyright © 2020 takahashi. All rights reserved.
//

import UIKit

class MyUINavigationController: UINavigationController {

    // MyUINavigationController.class
    override func viewDidLoad() {
            super.viewDidLoad()
        
            //　ナビゲーションバーの背景色
            navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "唐揚げバー画像")!)
            // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
            navigationBar.tintColor = .black
            // ナビゲーションバーのテキストを変更する
            navigationBar.titleTextAttributes = [
                // 文字の色
                .foregroundColor: UIColor.black
            ]
            // Do any additional setup after loading the view.
        }

}
