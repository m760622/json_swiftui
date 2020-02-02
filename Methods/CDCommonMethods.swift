import Foundation
import CoreData
import UIKit

class CommonMethods {
    
    
    static func getInfoFromDB () -> Array<HeroObj> {
        
        var arHeroes: Array<HeroObj> = []
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SWHeroes")
        
        
        do {
              if let result = try! context.fetch(request) as? [SWHeroes] {
                var id = 0
                  for i in result {
                    arHeroes.append(HeroObj(his_id: id, his_Name: i.name!, his_url: i.address!))
                    id += 1
                  }
              }
          }
       
        return arHeroes
    }
    
    
    
    
    
    static func saveHero (hero: UserFromSW) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SWHeroes")
        
        request.predicate = NSPredicate(format: "name == %@", argumentArray: [hero.name])
        
        do {
            if let result = try! context.fetch(request) as? [SWHeroes] {
                for i in result {
                    context.delete(i)
                }
            }
        }
        
        
        let heroNew = SWHeroes(entity: SWHeroes.entity(), insertInto: context)
        
        heroNew.name = hero.name
        heroNew.address = hero.url
        
        do {
            try context.save()
        } catch let e {
            print(e)
        }
        
    }
    
    
    
    
}
