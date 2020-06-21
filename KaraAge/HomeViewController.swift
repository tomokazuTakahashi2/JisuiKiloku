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
    var task: Task!

    // DB内のタスクが格納されるリスト。
    // 日付近い順\順でソート：降順
    // 以降内容をアップデートするとリスト内は自動的に更新される。
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)

    override func viewDidLoad() {
        super.viewDidLoad()

       //テーブルビューの２セット
         tableView.delegate = self
         tableView.dataSource = self
        
        //カスタムセル
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // テーブルセルのタップを無効にする
        tableView.allowsSelection = false

        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableView.automaticDimension
    }
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("DEBUG_PRINT: viewWillAppear")
//
//        if Auth.auth().currentUser != nil {
//            if self.observing == false {
//                // 要素が追加されたらpostArrayに追加してTableViewを再表示する
//                let postsRef = Database.database().reference().child(Const.PostPath)
//                postsRef.observe(.childAdded, with: { snapshot in
//                    print("DEBUG_PRINT: .childAddedイベントが発生しました。")
//
//                    // PostDataクラスを生成して受け取ったデータを設定する
//                    if let uid = Auth.auth().currentUser?.uid {
//                        let postData = PostData(snapshot: snapshot, myId: uid)
//                        self.postArray.insert(postData, at: 0)
//
//                        // TableViewを再表示する
//                        self.tableView.reloadData()
//                    }
//                })
//                // 要素が変更されたら該当のデータをpostArrayから一度削除した後に新しいデータを追加してTableViewを再表示する
//                postsRef.observe(.childChanged, with: { snapshot in
//                    print("DEBUG_PRINT: .childChangedイベントが発生しました。")
//
//                    if let uid = Auth.auth().currentUser?.uid {
//                        // PostDataクラスを生成して受け取ったデータを設定する
//                        let postData = PostData(snapshot: snapshot, myId: uid)
//
//                        // 保持している配列からidが同じものを探す
//                        var index: Int = 0
//                        for post in self.postArray {
//                            if post.id == postData.id {
//                                index = self.postArray.firstIndex(of: post)!
//                                break
//                            }
//                        }
//
//                        // 差し替えるため一度削除する
//                        self.postArray.remove(at: index)
//
//                        // 削除したところに更新済みのデータを追加する
//                        self.postArray.insert(postData, at: index)
//
//                        // TableViewを再表示する
//                        self.tableView.reloadData()
//                    }
//                })
//
//                // DatabaseのobserveEventが上記コードにより登録されたため
//                // trueとする
//                observing = true
//            }
//        } else {
//            if observing == true {
//                // ログアウトを検出したら、一旦テーブルをクリアしてオブザーバーを削除する。
//                // テーブルをクリアする
//                postArray = []
//                tableView.reloadData()
//                // オブザーバーを削除する
//                let postsRef = Database.database().reference().child(Const.PostPath)
//                postsRef.removeAllObservers()
//
//                // DatabaseのobserveEventが上記コードにより解除されたため
//                // falseとする
//                observing = false
//            }
//        }
//    }
    
    //セルの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    //セルを構築する際に呼ばれる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        //imageStringをUIImageに変換
        let imageString = task.imageString
        let image = UIImage(data: Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)!)
        
        // CellにTaskの値を設定する.
        let task = taskArray[indexPath.row]
        cell.dateLabel?.text = task.date
        cell.captionLabel?.text = task.caption
        cell.postImageView?.image = image

        return cell
    }
    //セルの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
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
}
