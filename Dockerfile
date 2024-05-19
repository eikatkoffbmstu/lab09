FROM archlinux
RUN pacman -Syu --noconfirm     && pacman -S --noconfirm gcc make cmake clang     && pacman -Scc --noconfirm


COPY . print/
WORKDIR print

ENV CMAKE_MAKE_PROGRAM /usr/bin/make

RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/logs/log.txt

VOLUME /home/logs

WORKDIR _install/bin

ENTRYPOINT ./demo
