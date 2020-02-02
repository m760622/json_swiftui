//
//  MenuView.swift
//  vapor_swiftui
//
//  Created by Дмитрий on 30.01.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import SwiftUI


class HeroObj: Identifiable, ObservableObject{
    
    let id: Int
    let name: String
    let address: String
    
    init(his_id: Int, his_Name: String, his_url: String) {
        id = his_id
        name = his_Name
        address = his_url
    }
    
}


func getPersoneFromApi () -> Array<HeroObj> {
    
   let heroesDB = CommonMethods.getInfoFromDB()
    
    if heroesDB.count != 0 {
         return heroesDB
    }
        
//    let firstHero =  [HeroObj(his_id: 0, his_Name: "Luk Skywalker", his_url: "https://swapi.co/api/people/1"),
//                     HeroObj(his_id: 1, his_Name: "R2D2", his_url: "https://swapi.co/api/people/3"),
//                     HeroObj(his_id: 2, his_Name: "C-3PO", his_url: "https://swapi.co/api/people/2"),
//                     HeroObj(his_id: 3, his_Name: "Leia Organa", his_url: "https://swapi.co/api/people/5"),
//                     HeroObj(his_id: 4, his_Name: "Han Solo", his_url: "https://swapi.co/api/people/14"),
//                     HeroObj(his_id: 5, his_Name: "Chewbacca", his_url: "https://swapi.co/api/people/13")
//        ]
//
    
   //let dqGetInfo = DispatchQueue.init(label: "getInfoAboutHeroes")
    
   // dqGetInfo.async {
        
        let json_decoder = JSONDecoder.init()
        
        for i in 1...9 {
           
            let urlString: String = "https://swapi.co/api/people/?page=" + String(i)
            
            do{
                let data = try Data.init(contentsOf: URL(string: urlString)!)
                let pageUsers = try! json_decoder.decode(HeroesPage.self, from: data)
                
                for hero in pageUsers.results {
                    CommonMethods.saveHero(hero: UserFromSW(name: hero.name, url: hero.url, films: hero.films))
                }
                
            } catch {
                break
            }
   
        }
    
    //    NotificationCenter.default.post(name: Notification.Name(rawValue: "InfoWasUpdated"), object: nil)
        
   // }
    
    
    return  CommonMethods.getInfoFromDB()
    
    
}

struct MenuView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }

    @State var letsSeeSomethingElse: Bool = false
    
    var aRray:Array<HeroObj> = getPersoneFromApi()
    
    var body: some View {
            List(aRray) { lineOfTable in
                VStack{
                    HStack{
                        
                        NavigationLink(destination: InfoObject(heroAdress: lineOfTable.address)) {
                            Text(lineOfTable.name)
                        }
                       
                        Text("(" + String(lineOfTable.id+1))
                        Text(" in ")
                        Text(String(self.aRray.count) + ")")
                        Spacer()
                    }
                }
                
            }
    }
    
}



struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct HeroesPage: Codable {
    
    let results: Array<UserFromSW>
    
}
