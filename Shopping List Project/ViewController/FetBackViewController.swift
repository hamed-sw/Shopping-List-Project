//
//  FetBackViewController.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 24.03.2021.
//

import UIKit


class FetBackViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addFetBack: UIBarButtonItem!
    
    
    lazy var viewModel = FetbackModel()
    var arraySelect = [String]()
    var arraypath = [String]()
    var forDelet: (() -> ()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.viewModel.delegate = self
        registerCell()
        tableView.isEditing = true
        tableView.allowsMultipleSelectionDuringEditing = true

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false

        self.viewModel.delegate = self
        connections()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: CellIdentifire.fetbackCell , bundle: nil), forCellReuseIdentifier: CellIdentifire.fetbackCell)
    }
    func connections() {
        viewModel.fetbackToProduct()
    }
    @IBAction func trashBin(_ sender: Any) {
        for num in self.arraypath {
            self.viewModel.deleteTheProductFromFetback(productId: num)
        }
        arraypath.removeAll()
      forDelet()
    }
    
    @IBAction func addFetBackTap(_ sender: Any) {
      
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTotalNumberOfFetback() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newCell = FetBackTableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.fetbackCell, for: indexPath) as? FetBackTableViewCell {
            cell.fetbackLabel.text = viewModel.getFetBack(at: indexPath.row)
            newCell = cell

        }
        return newCell
     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let str = self.viewModel.getFetBackDelet(at: indexPath.row) else {return}
        let size = str.reversed().firstIndex(of: "/") ?? str.count
        let startWord = str.index(str.endIndex, offsetBy: -size)
        let last = str[startWord...]
        let sss = String(last)
        print (sss)
        print("printselect")
        arraypath.append(sss)
        print(arraypath)
        forDelet = {
            tableView.beginUpdates()
            var _ = self.viewModel.getTotalNumberForRemove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.connections()
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let str = self.viewModel.getFetBackDelet(at: indexPath.row) else {return}
        let size = str.reversed().firstIndex(of: "/") ?? str.count
        let startWord = str.index(str.endIndex, offsetBy: -size)
        let last = str[startWord...]
        let deletestring = String(last)
        print (deletestring)
        print("didselect")
        for compare in 0..<arraypath.count{
            if deletestring == arraypath[compare]{
                 print(arraypath[compare])
                arraypath.remove(at: compare)
                break
            }
        }
        print(arraypath)
        print(indexPath.row)

        print("deselect")
        print(arraypath)
    }

}

extension FetBackViewController: FetBackModelDelegate {
    func updates() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
    }
  
}
