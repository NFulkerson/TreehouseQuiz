//
//  SoundManager.swift
//  TrueFalseStarter
//
//  Created by Nathan Fulkerson on 8/10/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import Foundation
import AudioToolbox

struct Sound {
    var soundID: SystemSoundID
    var name: String
    
    mutating func prepareSound() -> SystemSoundID {
        
        let pathToSoundFile = NSBundle.mainBundle().pathForResource(self.name, ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        return soundID
    }
    
    func play() {
        AudioServicesPlaySystemSound(soundID)
    }
}