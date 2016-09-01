//
//  MenuVC.swift
//  zaporozhye-app
//
//  Created by Timofey Dolenko on 8/22/16.
//  Copyright © 2016 Timofey Dolenko. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MenuCell",bundle: nil), forCellReuseIdentifier: "MenuCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func isDataAvailable() -> Bool {
        if DataService.ds.placesArray.count > 0 && DataService.ds.hotelsArray.count > 0 && DataService.ds.mallsArray.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func performSegueAfterDownload() {
        performSegueFrom(row: selectedRow)
        stopActivityAnimating()
    }
    
    func performSegueFrom(row: Int) {
        switch row {
        case 0:
            performSegue(withIdentifier: SEGUE_PLACESMENUVC, sender: nil)
        case 1:
            performSegue(withIdentifier: SEGUE_TAXIVC, sender: nil)
        case 2:
            performSegue(withIdentifier: SEGUE_ORDER_FOODVC, sender: nil)
        case 3:
            performSegue(withIdentifier: SEGUE_PLACESVC_FROM_MENU, sender: KEY_HOTELS)
        case 4:
            performSegue(withIdentifier: SEGUE_PLACESVC_FROM_MENU, sender: KEY_MALLS)
        case 5:
            performSegue(withIdentifier: SEGUE_ABOUTVC, sender: nil)
        case 6:
            performSegue(withIdentifier: SEGUE_WEATHERVC, sender: nil)
        default:
            print("SISPO: Error occured when selected row")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath.row
        
        switch indexPath.row {
        case 0,1,2,3,4:
            if isDataAvailable() {
                performSegueFrom(row: indexPath.row)
            } else {
                let size = CGSize(width: 30, height:30)
                
                startActivityAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballPulse)
                NotificationCenter.default.addObserver(self, selector: #selector(MenuVC.performSegueAfterDownload), name: Notification.Name("dataLoaded"), object: nil)
            }
        case 5, 6:
            performSegueFrom(row: indexPath.row)
        default:
            print("SISPO: Error occured. Wrong row")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_PLACESVC_FROM_MENU {
            if let placesVC = segue.destination as? PlacesVC {
                if let type = sender as? String {
                    placesVC.type = type
                } else {
                    print("SISPO: Error in places type")
                }
            } else {
                print("SISPO: Error in places ViewController")
            }
        }
    }

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
