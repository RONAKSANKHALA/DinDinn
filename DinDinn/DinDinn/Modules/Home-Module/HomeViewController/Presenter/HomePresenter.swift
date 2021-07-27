//
//  HomePresenter.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 22/07/21.
//

import Foundation
import UIKit

class HomePresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingHomeData() {
        interactor?.fetchHomeData(dictKeyName: "food_list")
    }
    
    func startFetchingFoodData() {
        interactor?.fetchHomeData(dictKeyName: "food_list")
    }
    
    func showFoodController(navigationController: UINavigationController) {
        router?.pushToFoodDetailScreen(navigationConroller:navigationController)
    }
}

extension HomePresenter: InteractorToPresenterProtocol{
    
    func homeFetchedSuccess(homeModelArray: Array<HomeModel>) {
        view?.showHomeImages(homeArray: homeModelArray)
    }
    
    func homeFetchFailed() {
        view?.showError()
    }
    
}
