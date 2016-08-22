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
    
    var menuArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuArray = ["Places to visit","Cafes/Bars","Taxi","Order Food","Hotels","Shopping Malls","Weather","About City"]
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
}
