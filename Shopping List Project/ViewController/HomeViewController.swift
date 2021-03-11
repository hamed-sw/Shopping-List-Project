//
//  HomeViewController.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController,HomeViewModelDelegate {
    
    
    
    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    
    //Variable
    lazy var viewModel = HomeViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        self.viewModel.delegate = self
        connection()
        registerCell()
    }

    private func registerCell() {
        tableView.register(UINib(nibName: CellIdentifire.homeTableViewCell , bundle: nil), forCellReuseIdentifier: CellIdentifire.homeTableViewCell)
    }
    func connection() {
        viewModel.productSearch()
    }
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTotalNumberOfProducts() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newCell = HomeTableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.homeTableViewCell, for: indexPath) as? HomeTableViewCell {
            
            cell.nameOfProductLabel.text = viewModel.getProuductName(at: indexPath.row)
            
            if let urlString = viewModel.getProductImage(at: indexPath.row){
                cell.productImage.kf.setImage(with: URL(string: urlString))
            }
            
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            if let price = formatter.string(from: (viewModel.getPrductPrice(at: indexPath.row))! as NSNumber) {
                cell.priceOfProductLabel.text = price
            }
            cell.buttonPressed = {
                let priceOfitme = self.viewModel.getPrductPrice(at: indexPath.row)!
                let pictureOfItem = self.viewModel.getProductImage(at: indexPath.row)!
                let numid = self.viewModel.getProuductid(at: indexPath.row)!
                let nameOfItem = self.viewModel.getProuductName(at: indexPath.row)!
                JsonPost.addDataToCard(prices: priceOfitme, pic: pictureOfItem, nu: numid, names: nameOfItem)
                self.addItemToTheCard(addtoCard: "AddToCard", massege: "The Item is Sucessfuly add it in your list ")
            }
            
            newCell = cell
        }
        return newCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
    }
    
    func addItemToTheCard (addtoCard: String, massege: String) {
        let alert = UIAlertController(title: addtoCard , message: massege, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        tableView.reloadData()
        
    }
    
    
}
