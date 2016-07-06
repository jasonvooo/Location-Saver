import UIKit
import CoreData

class SaveOption: UIViewController, UITextFieldDelegate{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    var sender:SaveMenu = SaveMenu()
    var locations = [NSManagedObject]()
    var latitude = Double()
    var longitude = Double()
    var carY:CGFloat = 0.0
    var resY:CGFloat = 0.0
    var storeY:CGFloat = 0.0
    var customY:CGFloat = 0.0
    var saveY:CGFloat = 0.0
    var otherOptionButton = UITextField()
    
    convenience init(sender: SaveMenu, latitude:Double, longitude:Double) {
        self.init()
        self.sender = sender
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func initialiseScreen(){
        self.view.backgroundColor = UIColor.whiteColor()
        
        //Car Button
        carY = screenSize.height*0.1718
        self.view.addSubview(UIObject.createButton(screenSize.width/2-150,h: carY,x: 300,y: 100,title: "Car",colour: 0x007AFF,radius: 5, s: #selector(SaveOption.saveLocation)))
        
        //Restaurant Button
        resY = screenSize.height*0.3049
        self.view.addSubview(UIObject.createButton(screenSize.width/2-150, h: resY, x: 300, y: 100, title: "Restuarant", colour: 0x007AFF, radius: 5, s:#selector(SaveOption.saveLocation)))
        
        //Store Button
        storeY = screenSize.height*0.4395
        self.view.addSubview(UIObject.createButton(screenSize.width/2-150, h: storeY, x: 300, y: 100, title: "Store", colour: 0x007AFF, radius: 5, s:#selector(SaveOption.saveLocation)))
        
        //Other option
        customY = screenSize.height*0.6996
        otherOptionButton = UITextField(frame:CGRectMake(screenSize.width/2-150, customY, 300, 69))
        otherOptionButton.backgroundColor = UIObject.UIColorFromHex(0x007AFF)
        otherOptionButton.layer.cornerRadius = 5
        otherOptionButton.textColor = UIColor.whiteColor()
        //otherOptionButton.placeholder = "Other"
        otherOptionButton.attributedPlaceholder = NSAttributedString(string:"Other", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        otherOptionButton.textAlignment = .Center
        self.view.addSubview(otherOptionButton)
        self.otherOptionButton.delegate = self
        self.otherOptionButton.returnKeyType = .Done
        
        
        //Save Button
        saveY = screenSize.height*0.8027
        self.view.addSubview(UIObject.createButton(screenSize.width/2-150,h: saveY,x: 300,y: 75, title: "Save", colour: 0x4CD964, radius: 5, s:#selector(SaveOption.saveLocation)))
    
        //Navigation bar background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        
        //Navigation bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: "Location Saver", leftTitle: "Cancel", leftS: #selector(SaveOption.backButton), rightTitle: "", rightS: nil))
        
        let statusBar = UIView(frame:CGRectMake(0,0,screenSize.width, 20))
        statusBar.backgroundColor = UIObject.UIColorFromHex(0x6DC067)
        self.view.addSubview(statusBar)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func saveLocation(sender:UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Location", inManagedObjectContext:managedContext)
        let location = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        if(Int(sender.frame.origin.y) == Int(carY)){
            location.setValue("Car", forKey: "name")
        }
        else if(Int(sender.frame.origin.y) == Int(resY)){
            location.setValue("Restaurant", forKey: "name")
        }
        else if(Int(sender.frame.origin.y) == Int(storeY)){
            location.setValue("Store", forKey: "name")
        }
        else if(Int(sender.frame.origin.y) == Int(saveY)){
            location.setValue(otherOptionButton.text, forKey: "name")
        }
        else{
            location.setValue("Default", forKey: "name")
        }
        
        location.setValue(latitude, forKey: "latitude")
        location.setValue(longitude, forKey: "longitude")
        location.setValue(NSDate(), forKey: "time")
        
        do {
            try managedContext.save()
            locations.append(location)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        let alert = UIAlertController(title: "Saved", message: "Your location has been saved!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: backMain))
        self.presentViewController(alert, animated: true, completion:nil)
    }
    
    func backButton(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func backMain(alert: UIAlertAction!){
        sender.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseScreen()
    }
    
}