import UIKit

class SaveOption: UIViewController{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let carButton = createButton(screenSize.width/2-100,height: screenSize.height/6,x: 200,y: 50,title: "Car",colour: 0x34aadc,radius: 5)
        carButton.addTarget(self, action: #selector(SaveOption.saveLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(carButton)
        
        let resButton = createButton(screenSize.width/2-100, height: screenSize.height*2/6, x: 200, y: 50, title: "Restuarant", colour: 0x34aadc, radius: 5)
        resButton.addTarget(self, action: #selector(SaveOption.saveLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(resButton)
        
        let otherOptionButton = UITextField(frame:CGRectMake(screenSize.width/2-100, screenSize.height*3/6, 200, 50))
        otherOptionButton.backgroundColor = UIColorFromHex(0x34aadc)
        otherOptionButton.layer.cornerRadius = 5
        self.view.addSubview(otherOptionButton)

        let saveButton = createButton(screenSize.width/2-100, height: screenSize.height*4/6, x: 200, y: 50, title: "Save", colour: 0x34aadc, radius: 5)
        saveButton.addTarget(self, action: #selector(SaveOption.saveLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(saveButton)
        
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
    
    func saveLocation() {
        let alert = UIAlertController(title: "Saved", message: "Your location has been saved!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: backMain))
        self.presentViewController(alert, animated: true, completion:nil)
    }

    func backMain(alert: UIAlertAction!){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        for v in view.subviews{
            v.removeFromSuperview()
        }
    }
    
    func backScreen() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}