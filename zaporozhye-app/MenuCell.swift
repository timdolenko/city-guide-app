//
//  MoreCell.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/23/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, imgPath: String) {
        titleLbl.text = title
        mainImg.image = UIImage(named: imgPath)
    }
    
}
