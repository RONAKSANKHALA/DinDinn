//
//  HomeRouter.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 22/07/21.
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterProtocol {
    static func createModule() -> HomeViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = HomePresenter()
        let interactor: PresenterToInteractorProtocol = HomeInteractor()
        let router:PresenterToRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToFoodDetailScreen(navigationConroller: UINavigationController) {
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Home",bundle: Bundle.main)
    }
}
