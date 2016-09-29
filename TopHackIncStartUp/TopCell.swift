//
//  TopCell.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 9/4/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import Foundation
import UIKit

class TopCell: UITableViewCell {
    
    var websiteUrl: String?
    
    @IBOutlet weak var IncAccHackPic: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var progType: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var rankingLabel: UILabel!
    
    @IBAction func websiteLink(_ sender: UIButton) {
        
        // Since MyTableViewCell can safely call openURL() - we'll just do it here.
        if let url = URL(string: websiteUrl!) {
            UIApplication.shared.openURL(url)
        }

        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

    
    
}
