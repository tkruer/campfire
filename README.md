<div style="display: flex; justify-content: center;">
    <img src="./docs/campfire.png" width="300" height="300">
</div>

# Campfire
A web framework for the Mojo programming language 🔥

## Usage

1. There's no package manager nor really is this ready to be used in ANY project. It's really a demonstration of using Mojo with Python's `http.server` module and interoperating with it. I'm going to try to get this to work with Render and see if I can get it to work with a Docker container later this weekend. That being said, if you want to try it out, here's how:

- Install Mojo from [Modular](https://www.modular.com) ↗️

- Ensure you have Python 3.10+ installed on your machine [Python](https://www.python.org/downloads/) ↗️

- Clone this repo and cd to `/site` to see an example of how to use this framework

```bash
git clone https://tkruer/campfire && cd campfire/site
```

- Run the server with the following and view the site in your browser at `localhost:8000`

```bash
mojo main.mojo
```

## Notes and Caveats

- I totally don't recommend using this yet! This is a proof of concept and I'm still working on it!
- There's no package manager yet??
- This is totally not production ready - let alone even ready to be used in a project!
- I wasted about 5 hours today trying to get this to deploy on Render in a Docker container
- If you want to build on top of this - go for it! I'd love to see what you make!
- I'm going to try again tomorrow, it's 50% a skill issue and 50% a software issue
