# Contributing to XSLT Blender

This project is a spinoff of a spinoff ([OSCAL Tools](http://pages.nist.gov/oscal-tools)). It currently has no formal organization and no immediate plans for formal organization beyond this repository presence. All code is being placed in the public domain in order to make it free to use.

Note that in view of the possibility that it may receive public contributions, and in the hope and expectation that users and contributors all find themselves to be welcome to participate in its development, this site also has a [Code of Conduct](CODE_OF_CONDUCT.md).

## PRs and code

The easiest way to contribute to the code base is in a fork under your own control. This can serve as a platform for demonstration as well as development. You can use and benefit from your fork, and decide separately whether to contribute it to this (or any) common codebase.

PRs nicely squashed can be accepted into the `main` branch from feature and bugfix branches.

## Site maintenance steps

The demonstration site (portal) is maintained by pulling `main` into `nist-pages` (step one) and then merging the PR (commit) back into `main` in circular fashion (step two).

As site admin, after updating `nist-pages`, to complete this loop pull `origin nist-pages` down into a local copy of `main` (assuming `origin` is the remote repo); then push back up to `origin main`.

You ought to be able to do the same on any fork, substituting for `origin` as appropriate.

## Issues, feature requests, ideas and bug reports

Please use Issues on this site or contact us through the [OSCAL Project](http://pages.nist.gov/OSCAL).
