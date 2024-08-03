# Git Project
## Project Setup
-   Set Up Git: Configure your Git username and email:

![alt text](day2-pics-1/img.png)

-   Clone the repository to your local machine:

![alt text](day2-pics-1/img2.png)

-   Initialize the Project:
Navigate to the project directory:

```
cd website-project
```
-   Create initial project structure:

```
mkdir src
touch src/index.html
echo "<!DOCTYPE html><html><head><title>My Website</title></head><body><h1>Welcome to my website!</h1></body></html>" > src/index.html

```

-   Commit and push the initial project structure:

```
git add .
git commit -m "Initial commit: Added project structure and index.html"
git push origin main

```
![alt text](day2-pics-1/image.png)

### Exercise 1: Branching and Basic Operations (10 minutes)
-   Create a New Branch:
```
git checkout -b feature/add-about-page
```
-   Add a New Page:
Create about.html:
```
touch src/about.html
echo "<!DOCTYPE html><html><head><title>About Us</title></head><body><h1>About Us</h1></body></html>" > src/about.html
```
```
git add src/about.html
git commit -m "Added about page"
git push origin feature/add-about-page
```

![alt text](day2-pics-1/image-1.png)

### Exercise 2: Merging and Handling Merge Conflicts (15 minutes)
Create Another Branch:

```
git checkout main
git checkout -b feature/update-homepage
```
-   Update the Homepage:
Modify index.html:
```
echo "<p>Updated homepage content</p>" >> src/index.html
```
-   Commit and push changes:
```
git add src/index.html
git commit -m "Updated homepage content"
git push origin feature/update-homepage
```
![alt text](day2-pics-1/image-2.png)

-   Create a Merge Conflict:
Modify index.html on the feature/add-about-page branch:

```
git checkout feature/add-about-page
echo "<p>Conflict content</p>" >> src/index.html
git add src/index.html
git commit -m "Added conflicting content to homepage"
git push origin feature/add-about-page
```
![alt text](day2-pics-1/image-3.png)

-   Merge and Resolve Conflict:
Attempt to merge feature/add-about-page into main:

```
git checkout main
git merge feature/add-about-page
```

![alt text](day2-pics-1/image-4.png)

-   Resolve the conflict in src/index.html, then:

```
git add src/index.html
git commit -m "Resolved merge conflict in homepage"
git push origin main
```
![alt text](day2-pics-1/image-5.png)

### Exercise 3: Rebasing 

-   Rebase a Branch:
Rebase feature/update-homepage onto main:

```
git checkout feature/update-homepage
git rebase main
```

-   Resolve any conflicts that arise during rebase.
Push the Rebased Branch:

```
git push -f origin feature/update-homepage
```

### Exercise 4: Pulling and Collaboration 
-   Pull Changes from Remote:
Ensure the main branch is up-to-date:

```
git checkout main
git pull origin main
```
-   Make a change on GitHub directly (e.g., edit index.html).
Pull Collaborator's Changes:
Pull the changes made by the collaborator:

```
git pull origin main
```

![alt text](day2-pics-1/image-6.png)

### Exercise 5: Versioning and Rollback 

-   Tagging a Version:
Tag the current commit as v1.0:

```
git tag -a v1.0 -m "Version 1.0: Initial release"
git push origin v1.0
```
![alt text](day2-pics-1/image-7.png)

-   Make a Change that Needs Reversion:
Modify index.html:

```
echo "<p>Incorrect update</p>" >> src/index.html
git add src/index.html
git commit -m "Incorrect update"
git push origin main
```

-   Revert to a Previous Version:
Use git revert to undo the last commit:

```
git revert HEAD
git push origin main
```
![alt text](day2-pics-1/image-8.png)

![alt text](day2-pics-1/image-9.png)