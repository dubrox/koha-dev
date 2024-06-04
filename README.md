Koha easy dev environment
=========================

This approach creates a simple Debian container to run `ktd` following the instructions from the official documentation:
- https://gitlab.com/koha-community/koha-testing-docker/-/blob/main/README.md
- https://wiki.koha-community.org/wiki/Koha-testing-docker

This way you don't have to follow those setup instructions manually, as everything is done by this container.

Note that this container builds the `koha-testing-docker` stack as sibling of this stack.

## How to use it

Be sure to have the Koha source available locally.

If you don't and you think about cloning from their git repo, first read the following:

> **BEWARE**: if you're on **Windows** and you want to use your local code, be sure to have those repos checked out [without the newline conversions from Git](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_formatting_and_whitespace).
> Not doing so will result in some scripts breaking up during their execution. 

For Windows, I'd suggest using the following configuration:
```sh
git config --global core.autocrlf input
```

Then you can clone it in your favorite working directory:
```sh
git clone --branch main --single-branch https://git.koha-community.org/Koha-community/Koha.git koha
```

Copy the `example.env` file in this repo, rename it as `.env` and replace the `SYNC_REPO` value
with the path to your local Koha source code. The value in the example shows how to define paths
from Windows environments (at least tested in Windows 11).

Open a terminal in this repo directory and:
```sh
docker compose up
```
It will take some time to set-up. You can check the logs to see how it proceeds.

You'll eventually be able to access Koha on http://localhost:8080 for the OPAC or http://localhost:8081 for the staff client.

## Use local repos

If you want to use local `koha` and `koha-testing-docker` files instead of the ones available in the docker container,
simply uncomment the corresponding lines in the `docker-compose.yml` file.
