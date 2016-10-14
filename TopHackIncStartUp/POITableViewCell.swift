//
//  POITableViewCell.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/13/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class POITableViewCell: UITableViewCell {

    @IBOutlet weak var fNameLabel: UITextField!
    
    @IBOutlet weak var compLabel: UITextField!
    
    @IBOutlet weak var jobLabel: UITextField!
    
    @IBOutlet weak var networkLabel: UITextField!
 
    
    @IBOutlet weak var goodInfoLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var linkedImage: UIImageView!
    
    @IBOutlet weak var twitterImage: UIImageView!
    
    @IBOutlet weak var facebookImage: UIImageView!
    
    @IBOutlet weak var instagramImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func bluetoothSyncButton(_ sender: UIButton) {
    }
    
    
}
