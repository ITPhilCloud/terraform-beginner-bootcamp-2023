## ShortDoc - How to create a Feature Branch

To create a new feature branch:

- Create an issue with a title and description in github

![Screenshot of GitHub issue menu.](/images/Issues1.png)

- include the issue number in the branching command, for exmaple:

git checkout -b 1_semantic_versioning 

- Push the new branch to Git

git push

- if an error message occurs, for example:

fatal: The current branch 1_semantic_versioning has no upstream branch. 
To push the current branch and set the remote as upstream, use

git push --set-upstream origin 1_semantic_versioning

enter the suggested command.

- The branch should now be visible expand Main menu in Github.

