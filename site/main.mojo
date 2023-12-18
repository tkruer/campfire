from campfire import campfire
import os 

fn main() raises:
    let pageIndex: FileHandle = open("index.html", "r")
    var cf = campfire.CampfireApp(
        port=10000, 
        host="0.0.0.0",
        pageContent=pageIndex.read(),
        pagePath="./pages",
    )
    cf.run()
