//
//  HomeProtocol.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 22/07/21.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject {
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingHomeData()
    func startFetchingFoodData()
    func showFoodController(navigationController:UINavigationController)
    
}

protocol PresenterToViewProtocol: AnyObject {
    func showHomeImages(homeArray:Array<HomeModel>)
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule()-> HomeViewController
    func pushToFoodDetailScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchHomeData(dictKeyName: String?)
}

protocol InteractorToPresenterProtocol: AnyObject {
    func homeFetchedSuccess(homeModelArray:Array<HomeModel>)
    func homeFetchFailed()
}
