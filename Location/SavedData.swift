import UIKit
import CoreData
import MapKit

class SavedData: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    var name = String()
    var latitude = Double()
    var longitude = Double()
    var date = NSDate()
    var coordinates = CLLocationCoordinate2D()
    var locations = [NSManagedObject]()
    var index = Int()
    
    var mapView: MKMapView! = MKMapView()
    
    convenience init(name:String, latitude:Double, longitude:Double, date:NSDate, index:Int) {
        self.init()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.index = index
    }
    
    func setVariables(name:String, latitude:Double, longitude:Double, date:NSDate){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
    
    func initialiseScreen(){
        self.view.backgroundColor = UIColor.whiteColor()
        
        //Map Initialisation
        mapView.mapType = .Standard
        mapView.frame = view.frame
        mapView.delegate = self
        coordinates.latitude = latitude
        coordinates.longitude = longitude
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: false)
        
        let ann = MKPointAnnotation()
        ann.coordinate = coordinates
        mapView.addAnnotation(ann)
        
        self.view.addSubview(mapView)
        
        //Maps button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-150,h: screenSize.height - 65,x: 300,y: 50,title: "Open in Maps",colour: 0x4CD964,radius: 5, s: #selector(SavedData.displayMapsApp)))
        
        //Navigation bar background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        //Navigation bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: name, leftTitle: "Back", leftS: #selector(SavedData.backButton), rightTitle: "Delete", rightS: #selector(SavedData.deleteButton)))
    }
    
    func displayMapsApp(){
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary:nil))
        mapItem.name = name
        mapItem.openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func deleteButton(){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Location")
        request.returnsObjectsAsFaults = false
        do {
            let incidents = try context.executeFetchRequest(request)
            context.deleteObject(incidents[index] as! NSManagedObject)
            try context.save()
            backButton()
        } catch {}
    }
    
    func backButton(){
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