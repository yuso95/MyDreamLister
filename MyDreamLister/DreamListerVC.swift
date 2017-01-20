//
//  DreamListerVC.swift
//  MyDreamLister
//
//  Created by Younoussa Ousmane Abdou on 1/20/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit
import CoreData

class DreamListerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    // MARK: - MyStoryBoard
    
    private struct MyStoryBoard {
        
        static let CellID = "ItemCell"
        static let AddSegueID = "ItemDetailNew"
        static let DetailSegueID = "ItemDetail"
    }
    
    // MARK: - Variables/Constants/Computed Properties
    
    var controller: NSFetchedResultsController<Item>!
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var segmentControl: UISegmentedControl!
    
    // MARK: - Actions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView set up
        
        tableView.delegate = self
        tableView.dataSource = self
        
        attemptFetch()
        // generateTestData()
    }
    
    private func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.controller = controller
        
        controller.delegate = self
        
        do {
            
            try controller.performFetch()
        } catch let error as NSError {
            
            print(error.debugDescription)
        }
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            
            return sections.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: MyStoryBoard.CellID, for: indexPath) as? ItemCell {
            
            configureCell(cell: itemCell, indexPath: indexPath)
        }
        
        return ItemCell()
    }
    
    private func configureCell(cell: ItemCell, indexPath: IndexPath) {
        
        let item = controller.object(at: indexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    // MARK: - Controller
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            break
        case .delete:
            
            if let indexPath = indexPath {
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            
            if let indexPath = indexPath {
                
                let itemCell = tableView.cellForRow(at: indexPath) as! ItemCell
                
                configureCell(cell: itemCell, indexPath: indexPath)
                
                // Do something here for later
            }
            break
        case .move:
            
            if let newIndexPath = newIndexPath {
                
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            if let indexPath = indexPath {
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // Testing data
    
    private func generateTestData() {
        
        let item = Item(context: context)
        item.title = "Tesla Model S"
        item.price = 80000
        item.details = "I want this car so bad. Just patience when I get through the current pain."
        
        let item2 = Item(context: context)
        item2.title = "Nothing more"
        item2.price = 0
        item2.details = "I could not find anything else to add in my dream whishlist."
        
        ad.saveContext()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension Item {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
