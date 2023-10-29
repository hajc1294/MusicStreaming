//
//  PlayerViewModel.swift
//  MusicStreaming
//
//  Created by Jean Carlo Hernández Arguedas on 28/10/23.
//

import Foundation
import FirebaseStorage
import AVFoundation
import RxSwift
import RxCocoa

class PlayerViewModel {
    
    lazy var viewModelStatus = BehaviorRelay<ViewModelStatus>(value: ViewModelStatus.loading)
    lazy var isPlaying = BehaviorRelay<Bool>(value: true)
    var player = AVPlayer()
    var playList: [Song]
    var currentSong: Int
    
    init(playList: [Song], currentSong: Int) {
        self.playList = playList
        self.currentSong = currentSong
        getSongFromServer()
    }
    
    func getCurrentSong() -> Song {
        return playList[currentSong]
    }
    
    func getSongFromServer() {
        let storageRef = Storage.storage().reference(forURL: playList[currentSong].resource)
        storageRef.downloadURL { [weak self] (data, error) in if let strongSelf = self {
                if let data = data {
                    strongSelf.player = AVPlayer(playerItem: AVPlayerItem(url: data))
                    strongSelf.player.play()
                    strongSelf.isPlaying.accept(true)
                    strongSelf.viewModelStatus.accept(ViewModelStatus.success)
                } else {
                    print(error ?? "error")
                    print("Error: Song could not download!")
                }
            }
        }
    }
    
    func getSongDuration() -> Float {
        if let duration = player.currentItem?.asset.duration {
            return Float(duration.seconds)
        } else {
            return 0
        }
    }
    
    func getSongCurrentTime() -> Float {
        let current = player.currentTime().seconds
        return current.isNaN ? 0 : Float(current)
    }
    
    func updateSongCurrentTime(position: Float) {
        let seekTime = CMTime(value: Int64(position), timescale: 1)
        player.seek(to: seekTime)

    }
    
    func playSong() {
        player.play()
        isPlaying.accept(true)
    }
    
    func stopSong() {
        player.pause()
        isPlaying.accept(false)
    }
    
    func playNextSong() {
        viewModelStatus.accept(ViewModelStatus.loading)
        player.replaceCurrentItem(with: nil)
        if currentSong == playList.count - 1 {
            currentSong = 0
        } else {
            currentSong += 1
        }
        getSongFromServer()
    }
    
    func playPrevSong() {
        viewModelStatus.accept(ViewModelStatus.loading)
        player.replaceCurrentItem(with: nil)
        if currentSong == 0 {
            currentSong = playList.count - 1
        } else {
            currentSong -= 1
        }
        getSongFromServer()
    }
    
    func disposePlayer() {
        player.replaceCurrentItem(with: nil)
    }
}
