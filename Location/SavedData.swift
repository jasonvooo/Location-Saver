import UIKit

class SavedData: UIViewController{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.sharedApplication().statusBarFrame.size.height
            , width: screenSize.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Location Saver");
        let backItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:#selector(SaveMenu.backMain))
        navItem.leftBarButtonItem = backItem;
        navBar.setItems([navItem], animated: false);
        
    }

    
    
     
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
     
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
     
    func createButton(width:CGFloat,height:CGFloat,x:CGFloat,y:CGFloat,title:String,colour:UInt32,radius:CGFloat)-> UIButton{
        let button = UIButton(frame:CGRectMake(width, height, x, y))
        button.backgroundColor = UIColorFromHex(colour)
        button.setTitle(title, forState: UIControlState.Normal)
        button.layer.cornerRadius = radius
        
        return button
    }
}