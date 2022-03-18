Release instructions
====================

Neuro WebUI [uses `pipelines` tag](https://github.com/neuro-inc/platform-pipelines/blob/ec5a458140f9a64c06db700d42bf6680b9c9bc4c/platform_pipelines/config.py#L165-L173) to deploy `docker-registry-frontend`, which is published via `release` branch.


Instructions:
------------

1. Merge all necessary PRs and ensure that `master` is green, update your local master branch:
    ```
    $ git checkout master
    $ git pull origin
    ```
2. Test `latest` manually:
    ```
    neuro run --pass-config --http-port 80 --browse ghcr.io/neuro-inc/docker-registry-frontend:latest
    ```
3. Generate changelog:
    - `make changelog-draft` - verify changelog looks valid
    - `make changelog` - delete changelog items from `CHANGELOG.d` and really modify [CHANGELOG.md](./CHANGELOG.md)
    - `git add CHANGELOG* version.txt`
    - `git commit -m "Update version and changelog for $(cat version.txt) release"` - commit changelog changes in **local** repository
    - `git tag $(cat version.txt)` - mark latest changes as a release tag
    - `git push && git push --tags` - push the updated changelog and assigned tag to the remote repository
    - Note, this `master` branch update will trigger CI

4. Now, hard-reset `release` branch on `master` (actual release):
    ```
    $ git checkout release
    $ git reset --hard master
    $ git push  # no need to push --force since `release` will move only forward
    ```
5. Once `release` is green, test it via `neuro run --pass-config --http-port 80 --browse ghcr.io/neuro-inc/docker-registry-frontend:pipelines`, and if everything's fine,
    publish new release to Slack: `#platform-feedback`.

Notes:
------

- When CI is triggered:
    - Each new commit to `master` and `release`.
