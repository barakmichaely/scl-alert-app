//
//  ReportCollection.swift
//  SCLAlert
//
//  Created by Barak M on 6/9/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit


class ReportCollection: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.collectionView?.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
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
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var v = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! UICollectionReusableView
        
        println(v.viewWithTag(2))
        
        if (indexPath.section == 1) {
            
            (v.viewWithTag(2) as? UILabel)?.text = "Sent Reports"
        }
        
//        if (kind == UICollectionElementKindSectionHeader) {
//            v = self.collectionView?.dequeueReusableSupplementaryViewOfKind("header", withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as! UICollectionReusableView
//        }
        
        return v
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 2
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("report", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 1
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var reportView = self.storyboard!.instantiateViewControllerWithIdentifier("reportView")! as! ReportView
        self.showViewController(reportView, sender: self)
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