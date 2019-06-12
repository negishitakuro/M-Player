//
//  ViewController.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/01.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit
//import AVFoundation
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    //MediaPlayerのインスタンスを作成
    var player:MPMusicPlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        player = MPMusicPlayerController.applicationMusicPlayer
        
//        let documentDirPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print(documentDirPath)
        
//        let albumsQuery = MPMediaQuery.albums()
//        let albums = albumsQuery.collections as! [MPMediaItemCollection]
//
//        for album in albums {
//            let title = album.representativeItem.albumTitle ?? ""  // アルバム名
//            let artist = album.representativeItem.albumArtist ?? ""  // アーティスト名
//        }
        
    }
    
    // メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        // 選択した曲情報がmediaItemCollectionに入っているので、これをplayerにセット。
        player.setQueue(with: mediaItemCollection)
        // 再生開始
        player.play()
        // ピッカーを閉じ、破棄する
        dismiss(animated: true, completion: nil)
    }
    
    //選択がキャンセルされた場合に呼ばれる
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        // ピッカーを閉じ、破棄する
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pick(_ sender: Any) {
        // MPMediaPickerControllerのインスタンスを作成
        let picker = MPMediaPickerController()
        // ピッカーのデリゲートを設定
        picker.delegate = self
        // 複数選択を不可にする。（trueにすると、複数選択できる）
        picker.allowsPickingMultipleItems = false
        // ピッカーを表示する
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func pushPlay(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pushPause(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func pushStop(_ sender: Any) {
        player.stop()
    }
}

