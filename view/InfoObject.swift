
import SwiftUI

struct InfoObject: View {
    
    init(heroAdress: String) {
        adress = heroAdress
    }
    
    let adress: String //https://swapi.co/api/people/1
    let json_decoder = JSONDecoder.init()


    var body: some View {
        
        let hero: UserFromSW = getInfoFromJson()
        let films: Array<Film> = getFilmsFromHeroInfo (hero: hero)

        let stack = VStack{
            Text(hero.name)
            
            List(films, id: \.self){ film in
                VStack{
                    Text(String(film.title))
                }
            }
            Spacer()
        }
        
        return stack
    }
    
    func getInfoFromJson() -> UserFromSW {
        
        let data = try! Data.init(contentsOf: URL(string: adress)!)
        let user = try! json_decoder.decode(UserFromSW.self, from: data)
        
        return user
        
    }
    
    func getFilmsFromHeroInfo(hero: UserFromSW) -> Array<Film> {
        
        var films_hero: Array<Film> = []
        
        for iFilm in hero.films {
            let data = try! Data.init(contentsOf: URL(string: iFilm)!)
            let film = try! json_decoder.decode(Film.self, from: data)
            
            films_hero.append(film)
        }

        return films_hero
    }
}

struct InfoObject_Previews: PreviewProvider {
    static var previews: some View {
        InfoObject(heroAdress: "")
    }
}




struct UserFromSW: Codable {
    
    var name:   String
    var url:    String
    var films:  Array<String>
    
}


struct Film: Codable, Hashable{
    var title: String
    var episode_id: Int
    var release_date: String
}
