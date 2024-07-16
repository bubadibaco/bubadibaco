//
//  AvatarRecap.swift
//  bubadibaco
//
//  Created by Michael Eko on 16/07/24.
//

import SwiftUI
import AVFoundation
let synthesizer = AVSpeechSynthesizer()

struct AvatarRecap: View {
    var body: some View {
        Button("Recap") {
            let utterance = AVSpeechUtterance(string: "Hello, how are you?")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.6
            synthesizer.speak(utterance)
        }
    }
}

#Preview {
    AvatarRecap()
}
