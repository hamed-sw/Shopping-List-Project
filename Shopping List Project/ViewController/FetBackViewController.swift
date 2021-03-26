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
   // var aarr = [Int]()
    var arraypath = [String]()
    var forDelet: (() -> ()) = {}
    //var forBollean:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchdata()
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
    func touchdata() {
      //  viewModel.getTotalNumberForRemove(at: )
//        let cell = FetBackTableViewCell()
//        let indexpath = tableView.indexPath(for: cell)
//        [datanew(name: self.F, islecet: self.viewModel.getBoolean(at: indexpath!.row))]
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
          //  cell.fetbackLabel.text = viewModel.getFetBack(at: indexPath.row)
            cell.fetbackLabel.text = viewModel.getFetBack(at: indexPath.row)
            newCell = cell

        }
        return newCell
     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  self.selectDeselectCell(tableView: tableView, indexpath: indexPath)
        guard let str = self.viewModel.getFetBackDelet(at: indexPath.row) else {return}
        let size = str.reversed().firstIndex(of: "/") ?? str.count
        let startWord = str.index(str.endIndex, offsetBy: -size)
        let last = str[startWord...]
        let sss = String(last)
        print (sss)
        print("printselect")
        arraypath.append(sss)
        print(arraypath)
       // print(aarr)
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
       // self.selectDeselectCell(tableView: tableView, indexpath: indexPath)
        //forBollean = viewModel.getBoolean(at: indexPath.row)
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
       // print(arraypath)
        //aarr.append(indexPath.row)
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
    
//    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
//        true
//    }
//    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
//        tableView.setEditing(true, animated: true)
//    }
//    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
//       // print("\(#function)")
//
//    }
//
    
    
}
