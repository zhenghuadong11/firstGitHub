

import Foundation
import UIKit
    
    
    class MYMyticketHaveTableViewCell:UITableViewCell  {
        
        weak var _tableViewImageView: UIImageView?
        weak var _nameLabel: UILabel?
        weak var _one_wordLabel: UILabel?
        weak var _needMoneyLabel: UILabel?
        var _isHaveEvaluationLabel:UILabel = UILabel()
        
        var _myTicketModel:MYMYticketHaveModel{
            set{
                self._collectModelTmp = newValue
            
                self.setUpSubViewWithDiffrentWithAgoModel(newValue)
            }
            get
            {
                return _collectModelTmp!
            }
            
        }
        
        var _collectModelTmp:MYMYticketHaveModel?
        
        
        func setUpSubViewWithDiffrentWithAgoModel(diffrentWithAgoModel:MYMYticketHaveModel) -> Void {
            
            
            
            _tableViewImageView?.image = UIImage(named: (diffrentWithAgoModel.picture!))
            _nameLabel?.text = diffrentWithAgoModel.name
            _one_wordLabel?.text = diffrentWithAgoModel.one_word
            _needMoneyLabel?.text = diffrentWithAgoModel.date?.description
        }
        
        
        
        static  func firstPageCellWithTableView(tableView:UITableView) -> MYMyticketHaveTableViewCell {
            
            let cellID="MYMyticketHaveTableViewCell"
            var cell:MYMyticketHaveTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? MYMyticketHaveTableViewCell
            
            if cell == nil
            {
                cell = MYMyticketHaveTableViewCell(style: UITableViewCellStyle.Default , reuseIdentifier: cellID)
                
            }
            return cell!
        }
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            let deleteLabel = UILabel()
            deleteLabel.backgroundColor = UIColor.redColor()
            deleteLabel.text = "退票"
            self.contentView.addSubview(deleteLabel)
            deleteLabel.snp_makeConstraints { (make) in
                make.left.equalTo(self.snp_right)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView).offset(1)
                make.width.equalTo(self.contentView)
            }
            
            
            
            let tableViewImageView = UIImageView()
            self.selectionStyle = UITableViewCellSelectionStyle.None
            self.addSubview(tableViewImageView)
            _tableViewImageView = tableViewImageView
            
            
            
            let nameLabel = UILabel()
            self.addSubview(nameLabel)
            _nameLabel = nameLabel
            
            
            let one_wordLabel = UILabel()
            self.addSubview(one_wordLabel)
            _one_wordLabel = one_wordLabel
            
            
            let needMoneyLabel = UILabel()
            self.addSubview(needMoneyLabel)
            _needMoneyLabel = needMoneyLabel
            
            self.addSubview(_isHaveEvaluationLabel)
            _isHaveEvaluationLabel.textColor = UIColor.grayColor()
        }
        
        
        
        
        override func layoutSubviews() {
            
            
            _tableViewImageView?.frame = CGRectMake(10, 10, self.frame.width * 0.25, self.frame.height - 20)
            
            _nameLabel?.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
                make.top.equalTo(self.snp_top).offset(10)
                make.right.equalTo(self.snp_right).offset(-10)
                make.height.equalTo(self.snp_height).multipliedBy(0.25)
            })
            
            _one_wordLabel?.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(_nameLabel!.snp_bottom).offset(10)
                make.right.equalTo(self.snp_right).offset(-10)
                make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
                make.height.equalTo(self.snp_height).multipliedBy(0.25)
                
            })
            
            _needMoneyLabel?.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(_one_wordLabel!.snp_bottom).offset(10)
                make.right.equalTo(self.snp_right).offset(-10)
                make.left.equalTo(_tableViewImageView!.snp_right).offset(10)
                make.height.equalTo(self.snp_height).multipliedBy(0.25)
                
            })
            
            _isHaveEvaluationLabel.snp_makeConstraints { (make) in
                make.top.equalTo(self).offset(10)
                make.right.equalTo(self).offset(-10)
                make.height.equalTo(30)
                make.width.equalTo(100)
            }
        }
        
        
        
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        
}
