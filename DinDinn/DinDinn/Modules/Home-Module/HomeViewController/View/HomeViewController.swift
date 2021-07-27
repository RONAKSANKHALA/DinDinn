//
//  HomeViewController.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 22/07/21.
//

import UIKit
import Alamofire
import FittedSheets

let minimumSpaceFromTop = CGFloat(140)
let screenHeight = CGFloat(UIScreen.main.bounds.height)
var sheetMinimumSpace  = (screenHeight - CGFloat(510)) >= minimumSpaceFromTop ? (screenHeight - CGFloat(510)) : minimumSpaceFromTop


class HomeViewController: UIViewController {
    
    @IBOutlet var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet var pageControl: FSPageControl! {
        didSet {
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    
    var presenter: ViewToPresenterProtocol?
    var homeArrayList: Array<HomeModel> = Array()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        presenter?.startFetchingHomeData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            guard let viewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailsViewController") as? FoodDetailsViewController else {
                return
            }
            viewController.arrFoodDetails = self.homeArrayList
            self.sheetViewController?.handleScrollView(viewController.tblFoodDetails)
            self.loadFoodDetailsViewController(forViewController: viewController, withMinimumSpaceAbovePullbar: sheetMinimumSpace)
        }
    }
    
    private func setupUI() {
        pageControl.setFillColor(.gray, for: .normal)
        pageControl.setFillColor(.blue, for: .selected)
        pageControl.setStrokeColor(.yellow, for: .selected)
        pageControl.setStrokeColor(.black, for: .normal)
    }
    
    
    func loadFoodDetailsViewController(forViewController viewController: UIViewController, withMinimumSpaceAbovePullbar minimumSpacePullbar: CGFloat = sheetMinimumSpace) {
        let options = SheetOptions(useFullScreenMode: true)
        
        let nav = UINavigationController(rootViewController: viewController)
        let sheet = SheetViewController(controller: nav, sizes: [.fullscreen],options: options)
        sheet.cornerRadius = 24.0
        sheet.minimumSpaceAbovePullBar = minimumSpacePullbar
        sheet.autoAdjustToKeyboard = false
        sheet.allowPullingPastMaxHeight = true
        

        
        self.present(sheet, animated: true, completion: nil)
    }
    
}
extension HomeViewController: PresenterToViewProtocol {
    func showHomeImages(homeArray: Array<HomeModel>) {
        self.homeArrayList = homeArray
        
        
        if !self.homeArrayList.isEmpty {
            pageControl.numberOfPages = homeArrayList.count
            self.pagerView.reloadData()
        }
    }
    
    func showError() {
        print("Error")
    }
    
    
}

extension HomeViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.homeArrayList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if let image = self.homeArrayList[index].imageurl {
            if let url = URL(string: image) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
        }
        cell.imageView?.contentMode = .scaleToFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
}

