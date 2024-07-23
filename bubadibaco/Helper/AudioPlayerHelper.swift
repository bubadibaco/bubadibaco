//  AudioPlayerHelper.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 20/07/24.
//

import SwiftUI
import AVFoundation

class AudioPlayerHelper: NSObject, AVAudioPlayerDelegate {
    private var audioPlayer: AVAudioPlayer?
    private var completion: (() -> Void)?

    func playSound(named name: String, completion: (() -> Void)? = nil) {
        guard let dataAsset = NSDataAsset(name: name) else {
            print("Could not find the sound asset for \(name).")
            return
        }
        do {
            self.completion = completion
            audioPlayer = try AVAudioPlayer(data: dataAsset.data)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file for \(name). Error: \(error.localizedDescription)")
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        completion?()
    }
}
