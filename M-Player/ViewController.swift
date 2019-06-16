//
//  ViewController.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/01.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    var musicData: MusicData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        trackTitleLabel.text = musicData.title
        artistNameLabel.text = musicData.artist
        musicImageView.image = musicData.image
        
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicData.audioURL)
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if ( audioPlayer.isPlaying ){
            audioPlayer.stop()
            button.setTitle("Play", for: UIControl.State())
        }
        else{
            audioPlayer.play()
            button.setTitle("Stop", for: UIControl.State())
        }
    }
}

