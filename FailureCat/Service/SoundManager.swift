//
//  SoundManager.swift
//  FailureCat
//
//  Created by jamin on 4/23/25.
//

import AVFoundation
import UIKit

final class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    /// 현재 재생 중인 파일 이름
    private var currentSoundName: String?

    private init() {}

    func playSound(named name: String) {
        // 중복 재생 방지
        if player?.isPlaying == true && currentSoundName == name {
            return
        }

        // 확장자 자동 검색
        let supportedExtensions = ["mp3", "wav"]
        for ext in supportedExtensions {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    currentSoundName = name
                    player?.play()
                    vibrate()
                    return
                } catch {
                    print("🔊 사운드 재생 실패: \(error.localizedDescription)")
                }
            }
        }

        print("🔇 사운드 파일 없음: \(name).(mp3/wav)")
    }

    private func vibrate() {
        // 진동 (Haptic feedback)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}
