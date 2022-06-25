//
//  ResultTableViewCell.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 25/06/2022.
//

import UIKit
import Kingfisher

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loginTextField: UILabel!
    @IBOutlet weak var typeTextField: UILabel!
    @IBOutlet weak var avatarUIImageView: UIImageView!
    
    var user: UserModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configCell(){
        if let avatarURL = user?.avatarURL {
            let url = URL(string: avatarURL)
            
            avatarUIImageView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .loadDiskFileSynchronously,
                    .cacheOriginalImage,
                    .transition(.fade(0.25)),
                ],
                progressBlock: { receivedSize, totalSize in
                    // Progress updated
                },
                completionHandler: { result in
                    // Done
                }
            )
            
            
        }
        
        loginTextField.text = user?.login
        typeTextField.text = user?.type.rawValue
        
    }
    
}
