# Vencord Tweaks

## Themes
All themes can be found within the `themes/` folder, some of which being simple tweaks to remove some annoying buttons and some more significant changes.

There are two main themes at the moment<br/>
- `quickCss.css` - This is my quickCss file in a uploaded version, expect this to change randomly and cause quite the bit of change to your clients apperance.

- `removeAnnoyances.css` - Its in the name mostly just removes annoying buttons from the chatbar, and some things like discovery which I never use.

## Custom Builds & User Plugins
This is a collection of my tweaks and scripts for Vencord. It is fairly simple and easy to use. You simply clone the repository and run the `install.sh` script. It will reinstall vencord with all plugins in plugins.map keeping them up to date. You can also customise the insides of vencord using the overrides folder. 

## Configuration
You can also add your own plugins to the plugins.map file. using the following format:
```
<override path>;<git url>;<repo path>
```

* Override Path - The path in the vencord build to place the plugin. Typically `src/userplugins/x_plugin`
* Git URL - The URL to clone the repo from. This can be a gitlab, github or any other git repo. (Most userplugins will point to a github link)
* Repo Path - The path in the repo to clone from. Mostly `/` to indicate the root of the repo.

## Requirements
* Git
* NodeJS*
* NPM*
* Pnpm*

*These are required for the vencord build process but the script may install them for you (if my code works).

## Platforms
This was built for Linux Mint 21.3 and has been tested on Ubuntu (20.04 i think) + Arch Linux. It should work on any debian based system. It may work on other systems but I have not tested it.<br/>

**Install methods:**<br/>
Unix: `install.sh` (If that fails try `sudo su --command="./install.sh"`)
