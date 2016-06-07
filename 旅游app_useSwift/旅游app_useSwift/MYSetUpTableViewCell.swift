//
//  MYSetUpTableViewCell.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/25.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import UIKit
import AVFoundation


class MYSetUpTableViewCell: UITableViewCell {
    
    var _switch=UISwitch()
    lazy var _player:AVAudioPlayer = {
        let url = NSBundle.mainBundle().URLForResource("张一益 - Promise.mp3", withExtension: nil)
        var player:AVAudioPlayer?
        do{
            player = try? AVAudioPlayer(contentsOfURL: url!)
            
        }
        catch let error as NSError
        {
            
        }
       return player!
    }()
    static func setUpTableViewWithTableView(tableView:UITableView) ->MYSetUpTableViewCell
    {
        let cellID = "MYSetUpTableViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYSetUpTableViewCell
        if cell == nil
        {
            cell = MYSetUpTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(_switch)
        _switch.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.right.equalTo(self.contentView)
            make.width.equalTo(80)
        }
        _switch.addTarget(self, action: #selector(switchChange), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func switchChange(sender:UISwitch) -> Void {
        
        if sender.on == true
        {
            
            _player.play()
            
        }
        else
        {
            _player.pause()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
