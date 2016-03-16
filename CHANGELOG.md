## Release 1.0.8

* `$manage_group` option `primary`|`gid` added, to only managed the user's group ([bbriggs](https://github.com/bbrigs))
* New type `local_user::windows` ([matthewrstone](https://github.com/matthewrstone))

## Release 1.0.7

* Added a changelog.
* Re-formated the readme for easier reading.
* The `$comment` parameter of `local_user` has been made optional.
* User password regex identifies users by the whole name rather than accepting partial matches.
* The Travis CI test matrix was reduced to Ruby 1.9.3/2.10 and the latest Puppet 3/4 versions, and other minor improvements.
* The readme now provides an example of using `local_user` with hiera data.
