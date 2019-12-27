# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v2.0.2](https://github.com/rnelson0/puppet-local_user/tree/v2.0.2) (2019-07-10)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v2.0.1...v2.0.2)

## [v2.0.1](https://github.com/rnelson0/puppet-local_user/tree/v2.0.1) (2019-07-10)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v1.0.8...v2.0.1)

### Added

- Replace validate\_\* with defined types. [\#65](https://github.com/rnelson0/puppet-local_user/pull/65) ([rnelson0](https://github.com/rnelson0))
- Pass password through to puppet directly rather than sed /etc/shadow [\#57](https://github.com/rnelson0/puppet-local_user/pull/57) ([cryptk](https://github.com/cryptk))
- Remove duplicate groups when assigning both gid and groups [\#55](https://github.com/rnelson0/puppet-local_user/pull/55) ([bbriggs](https://github.com/bbriggs))
- Expose system parameter for user type [\#54](https://github.com/rnelson0/puppet-local_user/pull/54) ([bbriggs](https://github.com/bbriggs))

### UNCATEGORIZED PRS; GO LABEL THEM

- Release 2.0.0 [\#69](https://github.com/rnelson0/puppet-local_user/pull/69) ([rnelson0](https://github.com/rnelson0))
- Remove puppet 3 testing, add puppet 5 testing [\#66](https://github.com/rnelson0/puppet-local_user/pull/66) ([rnelson0](https://github.com/rnelson0))
- Remove direct reference to semantic\_puppet [\#64](https://github.com/rnelson0/puppet-local_user/pull/64) ([rnelson0](https://github.com/rnelson0))
- Modulesync [\#63](https://github.com/rnelson0/puppet-local_user/pull/63) ([rnelson0](https://github.com/rnelson0))
- MSync Gemfile and Rakefile [\#62](https://github.com/rnelson0/puppet-local_user/pull/62) ([rnelson0](https://github.com/rnelson0))
- Update test configuration [\#60](https://github.com/rnelson0/puppet-local_user/pull/60) ([rnelson0](https://github.com/rnelson0))
- Gemfile: Remove guard-rake from development group. [\#59](https://github.com/rnelson0/puppet-local_user/pull/59) ([rnelson0](https://github.com/rnelson0))
- Update .travis.yml and Rakefile [\#58](https://github.com/rnelson0/puppet-local_user/pull/58) ([rnelson0](https://github.com/rnelson0))
- August msync [\#53](https://github.com/rnelson0/puppet-local_user/pull/53) ([rnelson0](https://github.com/rnelson0))
- Puppet4 [\#52](https://github.com/rnelson0/puppet-local_user/pull/52) ([rnelson0](https://github.com/rnelson0))
- Update from rnelson0's modulesync [\#45](https://github.com/rnelson0/puppet-local_user/pull/45) ([rnelson0](https://github.com/rnelson0))

## [v1.0.8](https://github.com/rnelson0/puppet-local_user/tree/v1.0.8) (2016-03-16)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v1.0.7...v1.0.8)

### Added

- v1.0.8 release PR [\#44](https://github.com/rnelson0/puppet-local_user/pull/44) ([rnelson0](https://github.com/rnelson0))
- Add option to manage GID only. Fixes \#37. [\#42](https://github.com/rnelson0/puppet-local_user/pull/42) ([bbriggs](https://github.com/bbriggs))
- Initial Commit - Create a Windows user [\#41](https://github.com/rnelson0/puppet-local_user/pull/41) ([matthewrstone](https://github.com/matthewrstone))

## [v1.0.7](https://github.com/rnelson0/puppet-local_user/tree/v1.0.7) (2016-01-25)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v1.0.6...v1.0.7)

### Added

- 1.0.7 release [\#34](https://github.com/rnelson0/puppet-local_user/pull/34) ([rnelson0](https://github.com/rnelson0))
- Default the comment field to resource name [\#32](https://github.com/rnelson0/puppet-local_user/pull/32) ([bbriggs](https://github.com/bbriggs))
- Regex improvements [\#31](https://github.com/rnelson0/puppet-local_user/pull/31) ([rnelson0](https://github.com/rnelson0))
- Example of using hiera with local\_users [\#29](https://github.com/rnelson0/puppet-local_user/pull/29) ([rnelson0](https://github.com/rnelson0))

### UNCATEGORIZED PRS; GO LABEL THEM

- Streamline the travis CI testing matrix and configuration. [\#30](https://github.com/rnelson0/puppet-local_user/pull/30) ([rnelson0](https://github.com/rnelson0))

## [v1.0.6](https://github.com/rnelson0/puppet-local_user/tree/v1.0.6) (2016-01-21)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v1.0.5...v1.0.6)

### Added

- Update module to meet Puppet Approved requirements [\#27](https://github.com/rnelson0/puppet-local_user/pull/27) ([rnelson0](https://github.com/rnelson0))

## [v1.0.5](https://github.com/rnelson0/puppet-local_user/tree/v1.0.5) (2016-01-15)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v1.0.4...v1.0.5)

### Added

- Add `manage\_groups` parameter [\#26](https://github.com/rnelson0/puppet-local_user/pull/26) ([rnelson0](https://github.com/rnelson0))

## [v1.0.4](https://github.com/rnelson0/puppet-local_user/tree/v1.0.4) (2016-01-05)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v1.0.3...v1.0.4)

### Added

- Update README.md [\#23](https://github.com/rnelson0/puppet-local_user/pull/23) ([rnelson0](https://github.com/rnelson0))
- Expose managehome parameter to user [\#21](https://github.com/rnelson0/puppet-local_user/pull/21) ([bbriggs](https://github.com/bbriggs))
- Allow entering a date for the $last\_change param [\#20](https://github.com/rnelson0/puppet-local_user/pull/20) ([rnelson0](https://github.com/rnelson0))
- Add support for using GID parameter in local\_user type [\#16](https://github.com/rnelson0/puppet-local_user/pull/16) ([bbriggs](https://github.com/bbriggs))

## [v1.0.3](https://github.com/rnelson0/puppet-local_user/tree/v1.0.3) (2015-12-01)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/v1.0.2...v1.0.3)

### Added

- Adding support for optional uid. [\#13](https://github.com/rnelson0/puppet-local_user/pull/13) ([galp](https://github.com/galp))

## [v1.0.2](https://github.com/rnelson0/puppet-local_user/tree/v1.0.2) (2015-11-15)

[Full Changelog](https://github.com/rnelson0/puppet-local_user/compare/0a1daf0157d72ade5d1521bf005ef40cbfc21eee...v1.0.2)

### Added

- Preparing module for puppet 4 support [\#12](https://github.com/rnelson0/puppet-local_user/pull/12) ([rnelson0](https://github.com/rnelson0))
- Sshkey [\#6](https://github.com/rnelson0/puppet-local_user/pull/6) ([rnelson0](https://github.com/rnelson0))
- Improvements to match puppet style. [\#3](https://github.com/rnelson0/puppet-local_user/pull/3) ([rnelson0](https://github.com/rnelson0))
- Last change [\#2](https://github.com/rnelson0/puppet-local_user/pull/2) ([rnelson0](https://github.com/rnelson0))
- Create successful spec tests [\#1](https://github.com/rnelson0/puppet-local_user/pull/1) ([rnelson0](https://github.com/rnelson0))

### UNCATEGORIZED PRS; GO LABEL THEM

- Add badges to the readme. [\#11](https://github.com/rnelson0/puppet-local_user/pull/11) ([rnelson0](https://github.com/rnelson0))
- Initial Travis CI enabled commit. [\#10](https://github.com/rnelson0/puppet-local_user/pull/10) ([rnelson0](https://github.com/rnelson0))
- v0.9.4 - Update url to match renamed repo [\#8](https://github.com/rnelson0/puppet-local_user/pull/8) ([rnelson0](https://github.com/rnelson0))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
