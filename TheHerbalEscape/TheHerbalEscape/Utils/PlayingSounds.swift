//
//  PlayingSounds.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 14/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation
// Something found on https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
/*import AVFoundation
 
 var player: AVAudioPlayer?
 
 func playSound() {
 guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }
 
 do {
 try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
 try AVAudioSession.sharedInstance().setActive(true)
 
 
 
 /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
 player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
 
 /* iOS 10 and earlier require the following line:
 player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
 
 guard let player = player else { return }
 
 player.play()
 
 } catch let error {
 print(error.localizedDescription)
 }
 }
*/
