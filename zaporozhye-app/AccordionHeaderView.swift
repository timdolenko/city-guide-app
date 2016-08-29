//
//  AccordionHeaderView.swift
//  FZAccordionTableViewExample
//
//  Created by Krisjanis Gaidis on 10/5/15.
//  Copyright © 2015 Fuzz. All rights reserved.
//

import UIKit

class AccordionHeaderView: FZAccordionTableViewHeaderView {
    static let kDefaultAccordionHeaderViewHeight: CGFloat = 70.0;
    static let kAccordionHeaderViewReuseIdentifier = "AccordionHeaderViewReuseIdentifier";
    
    @IBOutlet weak var taxiNameLbl: UILabel!
    @IBOutlet weak var taxiNumberLbl: UILabel!
    @IBOutlet weak var moreLbl: UILabel!
    @IBOutlet weak var moreImg: UIImageView!
    
    @IBAction func callTaxiFromHeader(_ sender: AnyObject) {
        if let phone = taxiNumberLbl.text {
            DataService.ds.call(phone: phone)
        }
    }
}
