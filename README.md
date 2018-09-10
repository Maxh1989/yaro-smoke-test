# Yaro Smoke Tests

This repo provides a set of smoke tests for end-to-end testing.

## Running the tests

To run the tests:

```bash
$ bin/rspec
```

## Environment config

All dynamic configuration values are available through environment variables.
For local testing, a .env file is available for easy configuration. A sample
.env file is available at `.env.sample`. Copy this to `.env` and edit as
necessary.

At the moment, three variables are available:

**PLATFORM_ROOT_URL**

The root url for the platform service.

_.e.g._ `http://localhost:3000`

**NOTIFICATIONS_ROOT_URL**

The root url for the notifications service.

_.e.g_ `http://localhost:3001`


**QUIZ_ROOT_URL**

The root url for the quiz service.

_.e.g_ `http://localhost:3002`

The .env file is ignored by the repo, so feel free to change values if you're
testing multiple environments. Alternatively, you can always pass the variables
on the command line, as usual:

```bash
$ PLATFORM_ROOT_URL=http://some-other-url bin/rspec
```
