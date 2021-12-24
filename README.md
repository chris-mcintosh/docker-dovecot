docker-dovecot
======================

***docker-dovecot*** is a fork of [*docker-dovecot-getmail*](http://github.com/gw0/docker-dovecot-getmail/) to only include dovecot

***docker-dovecot-getmail*** is a [*Docker*](http://www.docker.com/) image based on *Debian* implementing a private email gateway with [*dovecot*](http://en.wikipedia.org/wiki/Dovecot_(software)) and [*getmail*](http://en.wikipedia.org/wiki/Getmail) for gathering emails from multiple accounts on a private server (IMAP), but using a public email infrastructure for sending (SMTP).

It is a *Docker* container realizing a similar architecture to:

- <http://joel.porquet.org/wiki/hacking/getmail_dovecot/>

```
+-----------+              +-----------+               +--------------+
| ISP       |              | DOCKER    |               | LAPTOP       |
|           |              |           |           +-->|--------------|
| +-------+ | push/delete  | +-------+ | push/sync |   |  MAIL CLIENT +---+
| | IMAPS +----------------->| IMAPS +<------------+   +--------------+   |
| +-------+ |              | +-------+ |           |   +--------------+   |
| +-------+ |              |           |           |   | ANDROID      |   |
| | SMTP  |<-------+       |           |           +-->|--------------|   |
| +-------+ |      |       |           |               |  MAIL CLIENT +---+
+-----------+      |       +-----------+               +--------------+   |
                   +------------------------------------------------------+
```

Open source project:

- <i class="fa fa-fw fa-github-square"></i> github: <http://github.com/gw0/docker-dovecot-getmail/>
- <i class="fa fa-fw fa-laptop"></i> technology: *debian*, *dovecot*, *getmail*
- <i class="fa fa-fw fa-database"></i> docker hub: <https://hub.docker.com/r/gw000/dovecot-getmail/>


Usage
=====

Requirements:

- `/home`: mounted users directories (`Maildir` in fs layout)
- `/etc/ssl/private`: mounted SSL/TLS certificates (`dovecot.crt`, `dovecot.key`)



Do not forget to place your SSL certificates as `/srv/mail/ssl/dovecot.crt` and `/srv/mail/ssl/dovecot.key`. SSL is required!

And finally start it with *docker*:

```bash
$ docker run -d -v /srv/mail/home:/home -v /srv:/vol -v /srv/mail/ssl:/etc/ssl/private:ro -p 143 -p 993 -p 4190 --name mail gw000/dovecot-getmail
```

Or use *docker-compose* (check out `docker-compose.example.yml`).

Users are created automatically. If password in `/vol/config/${USER}.pass` the password in file will be used else default password (`replaceMeNow`) ia set on first start. To reset user passwords (of a running container):

```bash
$ docker exec -it mail passwd user
```


Feedback
========

If you encounter any bugs or have feature requests, please file them in the [issue tracker](http://github.com/gw0/docker-dovecot-getmail/issues/) or even develop it yourself and submit a pull request over [GitHub](http://github.com/gw0/docker-dovecot-getmail/).


License
=======

Copyright &copy; 2016-2021 *gw0* [<http://gw.tnode.com/>] &lt;<gw.2021@ena.one>&gt;

This library is licensed under the [GNU Affero General Public License 3.0+](LICENSE_AGPL-3.0.txt) (AGPL-3.0+). Note that it is mandatory to make all modifications and complete source code of this library publicly available to any user.
