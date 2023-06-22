//
//  SeriesTableViewCell.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 19/06/2023.
//

import UIKit
import Kingfisher

class SeriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seriesImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    
    var title : String?{
        didSet{
            self.titleLabel.text = title
        }
    }
    var rating : String?{
        didSet{
            self.ratingLabel.text = rating
        }
    }
    var year : String?{
        didSet{
            self.yearLabel.text = year
        }
    }
    var imageURL : String?{
        didSet{
            self.seriesImageView.setImage(url: imageURL ?? "", contentMode: .scaleToFill)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.setCornerRadiusWithShadow(cornerRadius: 8)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell(model:Result){
        let dataHandler = DataHandler()
        self.title = model.title
        self.rating = dataHandler.getRating(rating: model.rating?.rawValue)
        self.year = dataHandler.getYear(year:model.startYear)
        self.imageURL = dataHandler.getImageUrl(thumbnail: model.thumbnail)
    }
}
