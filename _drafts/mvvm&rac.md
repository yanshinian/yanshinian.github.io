
public class UIProgressView : UIView, NSCoding {
    
    public init(frame: CGRect)
    public init?(coder aDecoder: NSCoder)
    public convenience init(progressViewStyle style: UIProgressViewStyle) // sets the view height according to the style
    
    public var progressViewStyle: UIProgressViewStyle // default is UIProgressViewStyleDefault
    public var progress: Float // 0.0 .. 1.0, default is 0.0. values outside are pinned.
    @available(iOS 5.0, *)
    public var progressTintColor: UIColor?
    @available(iOS 5.0, *)
    public var trackTintColor: UIColor?
    @available(iOS 5.0, *)
    public var progressImage: UIImage?
    @available(iOS 5.0, *)
    public var trackImage: UIImage?
    
    @available(iOS 5.0, *)
    public func setProgress(progress: Float, animated: Bool)
    
    @available(iOS 9.0, *)
    public var observedProgress: NSProgress?
}

{"bannerList":[{"id":137,"imgUrl":"/upload/banner/20151103da4d3cc7-d0f2-4ee7-b9bb-7487ab12d566.png","remark":"banner to app","title":"banner to app","status":1,"code":"4","sort":1,"location":"www.baidu.com","color":"1"},{"id":135,"imgUrl":"/upload/banner/20151019c4394fce-bd86-4f84-ad47-9bd26489eebc.png","remark":"aaa","title":"新手标","status":1,"code":"4","sort":null,"location":"/novice/toDetail.do","color":""}],"plan":{"id":1,"maxAmount":10000.00,"minAmount":1.00,"rate":18.00,"deadline":5,"deadlineAttr":0,"updateTime":1444632645000,"status":1,"raiseTimeStart":1446687387732,"raiseTimeEnd":1447119387732},"userStatus":"noLogin","articleList":[{"createTime":1445226560000,"artiId":448,"title":"app公告部分"},{"createTime":1445226560000,"artiId":450,"title":"公告部分--111111"},{"createTime":1445226560000,"artiId":451,"title":"公告部分--222222"}],"cou":0}





参考链接：

《》