import UIKit
import MapKit

class SaveMenu : UIViewController{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let test = createButton(screenSize.width/2-50,height: screenSize.height/2+100,x: 100,y: 50,title: "Save",colour: 0x34aadc,radius: 5)
        test.addTarget(self, action: #selector(SaveMenu.saveLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(test)
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.sharedApplication().statusBarFrame.size.height
            , width: screenSize.width, height: 20))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Location Saver");
        let backItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
        navItem.leftBarButtonItem = backItem;
        navBar.setItems([navItem], animated: false);

    }
    //UI colour from hex
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    //Universal button creator to simplify code
    func createButton(width:CGFloat,height:CGFloat,x:CGFloat,y:CGFloat,title:String,colour:UInt32,radius:CGFloat)-> UIButton{
        let button = UIButton(frame:CGRectMake(width, height, x, y))
        button.backgroundColor = UIColorFromHex(colour)
        button.setTitle(title, forState: UIControlState.Normal)
        button.layer.cornerRadius = radius
        return button
    }
    
    func saveLocation() {
        let alert = UIAlertController(title: "Saved", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func backMain() {
    }

}
