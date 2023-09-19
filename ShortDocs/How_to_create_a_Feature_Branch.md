# ShortDoc - How to create a Feature Branch

To create a new feature branch:

- Create an issue in Github

![Screenshot of GitHub issue menu.](/images/Issues1.png)

- Select the New issue button

![Screenshot of GitHub New Issue Button](/images/Issues2.png)

- Complete the title, enter a comment, and select the Submit new issue button.

![Screenshot of GitHub New Issue Button](/images/Issues3.png)

- The issue should now be displayed. Note the issue number.

![Screenshot of new GitHub issue](/images/Issues4.png)

- include the issue number in the command to checkout the branch, for exmaple:

```bash
git checkout -b 1_semantic_versioning
```

- Push the new branch to Git

```bash
git push
```

- if an error message occurs, for example:

```bash
fatal: The current branch 1_semantic_versioning has no upstream branch. 
To push the current branch and set the remote as upstream, use

git push --set-upstream origin 1_semantic_versioning
```

enter the command as suggested.

- The branch should now be visible in the main menu.

![Screenshot of new branch in GitHub](/images/Issues5.png)



> **Tagging** [^1]
> 
> Like most VCSs, Git has the ability to tag specific points in a repository’s history as being important. Typically, people use this functionality to mark release points (v1.0, v2.0 and so on).
> 
> - *Creating Tags* Git supports two types of tags: lightweight and annotated.
> - A *lightweight tag* is very much like a branch that doesn’t change — it’s just a pointer to a specific commit.
>
> - *Annotated tags*, however, are stored as full objects in the Git database. They’re checksummed; contain the tagger name, email, and date; have a tagging message; and can be signed and
> verified with GNU Privacy Guard (GPG). It’s generally recommended that you create annotated tags so you can have all this information.



## References

[^1]: [Git Basics - Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
