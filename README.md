# xmage-docker
Docker Xmage Files

Based on the work [Goesta](https://github.com/mage-docker/xmage-beta-docker) did, setup to build a fresh image each launch.

## Changes

* Builds off Java 21 image (I wanted to use [ZGC](https://wiki.openjdk.org/display/zgc/Main)), you can easily flip this back in `Dockerfile` to java 8.
* There's a bunch of specific Java options I've set in `compose.yaml` related to Java21, ZGC, and HugePages. Delete them if you don't want them. `--add-opens=java.base/java.io=ALL-UNNAMED` is mandatory if you are using Java21.
* Adds an environment variable to set an optional admin password, not the most secure way to do this but I wanted to see if it worked at all (it does). [Admin Tools](https://github.com/magefree/mage/issues/5388)
* Points to Graths weekly builds. You can easily update this in `Dockerfile` to point to whatever repo you want.

## How To

Clone the repo and make your changes. 

### Make sure you change XMAGE_DOCKER_SERVER_ADMIN_PASSWORD or set it to empty in compose.yaml

Then from inside the directory run the following to download and build a fresh image:

`docker compose up -d`

Use this command to stop the stack and remove the image:

`docker compose down mage_weekly --rmi local`

Update the name if you change the service name in `compose.yaml`
