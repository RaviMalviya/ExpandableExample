//
//  FAQCell.swift
//  FAQExample
//
//  Created by amul on 29/12/17.
//  Copyright © 2017 amul. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {

    @IBOutlet weak var descriptionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var dataModel:FAQModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func updateConstraints() {

        if let dataModel = dataModel{
            if dataModel.isExpandable == true{
                self.descriptionViewHeightConstraint.priority = UILayoutPriority(rawValue: 740)
            }else{
                self.descriptionViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
            }
        }
        super.updateConstraints()
    }

}
