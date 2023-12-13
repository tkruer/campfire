from campfire import campfire
import os 

fn main() raises:
    let pageIndex: FileHandle = open("index.html", "r")
    var cf = campfire.CampfireApp(
        port=8080, 
        host="localhost",
        pageContent=pageIndex.read(),
        pagePath="./pages",
    )
    cf.run()
