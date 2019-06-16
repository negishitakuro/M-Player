//
//  MusicData.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/16.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//　楽曲データクラス
class MusicData {
    var title: String = ""      // 楽曲タイトル
    var artist: String = ""     // アーティスト名
    var albumName: String = ""  // アルバム名
    var image: UIImage!   // 楽曲画像
    var audioURL: URL           // 楽曲のURL
    
    init(musicFileURL: URL){
        audioURL = musicFileURL
        let playerItem = AVPlayerItem(url: musicFileURL)
        let metadataList = playerItem.asset.metadata
        
        for item in metadataList {
            
            guard let key = item.commonKey?.rawValue, let value = item.value else{
                continue
            }
            
            print(key)
            switch key {
            case "title" : title = value as! String
            case "artist": artist = value as! String
            case "albumName": albumName = value as! String
            case "artwork" where value is Data : image = UIImage(data: value as! Data)!
            default:
                continue
            }
        }
    }
}
