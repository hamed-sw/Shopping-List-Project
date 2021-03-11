//
//  AddToCardVC.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import UIKit
import Kingfisher

class AddToCardVC: UIViewController, AddViewModelDelegate{
    
    
    
    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // Variable
    lazy var addModelView = AddCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        self.addModelView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
        self.tableView.allowsMultipleSelection = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
        connection()
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        tableView.reloadData()
//    }
    private func registerCell() {
        tableView.register(UINib(nibName: CellIdentifire.addCardTableViewCell , bundle: nil), forCellReuseIdentifier: CellIdentifire.addCardTableViewCell)
    }
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func connection(){
        addModelView.AddCardSearch()
    }
    
    
}
//MARK: EXTENSION...
extension AddToCardVC: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addModelView.getTotalNumberOfAddCard() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newCell = AddCardTableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.addCardTableViewCell, for: indexPath) as? AddCardTableViewCell {
            if let urlString = addModelView.getAddCardImage(at: indexPath.row){
                cell.addImage.kf.setImage(with: URL(string: urlString))
            }
            cell.nameLabel.text = addModelView.getAddCardName(at: indexPath.row)
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            
            if let price = formatter.string(from: (addModelView.getAddCardPrice(at: indexPath.row))! as NSNumber) {
                cell.priceLabel.text = price
            }
            cell.callBackOnButtonLogout = {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardId.buyItemViewController) as! BuyItemViewController
                let namOfItem = self.addModelView.getAddCardName(at: indexPath.row)
                vc.nameItem = "Add card For " + namOfItem!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.accessoryType = cell.isSelected ? .checkmark : .none

            newCell = cell
        }
        return newCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let str = addModelView.getAddCardDeletId(at: indexPath.row)!
            let size = str.reversed().firstIndex(of: "/") ?? str.count
            let startWord = str.index(str.endIndex, offsetBy: -size)
            let last = str[startWord...]
            let sss = String(last)
            print (sss)
            
            
            JsonDelete.del(id: sss) { (erro) in
                if let err = erro {
                    print("errrrrr",err)
                    return
                }
                print("delete")
            }
            self.addModelView.getTotalNumberOf(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none

    }
    
    
}
