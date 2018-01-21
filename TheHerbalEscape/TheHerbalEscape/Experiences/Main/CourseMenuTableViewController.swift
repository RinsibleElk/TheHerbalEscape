//
//  CourseMenuTableViewController.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 31/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit

class CourseMenuTableViewController: UITableViewController {
    // MARK: - Properties
    var progress: OverallProgressSummary?
    var menuTitle: String!
    var selectionSegueIdentifier: String!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "wavy"))
        title = menuTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progress?.Courses.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.FlashcardMenuItemReuseIdentifier, for: indexPath) as! CourseMenuTableViewCell
        let course = progress!.Courses[indexPath.row]
        
        // Configure the cell...
        cell.course = course
        cell.progress = progress!.getProgress(course: course)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: selectionSegueIdentifier, sender: self)
    }
}
