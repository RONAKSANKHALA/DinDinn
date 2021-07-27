//
//  FoodDetailTableViewCell.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 27/07/21.
//

import UIKit
import Alamofire

class FoodDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var imgFood: UIImageView!
    @IBOutlet var lblFoodName: UILabel!
    @IBOutlet var lblDetails: UILabel!
    @IBOutlet var lblKal: UILabel!
    @IBOutlet var btnAddToList: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAddToList.layer.cornerRadius = 25
    }
    
    var foodData: HomeModel? {
        didSet {
            if let data = foodData {
                if let imageURL = data.imageurl {
                    Alamofire.AF.request(imageURL).responseData { (response) in
                        if response.error == nil {
                            print(response.result)
                            if let data = response.data {
                                self.imgFood.image = UIImage(data: data)
                            }
                        }
                    }
                }
                
                self.lblFoodName.text = data.title
                self.lblDetails.text = data.brief
            }
        }
    }
    
}
