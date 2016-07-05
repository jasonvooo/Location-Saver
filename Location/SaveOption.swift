import UIKit
import CoreData

class SaveOption: UIViewController{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    var sender:SaveMenu = SaveMenu()
    var locations = [NSManagedObject]()
    var latitude = Double()
    var longitude = Double()
    
    convenience init(sender: SaveMenu, latitude:Double, longitude:Double) {
        self.init()
        self.sender = sender
        self.latitude = latitude
        self.longitude = longitude
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //Car Button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-100,h: screenSize.height/6,x: 200,y: 50,title: "Car",colour: 0x34aadc,radius: 5, s: #selector(SaveOption.saveLocation)))
        
        //Restaurant Button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-100, h: screenSize.height*2/6, x: 200, y: 50, title: "Restuarant", colour: 0x34aadc, radius: 5, s:#selector(SaveOption.saveLocation)))
        
        //Other option
        let otherOptionButton = UITextField(frame:CGRectMake(screenSize.width/2-100, screenSize.height*3/6, 200, 50))
        otherOptionButton.backgroundColor = UIColor.blueColor()
        otherOptionButton.layer.cornerRadius = 5
        self.view.addSubview(otherOptionButton)

        //Create Button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-100, h: screenSize.height*4/6, x: 200, y: 50, title: "Save", colour: 0x34aadc, radius: 5, s:#selector(SaveOption.saveLocation)))
        
        //Navigation bar background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        
        //Navigation bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: "Location Saver", leftTitle: "Cancel", leftS: #selector(SaveOption.backButton)))

    }
    
    func saveLocation() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Location", inManagedObjectContext:managedContext)
        let location = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    
        location.setValue("Car", forKey: "name")
        location.setValue(15, forKey: "latitude")
        location.setValue(18, forKey: "longitude")
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
    
}