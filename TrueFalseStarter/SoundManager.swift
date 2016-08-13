//
//  SoundManager.swift
//  TrueFalseStarter
//
//  Created by Nathan Fulkerson on 8/10/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundManager {
    static let sharedInstance = SoundManager()
    
    private var gameSound: SystemSoundID = 0
    private var successSound: SystemSoundID = 1
    private var failureSound: SystemSoundID = 2
    
    func loadSounds() {
        loadGameStartSound()
        loadFailureSound()
        loadSuccessSound()
    }
    // lots of repetition here. There's gotta be a better way,
    // but first we need to know how to get arround the immutable parameters.
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func loadSuccessSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("success", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &successSound)
    }
    
    func loadFailureSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("failure", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &failureSound)
    }
    
    func playGameSound(sound: Sound) {
        AudioServicesPlaySystemSound(sound.rawValue)
    }
}

enum Sound : SystemSoundID {
    case Start = 0
    case Success = 1
    case Failure = 2
}