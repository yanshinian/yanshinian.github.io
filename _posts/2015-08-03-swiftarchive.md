---
layout: post
title:  "swif归档"
category: swift
date:   2015-08-03
---
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