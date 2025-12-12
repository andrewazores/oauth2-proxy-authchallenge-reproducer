Reproducer for https://github.com/oauth2-proxy/oauth2-proxy HTTP Authentication flow using Basic auth.

Run `./test.bash`. If there is no `oauth2-proxy` file in this directory, the script will download and unpack a tarball from GitHub and run the test against that.
The script will download a `linux-amd64` binary by default, but this can be configured using `OS` and `ARCH` environment variables.

The test can be run against another build by simply replacing the `oauth2-proxy` in this directory with some other binary manually.

The test requires `curl`.
