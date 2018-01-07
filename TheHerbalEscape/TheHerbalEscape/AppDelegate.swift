//
//  AppDelegate.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 24/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var progressController: ProgressController?
    var contentRepository = ContentRepository()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Hack in some dummy content for now.
        let plantsUrl = DataManager.urlForResource("LevelOne", "plants", "json")
        let herbalActionsUrl = DataManager.urlForResource("Global", "actions", "json")
        let herbalFamiliesUrl = DataManager.urlForResource("Global", "herbalfamilies", "json")
        let questionsUrl = DataManager.urlForResource("LevelOne", "questions", "json")
        let coursesUrl = DataManager.urlForResource("LevelOne", "courses", "json")
        DataManager.getContents(coursesUrl) { (data, error) in
            if let data = data {
                let courses = CourseContents.decodeFromJSON(jsonData: data)
                for course in courses {
                    self.contentRepository.Courses[course.Name] = course
                }
            }
        }
        var remaining = 4
        DataManager.getContents(plantsUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let plants = PlantContents.decodeFromJSON(jsonData: data)
                for plant in plants {
                    self.contentRepository.Browsables.append(plant)
                    self.contentRepository.Contents[plant.contentKey] = plant
                }
            }
            if (remaining == 0) {
                self.loadData()
            }
        }
        DataManager.getContents(herbalActionsUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let actions = HerbalActionContents.decodeFromJSON(jsonData: data)
                for action in actions {
                    self.contentRepository.Browsables.append(action)
                    self.contentRepository.Contents[action.contentKey] = action
                }
            }
            if (remaining == 0) {
                self.loadData()
            }
        }
        DataManager.getContents(herbalFamiliesUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let families = HerbalFamilyContents.decodeFromJSON(jsonData: data)
                for family in families {
                    self.contentRepository.Browsables.append(family)
                    self.contentRepository.Contents[family.contentKey] = family
                }
            }
            if (remaining == 0) {
                self.loadData()
            }
        }
        DataManager.getContents(questionsUrl) { (data, error) in
            remaining = remaining - 1
            if let data = data {
                let questions = QuestionContents.decodeFromJSON(jsonData: data)
                for question in questions {
                    self.contentRepository.Questions[question.Name] = question
                }
            }
            if (remaining == 0) {
                self.loadData()
            }
        }

        // Initialize the DataController.
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        progressController = ProgressController(moc: persistentContainer.viewContext)
        if (remaining == 0) {
            self.loadData()
        }

//        for font in UIFont.familyNames {
//            print("* \(font)")
//            for fontName in UIFont.fontNames(forFamilyName: font) {
//                print("  - \(fontName)")
//            }
//        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TheHerbalEscape")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Loading progress data on first run
    private func loadData() {
        if progressController != nil {
            let progress = progressController!.fetchProgress(course: nil)
            if progress.count == 0 {
                progressController!.loadInitialData(contentRepository: contentRepository)
            }
        }
    }
}

