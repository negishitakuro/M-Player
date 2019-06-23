//
//  AudioControlViewController.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/21.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit
import AVFoundation

// AudioControlViewDelegate プロトコルを記述
@objc protocol AudioControlViewDelegate {
    // 画面下部の再生/停止ボタン押下時のデリゲートメソッド定義
    func didTapStartPauseBtn()
}

class AudioControlViewController: UIViewController, MusicListViewDelegate {
    
    // 楽曲名
    @IBOutlet weak var titleLabel: UILabel!
    // アーティスト名
    @IBOutlet weak var artistLabel: UILabel!
    // 楽曲イメージ
    @IBOutlet weak var musicImageView: UIImageView!
    // 楽曲の経過時間
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    // 楽曲の合計時間
    @IBOutlet weak var musicTimeLabel: UILabel!
    // 再生/一時停止ボタン
    @IBOutlet weak var startPauseImgBtn: UIImageView!

    weak var delegate: AudioControlViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 再生&一時停止ボタンにタップイベント登録
        startPauseImgBtn.isUserInteractionEnabled = true
        startPauseImgBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AudioControlViewController.tappedStartPauseBtn(_:))))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 再生/一時停止ボタンの画像セット
        if (AudioManager.isPlaying()) {
            startPauseImgBtn.image = UIImage(named: "pauseBtn")
        } else {
            startPauseImgBtn.image = UIImage(named: "playBtn")
        }
        
        // 前回再生した楽曲情報を初期表示
        if let musicData: MusicData = AudioManager.getMusicData() {
            musicImageView.image = musicData.image
            titleLabel.text = musicData.title
            artistLabel.text = musicData.artist
        } else {
            startPauseImgBtn.image = UIImage(named: "pauseBtn")
        }
    }
    
    @objc func tappedStartPauseBtn(_ sender: UITapGestureRecognizer) {
        if (AudioManager.isPlaying()) {
            startPauseImgBtn.image = UIImage(named: "playBtn")
        } else {
            startPauseImgBtn.image = UIImage(named: "pauseBtn")
        }
        
        delegate?.didTapStartPauseBtn()
    }
    
    // 楽曲リストの再生/一時停止ボタンをタップした時に呼ばれるメソッド
    func didTapCellStartPauseBtn(musicData: MusicData) {
        if (AudioManager.isPlaying()) {
            startPauseImgBtn.image = UIImage(named: "pauseBtn")
        } else {
            startPauseImgBtn.image = UIImage(named: "playBtn")
        }
        
        musicImageView.image = musicData.image
        titleLabel.text = musicData.title
        artistLabel.text = musicData.artist
    }
    
}

