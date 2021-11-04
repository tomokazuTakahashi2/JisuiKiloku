//
//  HomeViewController.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/21.
//  Copyright © 2020 takahashi. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    
    // DB内のタスクが格納されるリスト。
    // 日付近い順\順でソート：降順
    // 以降内容をアップデートするとリスト内は自動的に更新される。
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)

//MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()

       //テーブルビューの２セット
         tableView.delegate = self
         tableView.dataSource = self
        
        //カスタムセル
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableView.automaticDimension
    }
//MARK: -viewWillAppear
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        print("更新しました")

    }
    // MARK: -prepare(for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let nextViewController:NextViewController = segue.destination as! NextViewController
        
        //セグエのアイデンティファーが"cellSegue" だったら
        if segue.identifier == "cellSegue" {
            //taskArray[indexPath!.row]をnextViewControllerのtaskとする
            let indexPath = self.tableView.indexPathForSelectedRow
            nextViewController.task = taskArray[indexPath!.row]
        
        }
    }

    // MARK: -UITableViewDelegateプロトコルのメソッド
    //セルの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    //セルを構築する際に呼ばれる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let task = taskArray[indexPath.row]
        //imageStringをUIImageに変換
        let imageString = task.imageString
        let image = UIImage(data: Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)!)
        
    //日付
        //task.dateのString型の日付を取得
        let time = task.date
        print(time)//614599380.761842
        //String型をDate型に変換
        guard let intervalTime = TimeInterval(time) else{return cell}
        let date = Date(timeIntervalSinceReferenceDate: intervalTime)
        print(date)//2020-06-23 10:03:00 +0000
        //日付のフォーマットを設定
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        //Date型にしたdateを"yyyy-MM-dd HH:mm"に変換
        let dateString = formatter.string(from: date)
        print(dateString)//2020-06-23 19:03
        
        
        // Cellにtaskの値を設定する.
        cell.dateLabel?.text = dateString
        cell.captionLabel?.text = task.caption
        cell.postImageView?.image = image
        
        cell.setButton(taskArray[indexPath.row])
        
        // セル内のボタンのアクションをソースコードで設定する
        cell.starButton1.addTarget(self, action:#selector(starButton1(_:forEvent:)), for: .touchUpInside)
        cell.starButton2.addTarget(self, action:#selector(starButton2(_:forEvent:)), for: .touchUpInside)
        cell.starButton3.addTarget(self, action:#selector(starButton3(_:forEvent:)), for: .touchUpInside)
        cell.starButton4.addTarget(self, action:#selector(starButton4(_:forEvent:)), for: .touchUpInside)
        cell.starButton5.addTarget(self, action:#selector(starButton5(_:forEvent:)), for: .touchUpInside)
        //シェアボタン
        cell.shareButton.addTarget(self, action:#selector(shareButtonTap(_:forEvent:)), for: .touchUpInside)

        return cell
    }
    //セルの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    // MARK: -UITableViewDelegateプロトコルのメソッド
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue",sender: nil)
    }
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }

    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //
        if editingStyle == .delete {
            // データベースから削除する
            try! realm.write {
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         return true
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }
    //MARK: - シェアボタン
    @objc func shareButtonTap(_ sender: UIButton, forEvent event: UIEvent) {
    print("DEBUG_PRINT:シェアボタンがタップされました。")
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        // 配列からタップされたインデックスのデータを取り出す
        let task = taskArray[indexPath!.row]
        
        //imageStringをUIImageに変換
        let imageString = task.imageString
        let image = UIImage(data: Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)!)
        
        // 上下反転を補正しつつ419430バイト未満にする
        let arrangedImage = image?.fixedOrientation()?.resizeImage(maxSize: 419430)
        
        //UIActivityViewController
        //あらかじめSNSにあげるデータを用意する（文字列、画像）
        let activityItems: [Any] = ["", arrangedImage as Any]

        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityVc, animated: true, completion: {

        })
    }
    //MARK: - 星ボタン
     // 星ボタン１
     @objc func starButton1(_ sender: UIButton, forEvent event: UIEvent) {
         print("DEBUG_PRINT:星ボタン１がタップされました。")

         // タップされたセルのインデックスを求める
         let touch = event.allTouches?.first
         let point = touch!.location(in: self.tableView)
         let indexPath = tableView.indexPathForRow(at: point)

         // 配列からタップされたインデックスのデータを取り出す
         let task = taskArray[indexPath!.row]
        
        //星ボタン１がタップされていたら、
         if task.tapped1 == true{
            //かつtapped2がfalseの時
            if task.tapped2 == false{
                //tapped1をfalseにする
                try! realm.write {
                    task.tapped1 = false
                }
            }else if task.tapped2 == true && task.tapped3 == true && task.tapped4 == true && task.tapped5 == true{
                //tapped1~5をfalseにする
                try! realm.write {
                    task.tapped1 = false
                    task.tapped2 = false
                    task.tapped3 = false
                    task.tapped4 = false
                    task.tapped5 = false
                }
            }else if task.tapped2 == true && task.tapped3 == true && task.tapped4 == true{
                //tapped1~4をfalseにする
                try! realm.write {
                    task.tapped1 = false
                    task.tapped2 = false
                    task.tapped3 = false
                    task.tapped4 = false
                }
            }else if task.tapped2 == true && task.tapped3 == true{
                //tapped1~3をfalseにする
                try! realm.write {
                    task.tapped1 = false
                    task.tapped2 = false
                    task.tapped3 = false
                }
            }else{
                //tapped1,2をfalseにする
                try! realm.write {
                    task.tapped1 = false
                    task.tapped2 = false
                }
            }
         //星ボタン１がタップされていなかったら、
         } else {
            //tapped１をtrueにする
            try! realm.write {
                task.tapped1 = true
            }
         }
        // TableViewを再表示する
        self.tableView.reloadData()
        print("tapped1=\(task.tapped1)")
    }
    //星ボタン２
    @objc func starButton2(_ sender: UIButton, forEvent event: UIEvent) {
         print("DEBUG_PRINT:星ボタン2がタップされました。")

         // タップされたセルのインデックスを求める
         let touch = event.allTouches?.first
         let point = touch!.location(in: self.tableView)
         let indexPath = tableView.indexPathForRow(at: point)

         // 配列からタップされたインデックスのデータを取り出す
         let task = taskArray[indexPath!.row]
        
            //星ボタン２がタップされていたら、
             if task.tapped2 == true{
                //かつtapped3がfalseだったら
                if task.tapped3 == false{
                    //tapped2をfalseにする
                    try! realm.write {
                        task.tapped2 = false
                    }
                //3~5がtrueだったら
                }else if task.tapped3 == true && task.tapped4 == true && task.tapped5 == true{
                    //tapped2~5をfalseにする
                    try! realm.write {
                        task.tapped2 = false
                        task.tapped3 = false
                        task.tapped4 = false
                        task.tapped5 = false
                    }
                //３と４がtrueだったら
                }else if task.tapped3 == true && task.tapped4 == true{
                    //tapped2~4をfalseにする
                    try! realm.write {
                        task.tapped2 = false
                        task.tapped3 = false
                        task.tapped4 = false
                    }
                
                //３がtrueだったら
                }else{
                    //tapped2とtapped3をfalseにする
                    try! realm.write {
                        task.tapped2 = false
                        task.tapped3 = false
                    }
                }
             //星ボタン２がタップされていなかったら、
             } else {
                //かつ、tapped1がtrueだったら、
                if task.tapped1 == true{
                    //tapped2をtrueにする
                    try! realm.write {
                        task.tapped2 = true
                    }
                //かつ、tapped1がfalseだったら、
                }else{
                    //tapped1とtapped2をtrueにする
                    try! realm.write {
                        task.tapped1 = true
                        task.tapped2 = true
                    }
                }
             }
        // TableViewを再表示する
        self.tableView.reloadData()
        print("tapped2=\(task.tapped2)")
        print("tapped5=\(task.tapped5)")
        
    }
    //星ボタン3
    @objc func starButton3(_ sender: UIButton, forEvent event: UIEvent) {
         print("DEBUG_PRINT:星ボタン3がタップされました。")

         // タップされたセルのインデックスを求める
         let touch = event.allTouches?.first
         let point = touch!.location(in: self.tableView)
         let indexPath = tableView.indexPathForRow(at: point)

         // 配列からタップされたインデックスのデータを取り出す
         let task = taskArray[indexPath!.row]
        
            //星ボタン3がタップされていたら、
             if task.tapped3 == true{
                //かつtapped4がfalseだったら、
                if task.tapped4 == false{
                    //tapped3をfalseにする
                    try! realm.write {
                        task.tapped3 = false
                    }
                }else if task.tapped4 == true && task.tapped5 == true{
                    try! realm.write {
                        task.tapped3 = false
                        task.tapped4 = false
                        task.tapped5 = false
                    }
                }else{
                    try! realm.write {
                        task.tapped3 = false
                        task.tapped4 = false
                    }
                }
             //星ボタン3がタップされていなかったら、
             } else {
                //かつ、tapped2がtrueだったら、
                if task.tapped2 == true{
                    //tapped3をtrueにする
                    try! realm.write {
                        task.tapped3 = true
                    }
                //あるいは、tapped1,tapped2がfalseだったら、
                }else if task.tapped1 == false && task.tapped2 == false{
                    //tapped1とtapped2とtapped3をtrueにする
                    try! realm.write {
                        task.tapped1 = true
                        task.tapped2 = true
                        task.tapped3 = true
                    }
                }else if task.tapped2 == false{
                    //tapped2とtapped3をtrueにする
                    try! realm.write {
                        task.tapped2 = true
                        task.tapped3 = true
                    }
                }
             }
        // TableViewを再表示する
        self.tableView.reloadData()
        print("tapped3=\(task.tapped3)")
    }
    //星ボタン4
    @objc func starButton4(_ sender: UIButton, forEvent event: UIEvent) {
         print("DEBUG_PRINT:星ボタン4がタップされました。")

         // タップされたセルのインデックスを求める
         let touch = event.allTouches?.first
         let point = touch!.location(in: self.tableView)
         let indexPath = tableView.indexPathForRow(at: point)

         // 配列からタップされたインデックスのデータを取り出す
         let task = taskArray[indexPath!.row]

            //星ボタン4がタップされていたら、
             if task.tapped4 == true{
                if task.tapped5 == false{
                    //tapped4をfalseにする
                    try! realm.write {
                        task.tapped4 = false
                    }
                }else{
                    //４と５をfalseにする
                    try! realm.write {
                        task.tapped4 = false
                        task.tapped5 = false
                    }
                }
             //星ボタン4がタップされていなかったら、
             } else {
                //かつ、tapped3がtrueだったら、
                if task.tapped3 == true{
                    //tapped4をtrueにする
                    try! realm.write {
                        task.tapped4 = true
                    }
                //あるいは、tapped1~tapped3がfalseだったら、
                }else if task.tapped1 == false && task.tapped2 == false && task.tapped3 == false{
    
                    //tapped1とtapped2とtapped3とtapped4をtrueにする
                    try! realm.write {
                        task.tapped1 = true
                        task.tapped2 = true
                        task.tapped3 = true
                        task.tapped4 = true
                    }
                }else if task.tapped2 == false && task.tapped3 == false{
                
                    //tapped2とtapped3とtapped4をtrueにする
                    try! realm.write {
                        task.tapped2 = true
                        task.tapped3 = true
                        task.tapped4 = true
                    }
                }else if task.tapped3 == false{
     
                    //tapped3とtapped4をtrueにする
                    try! realm.write {
                        task.tapped3 = true
                        task.tapped4 = true
                    }
                }
             }
        // TableViewを再表示する
        self.tableView.reloadData()
        print("tapped4=\(task.tapped4)")
    }
    //星ボタン5
    @objc func starButton5(_ sender: UIButton, forEvent event: UIEvent) {
         print("DEBUG_PRINT:星ボタン5がタップされました。")

         // タップされたセルのインデックスを求める
         let touch = event.allTouches?.first
         let point = touch!.location(in: self.tableView)
         let indexPath = tableView.indexPathForRow(at: point)

         // 配列からタップされたインデックスのデータを取り出す
         let task = taskArray[indexPath!.row]

            //星ボタン5がタップされていたら、
             if task.tapped5 == true{
                //tapped5をfalseにする
                try! realm.write {
                    task.tapped5 = false
                }

             //星ボタン5がタップされていなかったら、
             } else {
                //かつ、tapped4がtrueだったら、
                if task.tapped4 == true{
                    //tapped5をtrueにする
                    try! realm.write {
                        task.tapped5 = true
                    }
                //あるいは、tapped1~tapped4がfalseだったら、
                }else if task.tapped1 == false && task.tapped2 == false && task.tapped3 == false && task.tapped4 == false{
           
                    //tapped1とtapped2とtapped3とtapped4とtapped5をtrueにする
                    try! realm.write {
                        task.tapped1 = true
                        task.tapped2 = true
                        task.tapped3 = true
                        task.tapped4 = true
                        task.tapped5 = true
                    }
                }else if task.tapped2 == false && task.tapped3 == false && task.tapped4 == false{
                    //tapped2とtapped3とtapped4とtapped5をtrueにする
                    try! realm.write {
                        task.tapped2 = true
                        task.tapped3 = true
                        task.tapped4 = true
                        task.tapped5 = true
                    }
                }else if task.tapped3 == false && task.tapped4 == false{
                    //tapped3とtapped4とtapped5をtrueにする
                    try! realm.write {
                        task.tapped3 = true
                        task.tapped4 = true
                        task.tapped5 = true
                    }
                }else if task.tapped4 == false{
                    //tapped4とtapped5をtrueにする
                    try! realm.write {
                        task.tapped4 = true
                        task.tapped5 = true
                    }
                }
             }
        // TableViewを再表示する
        self.tableView.reloadData()
        print("tapped5=\(task.tapped5)")
    }
}
extension UIImage {

    /// 上下逆になった画像を反転する
    func fixedOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return newImage
    }

    /// イメージ縮小
    func resizeImage(maxSize: Int) -> UIImage? {

        guard let jpg = self.jpegData(compressionQuality: 1) as NSData? else {
            return nil
        }
        if isLessThanMaxByte(data: jpg, maxDataByte: maxSize) {
            return self
        }
        // 80%に圧縮
        let _size: CGSize = CGSize(width: (self.size.width * 0.8), height: (self.size.height * 0.8))
        UIGraphicsBeginImageContext(_size)
        self.draw(in: CGRect(x: 0, y: 0, width: _size.width, height: _size.height))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        // 再帰処理
        return newImage.resizeImage(maxSize: maxSize)
    }

    /// 最大容量チェック
    func isLessThanMaxByte(data: NSData?, maxDataByte: Int) -> Bool {

        if maxDataByte <= 0 {
            // 最大容量の指定が無い場合はOK扱い
            return true
        }
        guard let data = data else {
            fatalError("Data unwrap error")
        }
        if data.length < maxDataByte {
            // 最大容量未満：OK　※以下でも良いがバッファを取ることにした
            return true
        }
        // 最大容量以上：NG
        return false
    }
}
