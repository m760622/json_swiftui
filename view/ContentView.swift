import SwiftUI

struct ContentView: View {
    
    let ava_image: UIImage = UIImage(named: "resistance.png") ?? UIImage()
    let tableView = UITableView()
    
    var body: some View {
        
        NavigationView{
            VStack{
                Image(uiImage: ava_image).resizable().aspectRatio(1, contentMode: .fit ).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/3).border(Color.red.opacity(0.5), width: 0.5).clipShape(Circle())
                    .shadow(radius: 10)
                
                Spacer()
                
                
                
                
                VStack{
                    HStack{
                        Text("mailto:").shadow(radius: 10)
                        Text(getEmailAddres()).underline().shadow(radius: 10).onTapGesture {
//                            if let mailURL = URL(string: "message://" + self.getEmailAddres()) {
//                                UIApplication.shared.open(mailURL)
//                            }
                        }
                        
                    }
                    MenuView()
                    Spacer()
                }
            }
            .navigationBarTitle(Text(" Hello Resistance "))
        }
        
    }
    
    func getEmailAddres () -> String{
        
        return "zimoykin@gmail.com"
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
