# KDropDown
İOS Drop Down Menu Class 

![alt tag](https://user-images.githubusercontent.com/16580898/32702502-510c9c92-c7f9-11e7-9fc8-1696c04d35d2.png)

#### Use

```Swift
        dropView = KDropDown()
        dropView.backColor = UIColor.lightGray
        dropView.textColor = UIColor.white
        dropView.items = ["Profile","About","Info","Settings"]
        dropView.backgroundColor = UIColor(red: 93/255, green: 207/255, blue: 1, alpha: 1)
        dropView.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 3, width: 200, height: 40)
        view.addSubview(dropView)
```

###### Get Val

```Swift
        dropView.values // (String,Int)
```

## License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.
