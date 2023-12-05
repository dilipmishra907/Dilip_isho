//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Ishi on 01/12/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    @IBOutlet weak var tblview: UITableView!
    
    var dataViewModel = HomeViewModel()
    var webservice = Webservice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        // Do any additional setup after loading the view.
    }


    func initViewModel(){
        var url = URL(string: "https://newsapi.org/v1/articles?source=the-next-web&sortBy=latest&apiKey=0cf790498275413a9247f8b94b3843fd")
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tblview.reloadData()
            }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityMonitor.startAnimating() }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityMonitor.stopAnimating()
                self.activityMonitor.isHidden = true
            }
        }
        dataViewModel.getArticleData(url: url!)
    }

}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as? CustomTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }

        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.lblTitle.text = cellVM.titleText 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsViewModel = dataViewModel.getCellViewModel(at: indexPath)

       
    }
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
}
