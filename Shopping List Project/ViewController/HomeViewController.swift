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
   // var arrayList = [String]()
   // var newItem = Item()
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
   

        deleteOldDataFromUserDefaults()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        self.viewModel.delegate = self
        connection()
        registerCell()
        viewModel.fetchNameOfItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.refresh()

    }
    func deleteOldDataFromUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "addItem")
        defaults.synchronize()
        viewModel.arrayNameItem.removeAll()
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
            //newItem = viewModel.getProuductName(at: indexPath.row)!
          // var newElement = cell.nameOfProductLabel.text
            //print(arrayList[indexPath.row])
            //cell.nameOfProductLabel.text = arrayList[indexPath.row].titel
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
            
            
           // viewModel.addItemInArray(nameOfItem: newElement!)
          // print( viewModel.arrayNameItem[0])
//            if arrayList[0].done == true {
//                cell.accessoryType = .checkmark
//          } else {
//               cell.accessoryType = .none
//            print(arrayList[0])
//
//            }
            //let dd = viewModel.arrayNameItem[indexPath]
            //print(dd)
            
            
            
//            if indexPath.row == 0 {
//              if arrayList[indexPath.row].done == true {
//                    cell.accessoryType = .checkmark
//              } else {
//                   cell.accessoryType = .none
//                }
//            }else if indexPath.row == 1 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }else if indexPath.row == 2 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }else if indexPath.row == 3 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }else if indexPath.row == 4 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }else if indexPath.row == 5 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }else if indexPath.row == 6 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }else if indexPath.row == 7 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }else if indexPath.row == 8 {
//                if arrayList[indexPath.row].done == true {
//                      cell.accessoryType = .checkmark
//                } else {
//                     cell.accessoryType = .none
//                  }
//            }
//
//
//
//
//
            
            newCell = cell
        }
        return newCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if arrayList[indexPath.row].done == false {
//
//            arrayList[indexPath.row].done = true
//
//        }else {
//            arrayList[indexPath.row].done = false
//
//        }
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
    
        

    }
    func addItemToTheCard (addtoCard: String, massege: String) {
        let alert = UIAlertController(title: addtoCard , message: massege, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
        tableView.reloadData()
        
    }
    

}
