//
//  ViewController.swift
//  FAQExample
//
//  Created by amul on 29/12/17.
//  Copyright © 2017 amul. All rights reserved.
//

import UIKit

class FAQModel {
    
    var id: Int = 0
    var title: String?
    var description: String?
    var isExpandable: Bool = false
    
    init(title:String?, description:String?, isExpandable:Bool = false) {
        self.title = title
        self.description = description
        self.isExpandable = isExpandable
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var faqModelArray = [FAQModel]()
    
    let desc = "William Shakespeare (/ˈʃeɪkspɪər/;[1] 26 April 1564 (baptised) – 23 April 1616)[a] was an English poet, playwright and actor, widely regarded as the greatest writer in the English language and the world's pre-eminent dramatist.[3] He is often called England's national poet and the .[4][b] His extant works, including collaborations, consist of approximately 39 plays,[c] 154 sonnets, two long narrative poems and a few other verses, some of uncertain authorship. His plays have been translated into every major living language and are performed more often than those of any other playwright.[6]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nibRegistration()
        faqModelArrayFilling()
        self.tableView.estimatedRowHeight = 30
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func nibRegistration()  {
        tableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
    }

    func faqModelArrayFilling() {
        for x in 1..<6{
            faqModelArray.append(FAQModel(title: "FAQ NUmber\(x)", description: desc))
        }
        tableView.reloadData()
    }
    
    var expandedIndexPath: IndexPath? {
        didSet {
            switch expandedIndexPath {
            case .some(let index):
                tableView.reloadRows(at: [index], with: .automatic)
            case .none:
                tableView.reloadRows(at: [oldValue!], with: .automatic)
            }
        }
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let faqCell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as? FAQCell else{
            print("Unable to create Cell")
            return UITableViewCell()
        }
        let faqModelObject = faqModelArray[indexPath.row]
        faqModelObject.id = indexPath.row
        
        faqCell.dataModel = faqModelObject
        
        faqCell.titlelabel.text = faqModelObject.title
        faqCell.descriptionLabel.text = faqModelObject.description
        
        faqCell.setNeedsUpdateConstraints()
        faqCell.updateConstraintsIfNeeded()
        
        return faqCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let faqModelObject = faqModelArray[indexPath.row]
        for item:FAQModel in faqModelArray {
            
            if item.id == faqModelObject.id{
                item.isExpandable = !item.isExpandable
            }
            else{
                item.isExpandable = false
            }
        }
        
        switch expandedIndexPath {
        case .some(_) where expandedIndexPath == indexPath:
            //Click on expandable cell then close it.
            expandedIndexPath = nil
        case .some(let expandedIndex) where expandedIndex != indexPath:
            //New Cell link, already any cell expand -> old close and new expand
            expandedIndexPath = nil
            expandedIndexPath = indexPath
        default:
            //Click on Cell, no cell is expandable.
            expandedIndexPath = indexPath
        }
    }
}
