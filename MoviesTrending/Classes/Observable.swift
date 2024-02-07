import Foundation

class Observable<T>{
    
    var value:T?{
        didSet{// here the listner is called when any changes occurs there
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener:((T?) ->Void)?//this is private listener which will listen the change and update that one
    
    func bind(_ listener:@escaping ((T?)->Void)){//here we will call the listener
        listener(value)
        self.listener=listener 
    }
}
