# Contributing

## Language

All issues, commit messages and merge requests must be written in **english**.

## Git Flow

### Branches

#### Main branches

There are two main branches:

- `master`: contains the last publicly released stable version of the application
- `develop`: contains the last stable version of the application

#### Environments

There are two deploy environments:

- `staging`: follows `develop`. Is available at: `api-staging.queueup.gg`
- `production`: follows `master`. Is available at: `api.queueup.gg`

#### New branches

##### Features

Each new feature must be developed on a `feature/` branch. A merge request to `develop` must be opened with the [WIP tag](https://docs.gitlab.com/ee/user/project/merge_requests/work_in_progress_merge_requests.html) whenever the branch is created, so other contributors can see what you're working on.

##### Hotfix

Each new hotfix must be developed on a `hotfix/` branch. Merge requests to `develop` and `master` must be opened with the [WIP tag](https://docs.gitlab.com/ee/user/project/merge_requests/work_in_progress_merge_requests.html) whenever the branch is created, so other contributors can see what you're working on.

### Commits

Every single commit must explain what was changed to the codebase, and why.

### Issues

Every issue must be created with a relevant title and the relevant tags.

### Merge Requests

Every merge request must contain a description explaining what was changed, why, and if there are some tricky points/possible side effects.

## Continuous Integration

A continuous integration is set on the project in order to run some checks before adding your code to the codebase. This continous integration is run on each of your push or merge request.

### Linter

This project has an [Rubocop](https://github.com/rubocop-hq/rubocop) configuration to help you refactor and keep a clean codebase. To use it:

```bash
$ bundle exec rubocop
$ bundle exec rubocop -a    # With auto-correct
```

### Unit tests

This project includes [RSpec](http://rspec.info/) to run unit tests. Please consider writing unit tests for everything. To run unit tests:

`$ bundle exec rspec`

## Continuous Delivery

A continuous delivery is set with [Capistrano](https://capistranorb.com/) and [Gitlab CI](https://about.gitlab.com/features/gitlab-ci-cd/) on the project in order to deploy new versions of the application, on three different stages. Here are the different triggers:

- `staging`
  - New push on `develop`
- `production`
  - New push on `master`

## Documentation

[Swagger](https://swagger.io/) is setup on the project to power the documentation.

To access the documentation from the web (at `/api-docs`), you must set the `SWAGGER_WEB` env variable

The documentation is generated thanks to [rswag](https://github.com/domaindrivendev/rswag) and is available in [the integration folder](/spec/integration)

To generate the documentation from unit tests:

```bash
$ rake rswag:specs:swaggerize
```
