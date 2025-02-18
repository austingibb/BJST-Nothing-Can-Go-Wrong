# How to run our game using the Godot Editor

Pssst you'll need to install git on your computer. Google it :)
Here is a reasonable place to start: [git-scm.com link](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

-----

1. Git clone the repo:
```
git clone git@github.com:austingibb/BJST-Nothing-Can-Go-Wrong.git
```
2. Download the asset version for the commit you wish to run (for example the rangshada branch commit is 2418bc5ed756df29ae769db7f8d5a5c0f9a8487b, which uses assets-V1 in the google drive).
3. Move unzipped ```asset-V<version#>``` to the root level of the ```BJST-Nothing-Can-Go-Wrong``` folder cloned by git.
4. Rename ```assets-V<version#>``` to ```assets```
5. Install dialogic addon? (@austingibb here: I haven't done this yet but I assume it's pretty straightforward. Ask null).
6. Checkout target feature branch, e.g. ```git checkout null``` (for latest stable game branch do ```git checkout main```)
7. Hit play in Godot Editor
8. ????
9. Profit