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
    func didTappedStart(index: Int)
    func didTappedStop(index: Int)
    func didTappedPause(index: Int)
}

class MusicCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var startImgBtn: UIImageView!
    @IBOutlet weak var stopImgBtn: UIImageView!
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
        startImgBtn.image = UIImage(named: "playBtn")
        stopImgBtn.image = UIImage(named: "stopBtn")
        pauseImgBtn.image = UIImage(named: "pauseBtn")
        
        // 再生,停止,一時停止ボタンにタップイベント登録
        startImgBtn.isUserInteractionEnabled = true
        startImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MusicCell.startTapped(_:))))
        
        stopImgBtn.isUserInteractionEnabled = true
        stopImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MusicCell.stopTapped(_:))))
        
        pauseImgBtn.isUserInteractionEnabled = true
        pauseImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MusicCell.pauseTapped(_:))))
    }
    
    @objc func startTapped(_ sender: UITapGestureRecognizer) {
        // デリゲートメソッドを呼ぶ(処理をデリゲートインスタンスに委譲する)
        delegate?.didTappedStart(index: index)
    }
    
    @objc func stopTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTappedStop(index: index)
    }
    
    @objc func pauseTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTappedPause(index: index)
    }
}
