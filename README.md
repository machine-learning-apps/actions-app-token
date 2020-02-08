![Actions Status](https://github.com/machine-learning-apps/actions-app-token/workflows/Tests/badge.svg)

# Impersonate Your GitHub App In A GitHub Action

This action helps you retrieve an authenticated app token with a GitHub app id and a app private key.  You can use this key inside an actions workflow instead of `GITHUB_TOKEN`, in cases where the `GITHUB_TOKEN` has restricted rights.

## Why Would You Do This?

For example, pull request events **from forked repositories** are hydrated with a `GITHUB_TOKEN` that has [read-only access](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows#pull-request-event-pull_request).  Unfortunately, this means that PRs opened from forks cannot use Actions like the [first-interaction Action](https://github.com/actions/first-interaction) that greets new contributors, because the token does not have authority to comment on the PR. 

# Usage

1. Register a GitHub App (or use an existing one you own), and install this app on your repos. No need to setup an endpoint or a webhook (you can put in fake urls for these) as you can use this app for the purposes of Action workflows only if you like.

2. Creation a workflow file in `.github/workflows/`

    See [action.yml](action.yml) for the api spec.

Example:

```yaml
steps:
- name: Get token
  id: get_token
  uses: machine-learning-apps/actions-app-token@master
  with:
    APP_PEM: ${{ secrets.APP_PEM }}
    APP_ID: ${{ secrets.APP_ID }}

# see https://github.com/actions/first-interaction
- name: greet new contributors
  uses: actions/first-interaction@v1
  with:
    repo-token: ${{ steps.get_token.outputs.app_token }} # instead of ${{ secrets.GITHUB_TOKEN }}
    pr-message: 'Message that will be displayed on users' first pr. Look, a `code block` for markdown.'
```

# License

The scripts and documentation in this project are released under the MIT License.

## Notes

This action is being actively used for [fastpages-chatops](https://github.com/apps/fastpages-chatops)
