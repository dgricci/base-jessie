% Image de base pour jessie
% Didier Richard
% rév. 0.0.1 du 01/09/2016
% rév. 0.0.2 du 10/09/2016
% rév. 0.0.3 du 20/10/2016
% rév. 0.1.0 du 01/11/2016
% rév. 0.1.1 du 11/03/2017

---

# Building #

```bash
$ docker build -t dgricci/jessie:$(< VERSION) .
$ docker tag dgricci/jessie:$(< VERSION) dgricci/jessie:latest
```

## Behind a proxy (e.g. 10.0.4.2:3128) ##

```bash
$ docker build \
    --build-arg http_proxy=http://10.0.4.2:3128/ \
    --build-arg https_proxy=http://10.0.4.2:3128/ \
    -t dgricci/jessie:$(< VERSION) .
$ docker tag dgricci/jessie:$(< VERSION) dgricci/jessie:latest
```     

## Build command with arguments default values : ##

```bash
$ docker build \
    --build-arg GOSU_VERSION=1.10 \
    --build-arg GOSU_DOWNLOAD_URL=https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 \
    -t dgricci/jessie:$(< VERSION) .
$ docker tag dgricci/jessie:$(< VERSION) dgricci/jessie:latest
``` 

# Use #

This image may use :

* USER_ID : the user identifier under which the container is launched. It is
assumed that the user's group is the same when USER_GP is not given. If not
given, root is used as usual when runnning the container ;
* USER_GP : the user's group identifier to which the user belongs. Defaults to
USER_ID ;
* USER_NAME : possibly, the name of this user ! Defaults to `xuser` when not
given.

The USER_ID argument allows files created in the container to belong to this
user (id) and not to root (by default) which can cause problems when sharing
volumes between user's space and the container.

## Tests ##

Just launch `base-jessie.bats` (once `bats`[^bats] is installed on your system) :

```bash
$ ./base-jessie.bats
 ✓ no information about the user running the container
 ✓ give the identifier of the current user
 ✓ add a group id of 2000
 ✓ add dgricci as user name
 ✓ then activate debug option

5 tests, 0 failures
```

or, better, using the TAP formatting :

```bash
$ ./base-jessie.bats --tap
1..5
ok 1 no information about the user running the container
ok 2 give the identifier of the current user
ok 3 add a group id of 2000
ok 4 add dgricci as user name
ok 5 then activate debug option
```

__Et voilà !__


_fin du document[^pandoc_gen]_

[^bats]: https://github.com/sstephenson/bats
[^pandoc_gen]: document généré via $ `pandoc -V fontsize=10pt -V geometry:"top=2cm, bottom=2cm, left=1cm, right=1cm" -s -N --toc -o base-jessie.pdf README.md`{.bash}

