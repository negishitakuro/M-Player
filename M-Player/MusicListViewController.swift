//
//  MusicListViewController.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/12.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit
import AVFoundation

// 楽曲リスト選択画面
class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var musicListTableView: UITableView!
    //　楽曲リスト
    var listItems:[MusicData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テーブルビューの各セルにカスタムセルクラスを設定
        musicListTableView.register (UINib(nibName: "MusicCell", bundle: nil),forCellReuseIdentifier:"MusicCell")
        
        // iPhone端末の「Document」以下のファイルを全てURLで取得
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let contentUrls = try FileManager.default.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil)
            //　URLから楽曲リスト作成
            listItems = contentUrls.map{MusicData(musicFileURL: $0.absoluteURL)}
        } catch {
            print(error)
        }
        
    }
    
    // セルの個数を指定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    // セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        // セルに表示する値を設定する
        let musicData = listItems[indexPath.row]
        cell.setCellData(image: musicData.image!, title: musicData.title, artistName: musicData.artist, albumName: musicData.albumName)
        return cell
    }
    
    // リストの各セルをタップした時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 遷移処理
        let next = storyboard!.instantiateViewController(withIdentifier: "nextView") as? ViewController
        let _ = next?.view // ** hack code **
        next?.musicData = listItems[indexPath.row]
        self.present(next!,animated: true, completion: nil)
    }
}

