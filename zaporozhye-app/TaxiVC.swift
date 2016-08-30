//
//  TaxiVC.swift
//  FZAccordionTableViewExample
//
//  Created by Krisjanis Gaidis on 10/5/15.
//  Copyright © 2015 Fuzz. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class TaxiVC: UIViewController {
    static let kTableViewCellReuseIdentifier = "TaxiCell"
    @IBOutlet private weak var tableView: FZAccordionTableView!
    
    var taxiArray = [Taxi]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DataService.ds.taxiArray.count > 0 {
            taxiArray = DataService.ds.taxiArray
        } else {
            //Place to start animation
            NotificationCenter.default.addObserver(self, selector: #selector(TaxiVC.updateUI), name: Notification.Name("dataLoaded"), object: nil)
        }
        
        tableView.allowMultipleSectionsOpen = true
        tableView.register(UINib(nibName: "TaxiCell",bundle: nil), forCellReuseIdentifier: TaxiVC.kTableViewCellReuseIdentifier)
        tableView.register(UINib(nibName: "AccordionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: AccordionHeaderView.kAccordionHeaderViewReuseIdentifier)
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        //stop animation
        taxiArray = DataService.ds.taxiArray
        tableView.reloadData()
    }
}


// MARK: - <UITableViewDataSource> / <UITableViewDelegate> -

extension TaxiVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phone = taxiArray[indexPath.section].phones[indexPath.row + 1]
        
        DataService.ds.call(phone: phone)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxiArray[section].phones.count - 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return taxiArray.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AccordionHeaderView.kDefaultAccordionHeaderViewHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return self.tableView(tableView, heightForHeaderInSection:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TaxiVC.kTableViewCellReuseIdentifier, for: indexPath) as? TaxiCell {
            cell.phoneLbl.text = taxiArray[indexPath.section].phones[indexPath.row + 1]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccordionHeaderView.kAccordionHeaderViewReuseIdentifier) as? AccordionHeaderView {
            header.taxiNameLbl.text = taxiArray[section].name
            header.taxiNumberLbl.text = taxiArray[section].phones[0]
            
            if taxiArray[section].phones.count <= 1 {
                print("SISPO: Removed moreBtn in section:\(section)")
                header.moreLbl.isHidden = true
                header.moreImg.isHidden = true
            }
            
            return header
        }
        return AccordionHeaderView()
    }
    
}

// MARK: - <FZAccordionTableViewDelegate> -

extension TaxiVC : FZAccordionTableViewDelegate {
    

    func tableView(_ tableView: FZAccordionTableView, willOpenSection section: Int, withHeader header: UITableViewHeaderFooterView) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, didOpenSection section: Int, withHeader header: UITableViewHeaderFooterView) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, willCloseSection section: Int, withHeader header: UITableViewHeaderFooterView) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, didCloseSection section: Int, withHeader header: UITableViewHeaderFooterView) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, canInteractWithHeaderAtSection section: Int) -> Bool {
        return true
    }
}
