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
        self.tableView.reloadData()
    }
    
    func initialiseScreen(){
        self.view.backgroundColor = UIColor.whiteColor()
        
        //TableView
        tableView = UITableView(frame: CGRectMake(0, shift+44, screenSize.width, screenSize.height-shift-44), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        //Navigation Bar Background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + shift))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        //Navigation Bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: "Location Saver", leftTitle: "Back", leftS: #selector(LoadMenu.backMain), rightTitle: "", rightS: nil));
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 70.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let location = locations[indexPath.row] as NSManagedObject
        cell.textLabel!.text =  location.valueForKey("name") as? String
        return cell;
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initialiseScreen()
    }
}
