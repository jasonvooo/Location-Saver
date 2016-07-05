import UIKit
import CoreData

class SavedData: UIViewController{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    var name = String()
    
    convenience init( name:  String) {
        self.init()
        self.name = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let label = UILabel(frame:CGRectMake(100,100,100,100))
        label.text = name
        self.view.addSubview(label)
        
        //Navigation bar background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        //Navigation bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: "Location Saver", leftTitle: "Back", leftS: #selector(SavedData.backButton)))
    }
    
    func backButton(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}