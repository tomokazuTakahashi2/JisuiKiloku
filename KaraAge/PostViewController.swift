//
//  PostViewController.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/21.
//  Copyright © 2020 takahashi. All rights reserved.
//

import UIKit
import RealmSwift 
import SVProgressHUD

class PostViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var image: UIImage!
    let realm = try! Realm()
    var task = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        self.textField.delegate = self

    // 受け取った画像をImageViewに設定する
        imageView.image = image
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        captionLabel.text = textField.text
        return true
    }
    
    @IBAction func postButton(_ sender: Any) {
        //キャプションを設定
        let caption = self.captionLabel.text!
        // ImageViewから画像を取得する
        let imageData = imageView.image!.jpegData(compressionQuality: 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)

        // 時間を設定
        let time = Date.timeIntervalSinceReferenceDate
        
        
        if self.textField.text != "" {

            //Realmに保存
            try! realm.write {
                let allTasks = realm.objects(Task.self)
                if allTasks.count != 0 {
                    task.id = allTasks.max(ofProperty: "id")! + 1
                }
                print(task)
                self.task.caption = caption
                self.task.imageString = imageString
                self.task.date = String(time)
                realm.add(self.task)
            }
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")

            // 全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        }else{
             SVProgressHUD.showSuccess(withStatus: "キャプションを入力してください！")
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    

}
