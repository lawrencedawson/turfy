//
//  AllMessagesViewController.swift
//  Turfy
//
//  Created by Joseph Huang on 31/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import Firebase

class AllMessagesViewController: UITableViewController {
    
    let inboxRef = FIRDatabase.database().reference().child("messages").child((FIRAuth.auth()?.currentUser?.uid)!)
    var messages: [Message] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        inboxRef.observe(.value, with: { snapshot in
            print("This is the snapshot \(snapshot.value)")
            var newMessages: [Message] = []
            for allMessages in snapshot.children{
                let message = Message(snapshot: allMessages as! FIRDataSnapshot)
                newMessages.append(message)

            }
            print(self.messages)
            self.messages = newMessages
            self.tableView.reloadData()
        })



        
       // inboxRef.observe(.childAdded, with: { snapshot in
            // 2
         //   var newMessages: [Message] = []
            
            // 3
           // let message = Message(snapshot: snapshot)
            //newMessages.append(message)
            //for text in snapshot.children {
                
//                let message = Message(snapshot: messages as! FIRDataSnapshot)
            //}
            
            // 5
            
            //self.messages = newMessages
            //self.tableView.reloadData()
            
        //})

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
    "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
    "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
    "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
    "Pear", "Pineapple", "Raspberry", "Strawberry"]
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)


        cell.textLabel?.text = messages[indexPath.row].text
        cell.detailTextLabel?.text = messages[indexPath.row].sender

        
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}