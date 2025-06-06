
# Utopia FXServer

Contains git submodules, don't forget to `git submodule init` & `git submodule update`!
You can also `git clone` using the `--recurse-submodules` flag


## Build, Develop & Run

> docker build -f Dockerfile -t utopia-fxserver .

> docker run --env-file .env.local -it --rm -p 30120:30120 -p 30120:30120/udp -p 8088:80 -v $(pwd):/config utopia-fxserver
