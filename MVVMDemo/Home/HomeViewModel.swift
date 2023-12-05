//
//  DataViewModel.swift
//  MVVMDemo
//
//  Created by Ishi on 02/12/23.
//

import Foundation
import UIKit

class HomeViewModel {
        
    var article: [Article] = [Article]()

    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?


    
    private var cellViewModels: [DataListCellViewModel] = [DataListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    
    func getArticleData(url : URL){
        showLoading?()
        Webservice().getArticle(url: url, completionHandler: {success, data in
                        self.hideLoading?()
                        if(success){
                            DispatchQueue.main.async {
                                self.createCell(article: data)
                                self.reloadTableView?()
                            }
                        }
                        else
                        {
                            self.showError?()
                        }
                    })
    }
    
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func createCell(article: [Article]){
        self.article = article
        var vms = [DataListCellViewModel]()
        for data in article {
            vms.append(DataListCellViewModel(titleText: data.title, subTitleText: data.description))
        }
        cellViewModels = vms
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        return cellViewModels[indexPath.row]
    }
}

struct DataListCellViewModel {
    let titleText: String
    let subTitleText: String
}
