//
//  DatabaseHelper.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    static let shared = DatabaseHelper()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveLocalArticle(with item: ItemViewModel, image: UIImage) {
        let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: context) as! Article
        article.id = item.id
        article.image = image.pngData()
        article.date = item.dateCreated
        article.descriptionText = item.description
        article.title = item.title
        article.imgHref = item.thumbnailUrl

        do{
            try context.save()
            print("Article succesfully saved")
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    func tryToFetchArticle(with id: String) -> Data? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                return data.value(forKey: "image") as? Data
            }
        } catch {
            print("failed")
        }
        return nil
    }
    
    func getAllArticles() -> [Article] {
        var arr: [Article] = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")

        do {
            arr = try context.fetch(request) as! [Article]
        } catch {
            print(error)
        }

        return arr
    }
    
    func remove(id: String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        
        do {
            let test = try context.fetch(fetchRequest)
            
            let objToDelete = test[0] as! NSManagedObject
            context.delete(objToDelete)
            
            do {
                try context.save()
            } catch {
                print("Unable To Save Updates")
                return false
            }
            
        } catch {
            print("Unable To Delete")
            return false
        }
        
        return true
    }
    
}
