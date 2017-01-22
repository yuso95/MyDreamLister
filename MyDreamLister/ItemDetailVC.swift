//
//  ItemDetailVC.swift
//  MyDreamLister
//
//  Created by Younoussa Ousmane Abdou on 1/20/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - MyStoryBoard
    
    // MARK: - Variables/Constants/Computed Properties
    
    var stores = [Store]()
    var item: Item!
    var itemToEdit: Item?
    var imagePickerController: UIImagePickerController!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var thumbIMG: UIImageView!
    @IBOutlet private weak var titleTFD: UITextField!
    @IBOutlet private weak var priceTFD: UITextField!
    @IBOutlet private weak var detailTFD: UITextField!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    // MARK: - Actions
    
    @IBAction private func saveBTNPressed(sender: UIButton) {
        
        // Throw a nil error when pressing on save button !!!
        
        let image = Image(context: context)
        image.image = thumbIMG.image
        
        var item: Item!
        
        if itemToEdit == nil {
            
            item = Item(context: context)
        } else {
            
            item = itemToEdit
        }
        
        // Just to access the item
        
        item.toImage = image
        
        if let title = titleTFD.text {
            
            item.title = title
        }
        
        if let price = priceTFD.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let detail = detailTFD.text {
            
            item.details = detail
        }
        
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    // App freeze when delete is pressed !!!
    @IBAction private func deleteBTNPressed(sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func addImageBTN(sender: UIButton) {
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        attemptFetch()
        //        generateStores()
        
        if itemToEdit != nil {
            
            loadData()
        }
    }
    
    private func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            stores = try context.fetch(fetchRequest)
            pickerView.reloadComponent(0)
        } catch let error as NSError {
            
            print(error.debugDescription)
        }
    }
    
    private func generateStores() {
        
        let store0 = Store(context: context)
        store0.name = "Best Buy"
        let store1 = Store(context: context)
        store1.name = "Amazon"
        let store2 = Store(context: context)
        store2.name = "Target"
        let store3 = Store(context: context)
        store3.name = "Tesla car dealership"
        let store4 = Store(context: context)
        store4.name = "Ebay"
        
        ad.saveContext()
    }
    
    private func loadData() {
        
        if let item = itemToEdit {
            
            thumbIMG.image = item.toImage?.image as? UIImage
            
            titleTFD.text = item.title
            
            priceTFD.text = "\(item.price)"
            
            titleTFD.text = item.title
            priceTFD.text = "\(item.price)"
            detailTFD.text = item.details
            
            if let store = item.toStore {
                
                var index = 0
                
                repeat {
                    
                    let eachStore = stores[index]
                    
                    if eachStore.name == store.name {
                        
                        pickerView.selectRow(index, inComponent: 0, animated: true)
                        
                        index += 1
                        
                        break
                    }
                } while ( index < stores.count)
            }
        }
    }
    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        let name = store.name
        
        return name
    }
    
    // MARK: - ImagePickerController
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbIMG.image = image
        }
        
        dismiss(animated: true, completion: nil)
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
