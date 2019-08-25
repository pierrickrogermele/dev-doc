Quality, testing and integration
================================

## CI (Continuous integration)

 * [Continuous Delivery - Patterns and Anti-Patterns in the Software Lifecycle](https://dzone.com/refcardz/continuous-delivery-patterns).

### Travis-CI

#### R language

Caching R packages:
```yaml
language: r
cache: packages
```

Setting R version:
```yaml
language: r
r: release
```

#### Using Docker

 * [Using Docker in Builds](https://docs.travis-ci.com/user/docker/).

```yaml
sudo: required

services:
  - docker
```

#### CRON jobs

 * [Cron Jobs](https://docs.travis-ci.com/user/cron-jobs/).

When a build is triggered by `cron`, the environment variable `TRAVIS_EVENT_TYPE` is set to `"cron"`.

#### Running locally

 * [travis-ci/travis-build](https://github.com/travis-ci/travis-build).

Running Travis-CI tests locally can be done through Docker. For instance for a Travis-CI test configured with Python language:
```bash
docker run -it quay.io/travisci/travis-python /bin/bash
su - travis
```
Then clone your repository, and run the commands of your `.travis.yml` file manually.

### Jenkins

 * [Remote access API](https://wiki.jenkins-ci.org/display/JENKINS/Remote+access+API).

For instance for PhenoMeNal project:
```bash
wget -O phn-tools.xml http://phenomenal-h2020.eu/jenkins/api/xml?depth=1&tree=jobs
```

Some graphical or monitor views, provided by plugins:

 * [Global Build Stats Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Global+Build+Stats+Plugin).
 * [Dashboard View](https://wiki.jenkins-ci.org/display/JENKINS/Dashboard+View).
 * [Build Monitor Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Monitor+Plugin).

## Coding standards

 * [GNU coding standards](https://www.gnu.org/prep/standards/).

## Software development processes

### Waterfall

The [Waterfall model](https://en.wikipedia.org/?title=Waterfall_model) in which all phases are completed in order: requirements, design, implementation, etc.

### Agile

The [Agile method](https://en.wikipedia.org/wiki/Agile_software_development) is in fact a group of software development methods.
It promotes adaptive planning, evolutionary development, early delivery, continuous improvement, and encourages rapid and flexible response to change.

Example of Agile methods:

 * Extreme programming.
 * Scrum.

## Quality

### Static code analysis

C++:

 * cppcheck.
 * Klockwork.
 * Code Analysis.
 * `clang --analyze`.
 * Coverity.
 * AQtime.
