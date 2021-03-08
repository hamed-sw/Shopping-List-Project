//
//  AddToCardVC.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import UIKit

class AddToCardVC: UIViewController{

    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // Variable
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()

    }
    private func registerCell() {
        tableView.register(UINib(nibName: CellIdentifire.addCardTableViewCell , bundle: nil), forCellReuseIdentifier: CellIdentifire.addCardTableViewCell)
    }


}
extension AddToCardVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newCell = AddCardTableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.addCardTableViewCell, for: indexPath) as? AddCardTableViewCell {
            
            newCell = cell
        }
        return newCell
    }
    
    
    
}
