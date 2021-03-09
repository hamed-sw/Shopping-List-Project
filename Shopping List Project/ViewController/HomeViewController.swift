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
//            if let price = viewModel.getPrductPrice(at: indexPath.row) {
//               cell.priceOfProductLabel.text = String(price)
//            }
            if let urlString = viewModel.getProductImage(at: indexPath.row){
                cell.productImage.kf.setImage(with: URL(string: urlString))
            }
            
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
           // let currencyDymbol = formatter.currencySymbol!
            //let currencycode = formatter.currencyCode!
            if let price = formatter.string(from: (viewModel.getPrductPrice(at: indexPath.row))! as NSNumber) {
                cell.priceOfProductLabel.text = price
            }
            cell.buttonPressed = {
                var p = self.viewModel.getPrductPrice(at: indexPath.row)!
                var pict = self.viewModel.getProductImage(at: indexPath.row)!
                var numid = self.viewModel.getProuductid(at: indexPath.row)!
                var nammm = self.viewModel.getProuductName(at: indexPath.row)!
                JsonPost.addDataToCard(prices: p, pic: pict, nu: numid, names: nammm)
                self.addItemToTheCard(addtoCard: "AddToCard", massege: "The Item is Sucessfuly add it in your list ")
                

                
            }
            
            
            
            
            newCell = cell
        }
        return newCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var p = viewModel.getPrductPrice(at: indexPath.row)!
//        var pict = viewModel.getProductImage(at: indexPath.row)!
//        var numid = viewModel.getProuductid(at: indexPath.row)!
//        var nammm = viewModel.getProuductName(at: indexPath.row)!
//        JsonPost.addDataToCard(prices: p, pic: pict, nu: numid, names: nammm)
//    }
    func addItemToTheCard (addtoCard: String, massege: String) {
        let alert = UIAlertController(title: addtoCard , message: massege, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
        tableView.reloadData()
        
    }

    
    
}
