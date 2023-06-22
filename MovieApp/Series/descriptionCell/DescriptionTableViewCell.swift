//
//  DescriptionTableViewCell.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 22/06/2023.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
 
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(name:String){
        if !name.isEmpty{
            self.descLabel.text = name
        }
    }

}
