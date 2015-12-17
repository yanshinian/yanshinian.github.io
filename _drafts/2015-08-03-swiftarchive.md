---
layout: post
title:  "swift2.0，1.2归档"
category: swift
date:   2015-08-03
---All you have is a blank screen with two bar buttons on top: the left one shows the NASA image credits and the right one invokes the method that shows or hides the gallery as appropriate.First, you’ll need to display all images on the screen and set them up so they’re ready for your “fan” animation.
开发环境：xcode7beta5,swift 2.0

代码；
```
class Member: NSObject, NSCoding  {
    /** 用户id **/
    var uid: String?
    /** 用户 昵称 **/
    var userName: String?
    var CoreLockPWDKey: String?
    static private let filePath = All you have is a blank screen with two bar buttons on top: the left one shows the NASA image credits and the right one invokes the method that shows or hides the gallery as appropriate.First, you’ll need to display all images on the screen and set them up so they’re ready for your “fan” animation.(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("member.plist")
    // MRAK: - 归档那的操作
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(userName, forKey: "userName")
    }
    // MRAK: - 解档的操作
    required init?(coder aDecoder: NSCoder ) {
        aDecoder.decodeObjectForKey("uid") as! String
        aDecoder.decodeObjectForKey("userName") as! String
    }
    func saveMember() {
        NSKeyedArchiver.archiveRootObject(self, toFile: Member.filePath)
    }
    func member()->Member {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Member.filePath) as! Member
    }
    
}
```


开发环境：xcode6.3,swift 1.2

代码：

```
import Foundation

class Person : NSObject,NSCoding {
    var name : String?
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name");
    }
    override init() {
    }
    required  init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
    }
    func save() {
        let home = NSHomeDirectory();
        
        let docPath = home.stringByAppendingPathComponent("Documents");
        let filePath = docPath.stringByAppendingPathComponent("person.archive");
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath);
    }
    func read()->Person {
        let home = NSHomeDirectory();
        let docPath = home.stringByAppendingPathComponent("Documents");
        let filePath = docPath.stringByAppendingPathComponent("person.archive");
        return NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! Person;
    }
}
```

调用：

```
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let person = Person();
        person.name = "言十年";
        person.save();
        let person2 = person.read();
        println(person2.name!);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
```

参考资料：

* 《Swift与Cocoa框架开发》

* 《Swift之沙盒与数据存储》<http://www.helloswift.com.cn/swiftmanual/2015/0208/3486.html>