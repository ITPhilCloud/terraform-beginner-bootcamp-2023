# ShortDoc - How to create a Feature Branch

To create a new feature branch:

- Create an issue in Github

![Screenshot of GitHub issue menu.](/images/Issues1.png)

- Select the New Issue button

![Screenshot of GitHub New Issue Button](/images/Issues2.png)

- Complete the title, enter a comment, and select the Submit new issue button.

![Screenshot of GitHub New Issue Button](/images/Issues3.png)

- The issue should now be displayed. Note the issue number.

![Screenshot of new GitHub issue](/images/Issues4.png)

- include the issue number in the command to checkout the branch, for exmaple:


Continue here ---

```bash
git checkout -b 1_semantic_versioning
```

- Push the new branch to Git

git push

- if an error message occurs, for example:

fatal: The current branch 1_semantic_versioning has no upstream branch. 
To push the current branch and set the remote as upstream, use

git push --set-upstream origin 1_semantic_versioning

enter the suggested command.

- The branch should now be visible expand Main menu in Github.

