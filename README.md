# folderTree
A powershell script to output the folder/file structure of your CWD such that you can let GPT4 help you write code better since it understands your project structure.

# Usage:
Add to path first if you want to run from anywhere on your computer.



Run like this:

```
folderTree

folderTree -excl "node_modules", "dist"

folderTree -foldersOnly

folderTree -foldersOnly -excl "node_modules", "dist"
```