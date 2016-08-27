//
//  MenuVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MenuCell",bundle: nil), forCellReuseIdentifier: "MenuCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: SEGUE_PLACESMENUVC, sender: nil)
        case 1:
            performSegue(withIdentifier: SEGUE_TAXIVC, sender: nil)
        case 5:
            performSegue(withIdentifier: SEGUE_ABOUTVC, sender: nil)
        case 6:
            performSegue(withIdentifier: SEGUE_WEATHERVC, sender: nil)
        default:
            print("SISPO: Error occured when selected row")
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuData.MenuDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell {
            
            if let dict = MenuData.MenuDict["cell\(indexPath.row)"] {
                if let title = dict["title"] , let imgPath = dict["imgPath"] {
                    cell.configureCell(title: title, imgPath: imgPath)
                    return cell
                }
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (view.frame.height - 50) / CGFloat(MenuData.MenuDict.count)
        return height
    }

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
