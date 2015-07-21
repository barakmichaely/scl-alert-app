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
        
        picker.predicateForSelectionOfPerson = NSPredicate(format: "phoneNumbers.@count = 1")

//            [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];

        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!) {
        
        let contactNameString = ABRecordCopyCompositeName(person).takeRetainedValue() as String
        
        
        didSelectContactWithName(contactNameString, phone: "NA")
        
        
        //add this contact to the respective table view cell here
        // save the info (contact name and phone number permanently)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        
        let contactNameString = ABRecordCopyCompositeName(person).takeRetainedValue() as String
        didSelectContactWithName(contactNameString, phone: "NA")

    }
    
    func didSelectContactWithName(name : String, phone : String) {
        contactsArray.append([nameKey : name, phoneKey : phone])
        
        collectionView?.reloadData()

    }
    
//    func convertCFStringToString(cfString: Unmanaged<AnyObject>!) -> String? {
//        let value = Unmanaged<CFStringRef>.fromOpaque(cfValue.toOpaque()).takeUnre
//    }
    
//    
//    // A selected person is returned with this method.
//    - (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
//    {
//    NSString *contactName = CFBridgingRelease(ABRecordCopyCompositeName(person));
//    self.resultLabel.text = [NSString stringWithFormat:@"Picked %@", contactName ? contactName : @"No Name"];
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            // Edit Contact
//HERE            showPicker()
            
            //display new contact in respective table view cell
            //save new contact (keep when app closes)
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
    // Uncomment this method to specify if the specified item should be selected
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
