from campfire import campfire

fn main() raises:
    let pageHTML: FileHandle = open("index.html", "r")
    var cf = campfire.CampfireApp(
        port=8080, 
        host="localhost",
        pageContent=pageHTML.read()
    )
    cf.run()
