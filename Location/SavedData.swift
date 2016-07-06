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
    
    var mapView: MKMapView! = MKMapView()
    
    convenience init(name:String, latitude:Double, longitude:Double, date:NSDate) {
        self.init()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
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
        var coordinates = CLLocationCoordinate2D()
        coordinates.latitude = latitude
        coordinates.longitude = longitude
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: false)
        self.view.addSubview(mapView)
        
        /*
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(date)
        let label4 = UILabel(frame:CGRectMake(200,400,100,100))
        label4.text = DateInFormat
        self.view.addSubview(label4)
         */
        
        //Maps button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-150,h: screenSize.height - 65,x: 300,y: 50,title: "Open in Maps",colour: 0x4CD964,radius: 5, s: #selector(SaveMenu.displaySaveOption)))
        
        //Navigation bar background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        //Navigation bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: name, leftTitle: "Back", leftS: #selector(SavedData.backButton)))
    }
    
    func backButton(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseScreen()
    }
}