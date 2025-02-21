Gamecan be played [on itch.io](https://austingibb.itch.io/no-cause-for-concern-brackeys-2025).

# How to run our game using the Godot Editor
## Intro
Pssst you'll need to install git on your computer.
Here is a reasonable place to start: [git-scm.com link](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

-----
## Steps:

1. Git clone the repo:
```
git clone git@github.com:austingibb/BJST-Nothing-Can-Go-Wrong.git
```
2. Download the asset version for the commit you wish to run (for example the chungus-asset-versioned branch commit is b96a516, which uses AssetsV2.chungusbot in the google drive).
3. Move unzipped ```asset-V<version#>``` to the root level of the ```BJST-Nothing-Can-Go-Wrong``` folder cloned by git.
4. Rename ```assets-V<version#>``` to ```assets```
5. Install dialogic addon (for example [this link](https://github.com/dialogic-godot/dialogic/archive/refs/tags/2.0-alpha-16.zip) will download a zip file containing an addon folder). Move the addon folder to the root of this project.
6. Checkout target feature branch, e.g. ```git checkout null``` (for latest stable game branch do ```git checkout main```)
7. Hit play in Godot Editor
8. ????
9. Profit

------
------
------

# How to build our game for itch.io

-----
## Steps:

1. You'll need the export templates. What are those? I don't know. But ya need em. They require a few GB of disk space.
   <br/>
   a. In godot do: Editor (tab at top) -> Manage Export Templates
   <br/>
   b. Select "Official Github Releases mirror" in "Download From" drop-down. 
   c. Select "Download & Install" or some shit like that.
1. You're ready to export! Simply select: Project (tab at top) -> Export.
   <br/>
   a. A pop-up GUI will appear showing you the export options.
1. If it is empty, add a Web export.
   <br/>
   a. Change the export filename to simply be index.html for to match itch.io's expectations.
   <br/>
   b. Export to the /builds/web/ folder in the project directory (or wherever you want, like a ~/downloads/web folder).

1. Zip 'er up. Zip the web folder, you'll get a web.zip file. This is what you upload to itch.io****
1. Go to itch.io and use the GUI to create a new project, fill out paperwork, upload web.zip
1. Play the game on itch.io! You did it! 

## Video of building godot game for web
--------
https://www.youtube.com/watch?v=y_YAKzlEbxs
