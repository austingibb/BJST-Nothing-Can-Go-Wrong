# How to run our game using the Godot Editor

Pssst you'll need to install git on your computer.
Here is a reasonable place to start: [git-scm.com link](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

-----

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
