//
//  AudioManager.swift
//  M-Player
//
//  Created by negishitakuro on 2019/06/21.
//  Copyright © 2019 negishitakuro. All rights reserved.
//

import AVFoundation

// 音楽制御クラス
class AudioManager {
    static var audioPlayer: AVAudioPlayer!
    static var index: Int = -1
    
    // 自動的に遅延初期化される(初回アクセスのタイミングでインスタンス生成)
    static let shared = AudioManager()
    // 外部からのインスタンス生成をコンパイルレベルで禁止
    private init() {}
    
    static func setAudio(audioURL: URL, audioIndex: Int) {
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            var loopNum = 0
            
            // audioPlayerを初期化する前にループ設定を引き継ぐようにする
            if (audioPlayer != nil) {
                loopNum = audioPlayer.numberOfLoops
            }
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer.numberOfLoops = loopNum
            
            // 楽曲番号を記録
            index = audioIndex
            
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
    
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
    }
    
    static func play() {
        if (audioPlayer == nil) {
            return
        }
        
        audioPlayer.play()
    }
    
    static func stop() {
        if (audioPlayer == nil) {
            return
        }
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    static func pause() {
        if (audioPlayer == nil) {
            return
        }
        
        audioPlayer.pause()
    }
    
    static func isPlaying() -> Bool {
        if (audioPlayer == nil) {
            return false
        } else {
            return audioPlayer.isPlaying
        }
    }
    
    static func getAudioIndex() -> Int {
        return index
    }
    
    // 曲のループ指定メソッド
    static func setLoop(isLoop: Bool) {
        if (audioPlayer == nil) {
            return
        }
        
        if (isLoop) {
            // -1 => 無限ループ
            audioPlayer.numberOfLoops = -1
        } else {
            // 0 => ループ無し
            audioPlayer.numberOfLoops = 0
        }
    }
}
