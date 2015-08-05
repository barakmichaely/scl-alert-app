//
//  CollectionTest.swift
//  AlertApp
//
//  Created by Barak M on 4/1/15.
//  Copyright (c) 2015 Seidenberg Creative Labs. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI


class CollectionTest: UICollectionViewController, ABPeoplePickerNavigationControllerDelegate {

    let limit:Int = 8
    var contactsArray = Array<Dictionary<String, String>>()
    let nameKey = "name"
    let phoneKey = "phone"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedContacts = NSUserDefaults().arrayForKey("myContacts") as? [[String:AnyObject]] {
            
            for item in loadedContacts {
                didSelectContactWithName(item[nameKey] as! String, phone: item[phoneKey] as! String)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPicker() {
        
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        
        picker.displayedProperties = [Int(kABPersonPhoneProperty)];
        
        picker.predicateForEnablingPerson = NSPredicate(format: "phoneNumbers.@count > 0")
        
        //picker.predicateForEnablingPeron = ONLY IF NOT ALREADY IN ARRAY
        
        picker.predicateForSelectionOfPerson = NSPredicate(format: "phoneNumbers.@count = 1")
        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!) {
        
        let contactNameString = ABRecordCopyCompositeName(person).takeRetainedValue() as String
        
        var phoneNumber = "N/A"
        let phoneNumbers: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
        phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, 0).takeRetainedValue() as! String
        
        didSelectContactWithName(contactNameString, phone: phoneNumber)
        
        //save contact persistently

    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        
        let contactNameString = ABRecordCopyCompositeName(person).takeRetainedValue() as String
        
        var phoneNumber = "N/A"
        let phoneNumbers: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
        
        let countOfPhones = ABMultiValueGetCount(phoneNumbers)
        
        if (countOfPhones > 0) {
            var index = CFIndex(0)
            if identifier != kABMultiValueInvalidIdentifier {
                index = ABMultiValueGetIndexForIdentifier(phoneNumbers, identifier)
            }
            phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, index).takeRetainedValue() as! String
        }
        
        didSelectContactWithName(contactNameString, phone: phoneNumber)

    }
    
    func didSelectContactWithName(name : String, phone : String) {

        for var i = 0; i < contactsArray.count; i++ {
            if (contactsArray[i][nameKey] == name) && (contactsArray[i][phoneKey] == phone) {
                //should not be able to select same contact
                //Alert currently not displaying (error: view is not in the window hierarchy)
                let alert = UIAlertController(title: "Alert", message: "The person is already in your list.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
        }
        
        contactsArray.append([nameKey : name, phoneKey : phone])
        
        NSUserDefaults().setObject(contactsArray, forKey: "myContacts") //save contacts persistently
        
        
        collectionView?.reloadData()

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (contactsArray.count == limit) {
            return contactsArray.count
        }
        return contactsArray.count + 1
    }

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let row = indexPath.row
        var cellID = "contact"
        
        if (row == self.contactsArray.count && self.contactsArray.count<limit) {
            cellID = "plus"
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! UICollectionViewCell
        
        if cell.isKindOfClass(ContactCell) {
            let contactCell = cell as! ContactCell
            let contact = contactsArray[indexPath.item]
            contactCell.nameLabel.text = contact[nameKey]
            contactCell.phoneLabel.text = contact[phoneKey]
        }
    
        cell.layer.cornerRadius = 80
        cell.layer.masksToBounds = true
        
        return cell
    }

    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == self.contactsArray.count) {
            // Create New Contact
            showPicker()
            
//            self.itemAmount += 1
            collectionView.reloadData()
//            collectionView.performBatchUpdates({
//            }, completion: {b in })
            
        } else {
            // Remove Contact
            //INSERT ALERT VIEW OR SOMETHING TO ASK WHETHER CONTACT SHOULD BE REMOVED
            //"Do you want to remove the contact form your list?"
            //IF REALLY WANT TO REMOVE:
            contactsArray.removeAtIndex(indexPath.item)
            collectionView.reloadData()
            
            //showpicker() //-> if want to enable selection of different contact instead

//            
//            var contactView = self.storyboard!.instantiateViewControllerWithIdentifier("editContact") as! EditContact
//            self.showViewController(contactView, sender: self)
        }
        
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    //Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
