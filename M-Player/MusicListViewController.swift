//
//  MusicListViewController.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/12.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit
import AVFoundation

protocol MusicListViewDelegate {
    // 各セルの再生/停止ボタン押下時のデリゲートメソッド定義
    func didTapCellStartPauseBtn(musicData: MusicData)
}

// 楽曲リスト選択画面
class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
AudioControlDelegate, AudioControlViewDelegate {
    
    var delegate: MusicListViewDelegate?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // ViewController の delegate に self を設定
        switch (segue.identifier, segue.destination) {
        case ("EmbedSegue"?, let destination as AudioControlViewController):
            destination.delegate = self
            delegate = destination
        default:
            ()
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
        cell.initCellData(itemIndex: indexPath.row, image: musicData.image!, title: musicData.title, artistName: musicData.artist, albumName: musicData.albumName)
        // delegateのセット(= delegateの委譲先インスタンスとして自分自身をと登録)
        cell.delegate = self
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
    
    /*** AudioControlDelegateMethod ***/
    
    // MusicCellの一時停止ボタンがタップされた時
    func didTappedItemStartPause(index: Int) {
        // 前回再生した曲 or 再生中の曲と違う曲の場合,現在の曲を停止,曲を切り替えて再生
        if (AudioManager.getAudioIndex() != index) {
            AudioManager.stop()
            AudioManager.setAudio(musicData: listItems[index], audioIndex: index)
            AudioManager.play()
        } else {
            // 前回再生した曲と同じ曲の場合,停止していれば再生
            if (AudioManager.isPlaying()) {
                AudioManager.pause()
            } else {
                AudioManager.play()
            }
        }
        // 各セルの再生/一時停止ボタンがタップされた時に,画面下部のビューに通知
        delegate?.didTapCellStartPauseBtn(musicData: listItems[index])
    }
 
    // 画面下部の再生/一時停止ボタンがタップされた時
    func didTapStartPauseBtn() {
        
        // 再生中なら一時停止,一時停止中なら再生
        if (AudioManager.isPlaying()) {
            AudioManager.pause()
        } else {
            AudioManager.play()
        }
    }
    
}

