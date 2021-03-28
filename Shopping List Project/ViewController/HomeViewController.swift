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
    var lang: (() -> ()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("en", forKey: languagekey)
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        self.viewModel.delegate = self
        connection()
        registerCell()
        self.tableView.allowsMultipleSelection = true
    }
    
    @IBAction func englishButtonLanguage(_ sender: Any) {
        UserDefaults.standard.set("en", forKey: languagekey)
        tableView.reloadData()
        self.languages()
        
    }
    
    @IBAction func rusButtonLanguage(_ sender: Any) {
        UserDefaults.standard.set("de", forKey: languagekey)
        tableView.reloadData()
        self.languages()
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

// MARK:
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
            
            if let aboutPrice = viewModel.getPrductPrice(at: indexPath.row) {
                cell.priceOfProductLabel.text = String(format: "$%.02f", aboutPrice)
                
            }
            cell.addCardButton.setTitle(KeyString.addCardButton.localizableString(), for: .normal)

            
            cell.accessoryType = cell.isSelected ? .checkmark : .none
            cell.delegate = self
            newCell = cell
        }
        return newCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
   public func addItemToTheCard (addtoCard: String, massege: String) {
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

// MARK:
extension HomeViewController: TableCellDelegate{
    func language(cell: HomeTableViewCell) {
        lang = {
          cell.addCardButton.setTitle(KeyString.addCardButton.localizableString(), for: .normal)
        }
    }
    

    func checkAndUpdate(cell: HomeTableViewCell) {
        guard let indexpat = tableView.indexPath(for: cell) else {return}
        if  let namee = self.viewModel.getProuductName(at: indexpat.row),
            let pricee = self.viewModel.getPrductPrice(at: indexpat.row),
            let imagee = self.viewModel.getProductImage(at: indexpat.row),
            let idd = self.viewModel.getProuductid(at: indexpat.row) {
            viewModel.ddd(pirces: pricee, image: imagee, number: idd, names: namee)
            self.addItemToTheCard(addtoCard: KeyString.itemAdd.localizableString(), massege: KeyString.addlist.localizableString())
        }
        
    }
    func languages() {
        navigationItem.title = KeyString.Products.localizableString()
    }
}

