//
//  MusicCell.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/12.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit

// タップイベント通知用プロトコルを記述
@objc protocol AudioControlDelegate {
    // デリゲートメソッド定義
    func didTappedItemStartPause(index: Int)
}

class MusicCell: UITableViewCell {

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
    func initCellData(itemIndex: Int, image: UIImage, title: String, artistName: String, albumName: String) {
        index = itemIndex
        musicImage.image = image
        titleLabel.text = title
        artistLabel.text = artistName
        albumLabel.text = albumName
        pauseImgBtn.image = UIImage(named: "playBtn")
        
        // 再生/一時停止ボタンにタップイベント登録
        pauseImgBtn.isUserInteractionEnabled = true
        pauseImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MusicCell.pauseTapped(_:))))
    }
    
    @objc func pauseTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTappedItemStartPause(index: index)
    }
}
