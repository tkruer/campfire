from modules.campfire import CampfireApp

def main():
    server = CampfireApp(port=3000, host='localhost')
    server.serve()

if __name__ == "__main__":
    main()


