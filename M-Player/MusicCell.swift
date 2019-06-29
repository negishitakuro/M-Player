//
//  MusicCell.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/12.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit
import RealmSwift

// タップイベント通知用プロトコルを記述
@objc protocol AudioControlDelegate {
    // デリゲートメソッド定義
    func didTappedItemStartPause(index: Int)
}

class MusicCell: UITableViewCell {

    @IBOutlet weak var favImgBtn: UIImageView!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var pauseImgBtn: UIImageView!
    var index: Int = 0
    // AudioControlDelegateのインスタンスを宣言
    weak var delegate: AudioControlDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // セルに曲情報をセット
    func initCellData(itemIndex: Int, image: UIImage, title: String, artistName: String, albumName: String, isFav: Bool) {
        index = itemIndex
        musicImage.image = image
        titleLabel.text = title
        artistLabel.text = artistName
        albumLabel.text = albumName
        pauseImgBtn.image = UIImage(named: "playBtn")
        
        //
        if (isFav) {
            favImgBtn.image = UIImage(named: "favOn")
        } else {
            favImgBtn.image = UIImage(named: "favOff")
        }
        
        favImgBtn.isUserInteractionEnabled = true
        favImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MusicCell.favTapped(_:))))
        
        // 再生/一時停止ボタンにタップイベント登録
        pauseImgBtn.isUserInteractionEnabled = true
        pauseImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MusicCell.pauseTapped(_:))))
    }
    
    @objc func pauseTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTappedItemStartPause(index: index)
    }

    @objc func favTapped(_ sender: UITapGestureRecognizer) {
        let realm = try! Realm()
        
        let results:Results<MusicEntity> = realm.objects(MusicEntity.self).filter("title == %@", titleLabel.text ?? "!!")
        
        if (results.count > 0) {
            let retVal: MusicEntity = results.first!
            try! realm.write {
                retVal.isFavorite = !retVal.isFavorite
            }
            
            if (retVal.isFavorite) {
                favImgBtn.image = UIImage(named: "favOn")
            } else {
                favImgBtn.image = UIImage(named: "favOff")
            }
        }
    }
}
