//
//  SendChatCell.swift
//  ProgrammaticConstraintDemo
//
//  Created by MacPro3 on 09/11/21.
//

import UIKit

class SendChatCell: UITableViewCell {
    
    var vwMessage:UIView = UIView.init()
    var lblMessage:UILabel = UILabel.init()
    

    func initialSetup()  {
        contentView.backgroundColor = UIColor.clear
        
        vwMessage.backgroundColor = UIColor.lightGray
        lblMessage.backgroundColor = .clear
        lblMessage.textColor = UIColor.black
        lblMessage.font = UIFont.systemFont(ofSize: 13)
        lblMessage.numberOfLines = 0
    
        vwMessage.clipsToBounds = true
        vwMessage.layer.cornerRadius = 10.0
    }

    func settingConstraints()  {
        self.contentView.addSubview(vwMessage)
        vwMessage.addSubview(self.lblMessage)
        
        lblMessage.translatesAutoresizingMaskIntoConstraints = false
        vwMessage.translatesAutoresizingMaskIntoConstraints = false
        
        let vwConstraints =
        [
            vwMessage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            vwMessage.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: vwMessage.bottomAnchor, constant: 10),
            contentView.rightAnchor.constraint(equalTo: vwMessage.rightAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(vwConstraints)
        
        let labelConstraints =
        [
            lblMessage.topAnchor.constraint(equalTo: vwMessage.topAnchor, constant: 10),
            lblMessage.leftAnchor.constraint(equalTo: vwMessage.leftAnchor, constant: 10),
            vwMessage.bottomAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 10),
            vwMessage.rightAnchor.constraint(equalTo: lblMessage.rightAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialSetup()
        settingConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(message:String)  {
        lblMessage.text = message
    }

}
