//
//  FoodDetailsViewController.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 27/07/21.
//

import UIKit

class FoodDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var arrFoodDetails: Array<HomeModel> = Array()
    
    @IBOutlet var tblFoodDetails: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !arrFoodDetails.isEmpty {
            self.tblFoodDetails.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFoodDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDetailTableViewCell", for: indexPath) as? FoodDetailTableViewCell else { return UITableViewCell() }
        let data = self.arrFoodDetails[indexPath.row]
        cell.foodData = data
        return cell
    }
    
}
