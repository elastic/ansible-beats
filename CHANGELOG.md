# Changelog

## 7.10.0

* 7.10.0 as default version.


| PR | Author | Title |
| --- | --- | --- |
| [#113](https://github.com/elastic/ansible-beats/pull/113) | [@jmlrt](https://github.com/jmlrt) | [meta] clean deprecated bumper script  |


## 7.9.3

* 7.9.3 as default version.
* 6.8.13 as 6.x tested version

## 7.9.2 - 2020/09/24

* 7.9.2 as default version

## 7.9.1 - 2020/09/03

* 7.9.1 as default version

## 7.9.0 - 2020/08/18

* 7.9.0 as default version
* 6.8.12 as 6.x tested version

## 7.8.1 - 2020/07/28

* 7.8.1 as default version
* 6.8.11 as 6.x tested version

| PR                                                      | Author                             | Title                    |
|---------------------------------------------------------|------------------------------------|--------------------------|
| [#89](https://github.com/elastic/ansible-beats/pull/89) | [@jmlrt](https://github.com/jmlrt) | Add amazonlinux2 support |


## 7.8.0 - 2020/06/18

* 7.8.0 as default version

## 7.7.1 - 2020/06/04

* 7.7.1 as default version
* 6.8.10 as 6.x tested version

## 7.7.0 - 2020/05/13

* 7.7.0 as default version
* 6.8.9 as 6.x tested version
* Fix CentOS tests in [#86](https://github.com/elastic/ansible-beats/pull/86) ([@jmlrt](https://github.com/jmlrt))

| PR                                                      | Author                                   | Title                                       |
|---------------------------------------------------------|------------------------------------------|---------------------------------------------|
| [#84](https://github.com/elastic/ansible-beats/pull/84) | [@kravietz](https://github.com/kravietz) | Minor formatting fixes to pass ansible-lint |


## 7.6.2 - 2020/03/31

* 7.6.2 as default version
* 6.8.8 as 6.x tested version

| PR                                                      | Author                             | Title                                                                     |
|---------------------------------------------------------|------------------------------------|---------------------------------------------------------------------------|
| [#77](https://github.com/elastic/ansible-beats/pull/77) | [@jmlrt](https://github.com/jmlrt) | Add become to individual tasks                                            |
| [#75](https://github.com/elastic/ansible-beats/pull/75) | [@ktibi](https://github.com/ktibi) | Add option to disable the repo installation and lock package installation |
| [#78](https://github.com/elastic/ansible-beats/pull/78) | [@astik](https://github.com/astik) | Aad task to create directory for default policies                         |


## 7.6.1 - 2020/03/04

* 7.6.1 as default version


## 7.6.0 - 2020/02/11

* 7.6.0 as default version

| PR                                                      | Author                                                 | Title                              |
|---------------------------------------------------------|--------------------------------------------------------|------------------------------------|
| [#69](https://github.com/elastic/ansible-beats/pull/69) | [@dependabot[bot]](https://github.com/apps/dependabot) | Bump rubyzip from 1.2.2 to 2.0.0   |
| [#71](https://github.com/elastic/ansible-beats/pull/71) | [@jmlrt](https://github.com/jmlrt)                     | Fix filebeat example configuration |
| [#72](https://github.com/elastic/ansible-beats/pull/72) | [@beand](https://github.com/beand)                     | Fixed typo                         |


## 7.5.2 - 2020/01/21

* 7.5.2 as default version

| PR                                                      | Author                             | Title                                         |
|---------------------------------------------------------|------------------------------------|-----------------------------------------------|
| [#66](https://github.com/elastic/ansible-beats/pull/66) | [@jmlrt](https://github.com/jmlrt) | [doc] switched relative URLs to absolute URLs |
| [#67](https://github.com/elastic/ansible-beats/pull/67) | [@jmlrt](https://github.com/jmlrt) | [ci] bump ruby to 2.5.7                       |


## 7.5.1 - 2019/12/18

* 7.5.1 as default version
* 6.8.6 as 6.x tested version

| PR                                                      | Author                                             | Title                    |
|---------------------------------------------------------|----------------------------------------------------|--------------------------|
| [#61](https://github.com/elastic/ansible-beats/pull/61) | [@robsonpeixoto](https://github.com/robsonpeixoto) | Allow use oss repository |


## 7.5.0 - 2019/12/02

* 7.5.0 as default version
* 6.8.5 as 6.x tested version in [#57](https://github.com/elastic/ansible-beats/pull/57) [@jmlrt](https://github.com/jmlrt)

| PR                                                      | Author                                           | Title                                                           |
|---------------------------------------------------------|--------------------------------------------------|-----------------------------------------------------------------|
| [#50](https://github.com/elastic/ansible-beats/pull/50) | [@jmlrt](https://github.com/jmlrt)               | Add bumper script                                               |
| [#55](https://github.com/elastic/ansible-beats/pull/55) | [@tgadiev](https://github.com/tgadiev)           | Update syntax to make it compliant to modern ansible-lint rules |
| [#53](https://github.com/elastic/ansible-beats/pull/53) | [@jmlrt](https://github.com/jmlrt)               | Indent yaml for config file                                     |
| [#51](https://github.com/elastic/ansible-beats/pull/51) | [@ktibi](https://github.com/ktibi)               | Rename the handlers                                             |
| [#59](https://github.com/elastic/ansible-beats/pull/59) | [@MartinVerges](https://github.com/MartinVerges) | Beat config improvements                                        |


## 7.4.1 - 2019/10/23

* 7.4.1 as default version
* 6.8.4 as 6.x tested version

| PR                                                      | Author                             | Title               |
|---------------------------------------------------------|------------------------------------|---------------------|
| [#48](https://github.com/elastic/ansible-beats/pull/48) | [@jmlrt](https://github.com/jmlrt) | Fix probot newlines |


## 7.4.0 - 2019/10/01

* 7.4.0 as default version

| PR                                                      | Author                                   | Title                                                               |
|---------------------------------------------------------|------------------------------------------|---------------------------------------------------------------------|
| [#25](https://github.com/elastic/ansible-beats/pull/25) | [@jmlrt](https://github.com/jmlrt)       | Update kitchen Gem dependencies                                     |
| [#6](https://github.com/elastic/ansible-beats/pull/6)   | [@levonet](https://github.com/levonet)   | Remove `beat_install` variable                                      |
| [#32](https://github.com/elastic/ansible-beats/pull/32) | [@astik](https://github.com/astik)       | Remove unused `es_conf_dir` variable                                |
| [#33](https://github.com/elastic/ansible-beats/pull/33) | [@astik](https://github.com/astik)       | Replace custom filter with yaml handling                            |
| [#10](https://github.com/elastic/ansible-beats/pull/10) | [@Meecr0b](https://github.com/Meecr0b)   | Move the `repo_key` configuration to a variable                     |
| [#34](https://github.com/elastic/ansible-beats/pull/34) | [@nyetwurk](https://github.com/nyetwurk) | Make sure the right beat service gets restarted                     |
| [#38](https://github.com/elastic/ansible-beats/pull/38) | [@jmlrt](https://github.com/jmlrt)       | Add probot config to manage stale issues/pr + GH issue template     |
| [#40](https://github.com/elastic/ansible-beats/pull/40) | [@nyetwurk](https://github.com/nyetwurk) | Make beats `repo_key` variable a unique name less likely to collide |
| [#41](https://github.com/elastic/ansible-beats/pull/41) | [@jmlrt](https://github.com/jmlrt)       | Enhance ansible-beats documentation                                 |


## 7.0.0 - 2019/05/09

* First release
* 7.0.0 as default version
