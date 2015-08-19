//
//  CollectionTest.swift
//  AlertApp
//
//  Created by Barak M on 4/1/15.
//  Copyright (c) 2015 Seidenberg Creative Labs. All rights reserved.
//

import UIKit



class CollectionTest: UICollectionViewController {

    var itemAmount:Int = data.contacts.count
    let limit:Int = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        itemAmount = data.contacts.count
        self.collectionView!.reloadData()
    }
    
    func newContact() {
        // Create New Contact
        var newContact = NSMutableDictionary()
        data.contacts.append(newContact)
        
        // Edit New Contact
        editContact(data.contacts.count-1)
    }
    
    func editContact(pos:Int) {
        // Edit Contact
        var contactView = self.storyboard!.instantiateViewControllerWithIdentifier("editContact") as! EditContact
        contactView.contactPos = pos
        self.showViewController(contactView, sender: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        if (itemAmount == limit) {
            return itemAmount
        }
        return itemAmount + 1
    }

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let row = indexPath.row
        var cellID = "contact"
        
        if (row == self.itemAmount && self.itemAmount<limit) {
            cellID = "plus"
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! UICollectionViewCell
    
        cell.layer.cornerRadius = cell.frame.size.width * 0.5
        cell.layer.masksToBounds = true
        
        (cell.viewWithTag(5) as? UILabel)?.text = (data.contacts[indexPath.row] as! NSDictionary).valueForKey("name") as! String
        
        return cell
    }

    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == self.itemAmount) {
            self.newContact()
        } else {
            self.editContact(indexPath.row)
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
