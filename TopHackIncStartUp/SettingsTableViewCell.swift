//
//  SettingsTableViewCell.swift
//  TopHackIncStartUp
//
//  Created by Robert Martin on 10/3/16.
//  Copyright © 2016 Robert Martin. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //    //delete this
    //    @IBAction func LogOutBtn(_ sender: UIButton) {
    //        print( "logoutBtn called!" )
    //
    //        BackendlessManager.sharedInstance.logoutUser(
    //
    //            completion: {
    //                self.performSegue(withIdentifier: "gotoLoginFromMenu", sender: sender)
    //                //self.dismiss(animated: true, completion: nil)
    //            },
    //
    //            error: { message in
    //                print("User failed to log out: \(message)")
    //        })
    //    }

}
