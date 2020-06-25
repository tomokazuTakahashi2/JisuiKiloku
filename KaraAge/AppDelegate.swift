//
//  AppDelegate.swift
//  KaraAge
//
//  Created by Raphael on 2020/06/20.
//  Copyright © 2020 takahashi. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    //Realmのマイグレーション
        let config = Realm.Configuration(
              // 新しいスキーマバージョンを設定します。 これは以前に使用されたものよりも大きくなければなりません
              // version（以前にスキーマバージョンを設定していない場合、バージョンは0です）。
              schemaVersion: 9,

              //スキーマのバージョンが上記のものよりも低い/を開くときに自動的に呼び出されるブロックを設定する
                 migrationBlock: { migration, oldSchemaVersion in
        //まだ何も移行していないので、oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Realmは新しいプロパティと削除されたプロパティを自動的に検出します
            //そして自動的にディスク上のスキーマを更新する
        }})

            // Tell Realm to use this new configuration object for the default Realm
            Realm.Configuration.defaultConfiguration = config

            //デフォルトのレルムに対してこの新しい設定オブジェクトを使用するようにRealmに指示します
            let realm = try! Realm()
            print(realm, "Realm")
            print(config,"Realm Version")
            return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

