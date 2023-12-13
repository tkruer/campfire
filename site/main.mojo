from campfire import campfire    

fn main() raises:
    let pageHTML: FileHandle = open("index.html", "r")
    var cf = campfire.Campfire(
            port=8080, 
            pageContent=pageHTML.read()
        )
    cf.run()
