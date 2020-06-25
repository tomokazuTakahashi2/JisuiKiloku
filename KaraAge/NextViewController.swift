//
//  NextViewController.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/23.
//  Copyright © 2020 takahashi. All rights reserved.
//

//import UIKit
//import RealmSwift
//
//class NextViewController: UIViewController {
//
//    @IBOutlet weak var stuffTextView: UITextView!
//    @IBOutlet weak var recipeTextView: UITextView!
//    
//
//    let realm = try! Realm()
//    var task = Task()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
//        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
//        self.view.addGestureRecognizer(tapGesture)
//
//    }
//    //Realmに保存
//    override func viewWillDisappear(_ animated: Bool) {
//        
//        try! realm.write {
//            self.task.foodstuff = self.stuffTextView.text!
//            self.task.recipe = self.recipeTextView.text!
//            realm.add(self.task)
//        }
//
//        super.viewWillDisappear(animated)
//    }
//
//    @objc func dismissKeyboard(){
//        // キーボードを閉じる
//        view.endEditing(true)
//    }
//}
