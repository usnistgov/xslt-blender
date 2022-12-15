[Describe the PR]

### Completeness checklist:

Within the scope of work,

- [ ] All readme files and documentation resources are current
- [ ] Everything touched has been double checked for parsing as appropriate (wf/valid)
- [ ] Everything is tested in multiple browsers (minimally: FF and Chrome)
- [ ] The top-level directory is current or planned for updating
- [ ] As appropriate, outbound external links are marked as `class="external"` (drives popup)

### PR/merge guidelines:

Despite its being a bit cumbersome with respect to commit history, we are using git in a 'safe' mode to avoid potential issues aligning the publication branch, `nist-pages`.

- Merging into `main`, squashing commits in a PR is okay (recommended)
- Don't merge anything into `nist-pages` except `main`, and *never squash* commits in those PRs
- The `main` branch also keeps up with `nist-pages` (merge commits), so after committing to `nist-pages`, pulling back is necessary
