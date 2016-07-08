import UIKit
import CoreData

class SaveOption: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
    var container = UIView()
    var setting:String = ""
    var imagePicker = UIImagePickerController()
    var imageView: UIImageView!
    
    var categories = ["Car", "Restaurant", "Store", "Other"]
    var colours = [0x3B5998, 0xFF3B30, 0x4CD964, 0x898C90]
    var buttons = [UIButton(), UIButton(), UIButton(), UIButton()]
    
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
        name.attributedPlaceholder = NSAttributedString(string:"Name: Optional", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
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
        container.layer.cornerRadius = 5
        container.layer.borderColor = UIColor.lightGrayColor().CGColor
        container.layer.borderWidth = 1
        self.view.addSubview(container)
        
        //Category Buttons
        for i in 0...categories.count-1 {
            buttons[i] = UIObject.createButton(0,h: categoryHeight*CGFloat(i)-CGFloat(i)
                ,x: categoryWidth-categoryPadding,y: categoryHeight,title: categories[i],colour: 0xeeeeee,radius: 0, s: #selector(SaveOption.buttonSelected))
            buttons[i].layer.borderWidth = 1
            buttons[i].layer.borderColor = UIColor.lightGrayColor().CGColor
            buttons[i].setTitleColor(UIColor.blackColor(), forState: .Normal)
            if(i == 0 || i == categories.count-1){
                var maskPath:UIBezierPath
                if i == 0 {
                    maskPath = UIBezierPath(roundedRect: buttons[i].bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(10, 10))
                }
                else {
                    maskPath = UIBezierPath(roundedRect: buttons[i].bounds, byRoundingCorners: [.BottomLeft, .BottomRight], cornerRadii: CGSizeMake(10, 10))
                }
                let maskLayer = CAShapeLayer()
                maskLayer.frame = buttons[i].bounds
                maskLayer.path  = maskPath.CGPath
                buttons[i].layer.mask = maskLayer
            }
            container.addSubview(buttons[i])
        }
       
        //Image Button
        let imageButton = UIObject.createButton(categoryPadding, h: categoryPadding+64+70 + numOfCategories*categoryHeight + 20, x: categoryWidth-categoryPadding, y: categoryHeight*3, title: "Optional: Tap to add image", colour: 0xeeeeee, radius: 5, s:#selector(SaveOption.openImages))
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        imageButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        self.view.addSubview(imageButton)
        
        //Imageview
        imageView = UIImageView(frame:CGRectMake(categoryPadding, categoryPadding+64+70 + numOfCategories*categoryHeight + 20, categoryWidth-categoryPadding, categoryHeight*3))
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        //Save Button
        self.view.addSubview(UIObject.createButton(categoryPadding,h: screenSize.height-70,x: categoryWidth-categoryPadding,y: categoryHeight, title: "Save", colour: 0x4CD964, radius: 5, s:#selector(SaveOption.saveLocation)))
        
        //Navigation bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44+shift, x: 0, y:0, title: "Location Saver", leftTitle: "Cancel", leftS: #selector(SaveOption.backButton), rightTitle: "", rightS: nil))
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
        
        location.setValue(name.text!, forKey: "name")
        location.setValue(setting, forKey: "category")
        location.setValue(latitude, forKey: "latitude")
        location.setValue(longitude, forKey: "longitude")
        location.setValue(NSDate(), forKey: "time")
        if let img = imageView.image {
            location.setValue(UIImagePNGRepresentation(img), forKey:"image")
        }
        
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
        for i in 0...categories.count-1{
            if(Int(sender.frame.origin.y) == Int(categoryHeight*CGFloat(i)-CGFloat(i))){
                for j in 0...categories.count-1 {
                    if i == j {
                        buttons[j].backgroundColor = UIObject.UIColorFromHex(UInt32(colours[i]))
                    }
                    else { buttons[j].backgroundColor = UIObject.UIColorFromHex(0xeeeeee) }
                }
                setting = categories[i]
            }
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
    
    func openImages(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            imagePicker.allowsEditing = false
            imagePicker.navigationBar.translucent = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in })
        imageView.image = image
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        viewController.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        if(imagePicker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary){
            let button = UIBarButtonItem(title: "Camera", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SaveOption.showCamera))
            viewController.navigationItem.leftBarButtonItem = button
        }else{
            let button = UIBarButtonItem(title: "Photo Library", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SaveOption.choosePicture))
            viewController.navigationItem.leftBarButtonItem = button
        }
    }
    
    func showCamera(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
    }
    
    func choosePicture(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseScreen()
    }
    
}