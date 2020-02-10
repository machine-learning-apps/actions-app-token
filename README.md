![Actions Status](https://github.com/machine-learning-apps/actions-app-token/workflows/Tests/badge.svg)

# Impersonate Your GitHub App In A GitHub Action

This action helps you retrieve an authenticated app token with a GitHub app id and a app private key.  You can use this key inside an actions workflow instead of `GITHUB_TOKEN`, in cases where the `GITHUB_TOKEN` has restricted rights.

## Why Would You Do This?


Actions have certain limitations.  Many of these limitations are for security and stability reasons, however not all of them are.  Some examples where you might want to impersonate a GitHub App temporarily in your workflow:

- You want an [event to trigger a workflow](https://help.github.com/en/articles/events-that-trigger-workflows) on a specific ref or branch in a way that is not natively supported by Actions.  For example, a pull request comment fires the [issue_comment event](https://help.github.com/en/articles/events-that-trigger-workflows#issue-comment-event-issue_comment) which is sent to the default branch and not the PR's branch.  You can temporarily impersonate a GitHub App to make an event, such as a [label a pull_request](https://help.github.com/en/articles/events-that-trigger-workflows#pull-request-event-pull_request) to trigger a workflow on the right branch. This takes advantage of the fact that Actions cannot create events that trigger workflows, however other Apps can. 

# Usage

1. If you do not already own a GitHub App you want to impersonate, [create a new GitHub App](https://developer.github.com/apps/building-github-apps/creating-a-github-app/) with your desired permissions.  If only creating a new app for the purposes of impersonation by Actions, you do not need to provide a `Webhook URL or Webhook Secret`

2. Install the App on your repositories. 

3. See [action.yml](action.yml) for the api spec.

Example:

```yaml
steps:
- name: Get token
  id: get_token
  uses: machine-learning-apps/actions-app-token@master
  with:
    APP_PEM: ${{ secrets.APP_PEM }}
    APP_ID: ${{ secrets.APP_ID }}

- name: Get App Installation Token
  run: |
    echo "This token is masked: ${TOKEN}"
  env: 
    TOKEN: ${{ steps.get_token.outputs.app_token }}
```

**Note: The input `APP_PEM` needs to be base64 encoded.**  You can encode your private key file like this from the terminal:

```
cat your_app_key.pem | base64
```

## Mandatory Inputs

- `APP_PEM`: description: string version of your PEM file used to authenticate as a GitHub App. 

- `APP_ID`: your GitHub App ID.

## Outputs

 - `app_token`: The [installation access token](https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#authenticating-as-an-installation) for the GitHub App corresponding to the current repository.


# License

The scripts and documentation in this project are released under the MIT License.

## Notes

This action is actively used for [fastai/fastpages](https://github.com/fastai/fastpages) via [fastpages-chatops](https://github.com/apps/fastpages-chatops)
