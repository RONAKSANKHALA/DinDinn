//
//  HomeInteractor.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 22/07/21.
//

import Foundation
import ObjectMapper
import Alamofire

class HomeInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    func fetchHomeData(dictKeyName: String?) {
        
        guard let dict = CommonFunctions.Instance.dataFromFile("HomeViewData") else {
            return
        }
        guard let keyName = dictKeyName else { return }
        guard let homeArray = dict[keyName] as? NSArray else { return }
        if homeArray.count > 0 {
            let arrayObject = Mapper<HomeModel>().mapArray(JSONArray: homeArray as! [[String : Any]]);
            self.presenter?.homeFetchedSuccess(homeModelArray: arrayObject)
        }else {
            self.presenter?.homeFetchFailed()
        }
        
        
    }
}
