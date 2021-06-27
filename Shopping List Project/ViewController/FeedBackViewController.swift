//
//  FetBackViewController.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 24.03.2021.
//

import UIKit


class FetBackViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addFetBack: UIBarButtonItem!
    @IBOutlet weak var selectAndDeselect: UIBarButtonItem!
    
    //variable
    lazy var viewModel = FetbackModel()
    var arraypath = [String]()
    var arrayIndexpath = [Int]()
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.viewModel.delegate = self
        registerCell()
        tableView.allowsSelectionDuringEditing = true
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        tableView.refreshControl = UIRefreshControl()
        
        tableView.refreshControl?.addTarget(self, action: #selector(didpullrefresh), for: .valueChanged)
        
        self.tableView.backgroundView = indicator
    }
    
    @objc func didpullrefresh() {
        
        print("refresh")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.tableView.refreshControl?.endRefreshing()
            
            self.tableView.reloadData()
            
            self.connections()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addFetBack.title = KeyString.Add.localizableString()
        
        selectAndDeselect.title = KeyString.select.localizableString()
        
        navigationItem.title = KeyString.AboutFeedback.localizableString()
        
        navigationItem.backBarButtonItem?.title = KeyString.nextBack.localizableString()
        
        self.tabBarController?.tabBar.isHidden = false
        
        self.tableView.reloadData()
        
        self.viewModel.delegate = self
        
        self.tableView.isEditing = false
        
        connections()
        
        arraypath.removeAll()
        
        arrayIndexpath.removeAll()
    }
    
    private func registerCell() {
        
        tableView.register(UINib(nibName: CellIdentifire.fetbackCell , bundle: nil), forCellReuseIdentifier: CellIdentifire.fetbackCell)
    }
    
    func connections() {
        
        viewModel.fetbackToProduct()
        
    }
    
    @IBAction func selectDeselectTap(_ sender: Any) {
        viewModel.selecteAndDesected(tableView: tableView, selectAndDeselect: selectAndDeselect, arrapath: &arraypath, arrayIndexpath: &arrayIndexpath)
        

        
//        if selectAndDeselect.title == KeyString.select.localizableString() {
//
//            if viewModel.getFetBack(at: 0) != "" {
//
//                tableView.isEditing = true
//
//                selectAndDeselect.title = KeyString.Unselect.localizableString()
//            }
//
//        }else if selectAndDeselect.title == KeyString.Unselect.localizableString() {
//
//            tableView.isEditing = false
//
//            selectAndDeselect.title = KeyString.select.localizableString()
//
//            arraypath.removeAll()
//
//            arrayIndexpath.removeAll()
//        }
        
    }
    
    @IBAction func trashBin(_ sender: Any) {
        
        if  tableView.isEditing == true && !arraypath.isEmpty {
            
            self.alertForDeletItem()
            
            self.indicator.startAnimating()
        }
    }
    
    @IBAction func addFetBackTap(_ sender: Any) {
        
        performSegue(withIdentifier: StoryBoardId.SubmitViewController, sender: nil)
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
        
        if tableView.isEditing == true {
            
            guard let str = self.viewModel.getFetBackDelet(at: indexPath.row) else {return}
            
            let takeId = viewModel.takeIDfromUrl(string: str)
            
            arraypath.append(takeId)
            
            arrayIndexpath.append(indexPath.row)
            // print(indexPath.row)
            //print(arrayIndexpath)
            // print(arraypath)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing == true {
            
            guard let str = self.viewModel.getFetBackDelet(at: indexPath.row) else {return}
            
            let takeID = viewModel.takeIDfromUrl(string: str)
            
            self.viewModel.selectAndNotSelectRow(integer: arraypath.count, str: takeID, arrpath: &arraypath, arrayIndexpath: &arrayIndexpath)
            //            for compare in 0..<arraypath.count{
            //                if takeID == arraypath[compare]{
            //                    print(arraypath[compare])
            //                    arraypath.remove(at: compare)
            //                    print(arrayIndexpath)
            //                    arrayIndexpath.remove(at: compare)
            //                    print(arrayIndexpath)
            //
            //                    break
            //                }
            //            }
            
        }
    }
}
// MARK: EXTENSION
extension FetBackViewController: FetBackModelDelegate {
    
    func updates() {
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let str = self.viewModel.getFetBackDelet(at: indexPath.row) else {return}
        
        let takeId = viewModel.takeIDfromUrl(string: str)
        
        self.viewModel.deleteTheProductFromFetback(productId: takeId)
        
        var _ = self.viewModel.getTotalNumberForRemove(at: indexPath.row)
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        
        true
    }
    
    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        
        tableView.setEditing(true, animated: true)
    }
    
    func alertForDeletItem() {
        
        let alert = UIAlertController(title: KeyString.delete.localizableString(), message: KeyString.masseg.localizableString(), preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
            for numberID in self.arraypath {
                
                self.viewModel.deleteTheProductFromFetback(productId: numberID)
                
                self.tableView.endUpdates()
                
                self.indicator.startAnimating()
                
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                
                self.indicator.stopAnimating()
                
                self.tableView.refreshControl?.endRefreshing()
                
                self.tableView.reloadData()
                
                self.connections()
            }
            
            self.tableView.isEditing = false
            
            self.selectAndDeselect.title = KeyString.select.localizableString()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.indicator.stopAnimating()
        }))
        present(alert, animated: true, completion: nil)
    }
}
