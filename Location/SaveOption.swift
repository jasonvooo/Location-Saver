import UIKit
import CoreData

class SaveOption: UIViewController, UITextFieldDelegate{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    var sender:SaveMenu = SaveMenu()
    var locations = [NSManagedObject]()
    var latitude = Double()
    var longitude = Double()
    var name = UITextField()
    let numOfCategories:CGFloat = 4.0
    var categoryWidth = CGFloat()
    var categoryHeight = CGFloat()
    let categoryPadding:CGFloat = 30.0
    var car = UIButton()
    var restaurant = UIButton()
    var store = UIButton()
    var other = UIButton()
    var container = UIView()
    var setting:String = ""
    
    convenience init(sender: SaveMenu, latitude:Double, longitude:Double) {
        self.init()
        self.sender = sender
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func initialiseScreen(){
        self.view.backgroundColor = UIColor.whiteColor()
        categoryHeight = screenSize.height/12
        categoryWidth = screenSize.width-30
        
        //Name field
        let nameBox = UIView(frame:CGRectMake(categoryPadding,categoryPadding+59, categoryWidth-categoryPadding, 40))
        nameBox.layer.borderWidth = 1
        nameBox.layer.borderColor = UIColor.lightGrayColor().CGColor
        nameBox.layer.cornerRadius = 10
        self.view.addSubview(nameBox)
        
        name = UITextField(frame:CGRectMake(15,0, categoryWidth-categoryPadding-30, 40))
        name.backgroundColor = UIObject.UIColorFromHex(0xffffff)
        name.textColor = UIColor.blackColor()
        name.attributedPlaceholder = NSAttributedString(string:"Name: Optional", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        name.textAlignment = .Left
        nameBox.addSubview(name)
        self.name.delegate = self
        self.name.returnKeyType = .Done
        
        
        //Select category text
        let text = UILabel(frame:CGRectMake(categoryPadding,categoryPadding+59 + 40, categoryWidth-categoryPadding, 45))
        text.textAlignment = .Center
        text.text = "Select a category"
        self.view.addSubview(text)
        
        //Category container
        container = UIView(frame:CGRectMake(categoryPadding,categoryPadding+64+70, categoryWidth-categoryPadding, numOfCategories*categoryHeight-3))
        //container.backgroundColor = UIColor.redColor()
        container.layer.cornerRadius = 5
        container.layer.borderColor = UIColor.lightGrayColor().CGColor
        container.layer.borderWidth = 1
        self.view.addSubview(container)
        
        //Car Button
        car = UIObject.createButton(0,h: 0,x: categoryWidth-categoryPadding,y: categoryHeight,title: "Car",colour: 0xeeeeee,radius: 0, s: #selector(SaveOption.buttonSelected))
        car.layer.borderWidth = 1
        car.layer.borderColor = UIColor.lightGrayColor().CGColor
        let maskPath = UIBezierPath(roundedRect: car.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(10, 10))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = car.bounds
        maskLayer.path  = maskPath.CGPath
        car.layer.mask = maskLayer
        car.setTitleColor(UIColor.blackColor(), forState: .Normal)
        container.addSubview(car)
        
        //Restaurant Button
        restaurant = UIObject.createButton(0, h: categoryHeight*1-1, x: categoryWidth-categoryPadding, y: categoryHeight, title: "Restaurant", colour: 0xeeeeee, radius: 0, s:#selector(SaveOption.buttonSelected))
        restaurant.layer.borderWidth = 1
        restaurant.layer.borderColor = UIColor.lightGrayColor().CGColor
        restaurant.setTitleColor(UIColor.blackColor(), forState: .Normal)
        container.addSubview(restaurant)
       
        //Store Button
        store = UIObject.createButton(0, h: categoryHeight*2-2, x: categoryWidth-categoryPadding, y: categoryHeight, title: "Store", colour: 0xeeeeee, radius: 0, s:#selector(SaveOption.buttonSelected))
        store.layer.borderWidth = 1
        store.layer.borderColor = UIColor.lightGrayColor().CGColor
        store.setTitleColor(UIColor.blackColor(), forState: .Normal)
        container.addSubview(store)
        
        //Other option
        other = UIObject.createButton(0, h: categoryHeight*3-3, x: categoryWidth-categoryPadding, y: categoryHeight, title: "Other", colour: 0xeeeeee, radius: 0, s:#selector(SaveOption.buttonSelected))
        other.layer.borderWidth = 1
        other.layer.borderColor = UIColor.lightGrayColor().CGColor
        let maskPath2 = UIBezierPath(roundedRect: other.bounds, byRoundingCorners: [.BottomLeft, .BottomRight], cornerRadii: CGSizeMake(5, 5))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.frame = other.bounds
        maskLayer2.path  = maskPath2.CGPath
        other.layer.mask = maskLayer2
        other.setTitleColor(UIColor.blackColor(), forState: .Normal)
        container.addSubview(other)
        
        //Image Button
        let imageButton = UIObject.createButton(categoryPadding, h: categoryPadding+64+70 + numOfCategories*categoryHeight + 20, x: categoryWidth-categoryPadding, y: categoryHeight*3, title: "Optional: Tap to add image", colour: 0xeeeeee, radius: 5, s:#selector(SaveOption.saveLocation))
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        imageButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        self.view.addSubview(imageButton)
        
        //Save Button
        //saveY = screenSize.height*0.8027
        self.view.addSubview(UIObject.createButton(categoryPadding,h: screenSize.height-70,x: categoryWidth-categoryPadding,y: categoryHeight, title: "Save", colour: 0x4CD964, radius: 5, s:#selector(SaveOption.saveLocation)))
    
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
    
    func buttonSelected(sender:UIButton){
        print(sender.frame.origin.y)
        print(categoryHeight*0)
        
        
        
        if(Int(sender.frame.origin.y) == Int(categoryHeight*0)){
            car.backgroundColor = UIObject.UIColorFromHex(0x3B5998)
            restaurant.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            store.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            other.backgroundColor = UIObject.UIColorFromHex(0xffffff)
        }
        else if(Int(sender.frame.origin.y) == Int(categoryHeight*1+container.frame.origin.y)){
            car.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            restaurant.backgroundColor = UIObject.UIColorFromHex(0x3B5998)
            store.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            other.backgroundColor = UIObject.UIColorFromHex(0xffffff)
        }
        else if(Int(sender.frame.origin.y) == Int(categoryHeight*2+container.frame.origin.y)){
            car.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            restaurant.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            store.backgroundColor = UIObject.UIColorFromHex(0x3B5998)
            other.backgroundColor = UIObject.UIColorFromHex(0xffffff)
        }
        else if(Int(sender.frame.origin.y) == Int(categoryHeight*3+container.frame.origin.y)){
            car.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            restaurant.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            store.backgroundColor = UIObject.UIColorFromHex(0xffffff)
            other.backgroundColor = UIObject.UIColorFromHex(0x3B5998)
        }
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