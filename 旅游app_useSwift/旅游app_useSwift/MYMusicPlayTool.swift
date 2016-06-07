//
//  MYMusicPlayTool.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/25.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit
import AVFoundation
class MYMusicPlayTool: NSObject {

    static var player:AVAudioPlayer?
   static  func getPlayer() -> AVAudioPlayer {
        if player == nil
        {
          player = AVAudioPlayer()
        }
        return player!
        
    }
    
}
