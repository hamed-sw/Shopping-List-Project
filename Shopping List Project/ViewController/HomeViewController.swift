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
    @IBOutlet weak var rusButton: UIBarButtonItem!
    @IBOutlet weak var englishtButton: UIBarButtonItem!
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
        self.tableView.allowsMultipleSelection = true
    }
    
    @IBAction func englishButtonLanguage(_ sender: Any) {
        navigationItem.title =  "Product".localizableString(loc: "en")
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "AddToCardVC" {
                let vc = segue.destination as! AddToCardVC
                vc.navigationItem.title = "AddCard".localizableString(loc: "en")
            }
        }
        
    }
    
    @IBAction func rusButtonLanguage(_ sender: Any) {
        navigationItem.title = "Product".localizableString(loc: "ru")
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "AddToCardVC" {
                let vc = segue.destination as! AddToCardVC
                vc.navigationItem.title = "AddCard".localizableString(loc: "ru")
            }
        }
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

extension String {
    func localizableStringAll(loc: String) -> String {
         let path = Bundle.main.path(forResource: loc, ofType: "lproj")
           let bundle = Bundle(path: path!)
            
            return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: "", comment: "")
        
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
            if let p = viewModel.getPrductPrice(at: indexPath.row) {
                 let price = formatter.string(from: (p) as NSNumber)
                    cell.priceOfProductLabel.text = price
                
            }
            cell.buttonPressed = {
                if let priceOfitme = self.viewModel.getPrductPrice(at: indexPath.row),
                let pictureOfItem = self.viewModel.getProductImage(at: indexPath.row),
                let numid = self.viewModel.getProuductid(at: indexPath.row),
                    let nameOfItem = self.viewModel.getProuductName(at: indexPath.row) {
                JsonPost.addDataToCard(prices: priceOfitme, pic: pictureOfItem, nu: numid, names: nameOfItem)
                self.addItemToTheCard(addtoCard: "AddToCard", massege: "The Item is Sucessfuly add it in your list ")
                }
            }
            cell.accessoryType = cell.isSelected ? .checkmark : .none
            cell.delegate = self
            newCell = cell
        }
        return newCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func addItemToTheCard (addtoCard: String, massege: String) {
        let alert = UIAlertController(title: addtoCard , message: massege, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        tableView.reloadData()
        
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        

    }
    
    
    
}

extension HomeViewController: TableCellDelegate{

    
    func checkAndUpdate(cell: HomeTableViewCell) {
        guard let indexpat = tableView.indexPath(for: cell) else {return}
        if  let namee = self.viewModel.getProuductName(at: indexpat.row),
            let pricee = self.viewModel.getPrductPrice(at: indexpat.row),
            let imagee = self.viewModel.getProductImage(at: indexpat.row),
            let idd = self.viewModel.getProuductid(at: indexpat.row) {
            viewModel.ddd(pirces: pricee, image: imagee, number: idd, names: namee)
            self.addItemToTheCard(addtoCard: "AddToCard", massege: "The Item is Sucessfuly add it in your list ")
        }
        
    }
}
