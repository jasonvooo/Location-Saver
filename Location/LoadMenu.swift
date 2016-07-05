import UIKit

class LoadMenu : UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    
    var tableView: UITableView  =   UITableView()
    let animals : [String] = ["1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        tableView = UITableView(frame: CGRectMake(0, shift+44, screenSize.width-15, screenSize.height-shift-44), style: UITableViewStyle.Plain)
        //tableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height), style: UITableViewStyle.Plain)

        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.sharedApplication().statusBarFrame.size.height
            , width: screenSize.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Location Saver");
        let backItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:#selector(LoadMenu.backMain))
        navItem.leftBarButtonItem = backItem;
        navBar.setItems([navItem], animated: false);
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return animals.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = animals [indexPath.row]
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(animals[indexPath.row])
        
    }
    
    func backMain() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
