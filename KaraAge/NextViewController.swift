//
//  NextViewController.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/23.
//  Copyright © 2020 takahashi. All rights reserved.
//

import UIKit
import RealmSwift

class NextViewController: UIViewController{

    @IBOutlet weak var stuffTextView: UITextView!
    @IBOutlet weak var recipeTextView: UITextView!
    

    let realm = try! Realm()
    var task = Task()


    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        stuffTextView.text = task.foodstuff
        recipeTextView.text = task.recipe
        
    }

    //遷移する際に、画面が非表示になるとき呼ばれるメソッド
    override func viewWillDisappear(_ animated: Bool) {
        
        guard let stuffText = self.stuffTextView.text else{return}
        guard let recipeText = self.recipeTextView.text else{return}
        
        print(stuffText)
        print(recipeText)
         //Realmに保存
        try! realm.write {
            self.task.foodstuff = stuffText
            self.task.recipe = recipeText
            realm.add(self.task)
        }

        super.viewWillDisappear(animated)
    }

    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
}
