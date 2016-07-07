import UIKit
import CoreData

class LoadMenu : UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    var tableView: UITableView = UITableView()
    var locations = [NSManagedObject]()
    
    func loadData(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Location")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            locations = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        self.tableView.reloadData()
    }
    
    func initialiseScreen(){
        self.view.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(TableCell.self, forCellReuseIdentifier: NSStringFromClass(TableCell))
        
        //TableView
        tableView = UITableView(frame: CGRectMake(0, shift+44, screenSize.width, screenSize.height-shift-44), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(TableCell.self, forCellReuseIdentifier: NSStringFromClass(TableCell))
        self.view.addSubview(self.tableView)
        
        
        //Navigation Bar Background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + shift))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        //Navigation Bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: "Location Saver", leftTitle: "Back", leftS: #selector(LoadMenu.backMain), rightTitle: "", rightS: nil));
        
        let statusBar = UIView(frame:CGRectMake(0,0,screenSize.width, 20))
        statusBar.backgroundColor = UIObject.UIColorFromHex(0x6DC067)
        self.view.addSubview(statusBar)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 70.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(TableCell), forIndexPath: indexPath) as! TableCell
        let location = locations[indexPath.row] as NSManagedObject
        let name = (location.valueForKey("name") as? String)!
        let date = (location.valueForKey("time") as? NSDate)!
        cell.setName(name)
        cell.setDate(date)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = locations[indexPath.row] as NSManagedObject
        let name = (location.valueForKey("name") as? String)!
        let latitude = (location.valueForKey("latitude") as? Double)!
        let longitude = (location.valueForKey("longitude") as? Double)!
        let date = (location.valueForKey("time") as? NSDate)!
        let index = indexPath.row as Int
        let savedData:SavedData = SavedData(name: name, latitude: latitude, longitude: longitude, date: date, index: index)
        self.presentViewController(savedData, animated: true, completion: nil)        
    }
    
    func backMain() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initialiseScreen()
    }
}
