# clangd-10のためubuntu18
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y build-essential tar patch curl bzip2
RUN apt-get install -y vim clangd-10 

WORKDIR /root/
RUN mkdir src

# binutils-2.19.1
WORKDIR /root/src/
RUN curl -O http://core.ring.gr.jp/pub/GNU/binutils/binutils-2.19.1.tar.bz2
RUN tar -xf binutils-2.19.1.tar.bz2
WORKDIR /root/src/binutils-2.19.1/
RUN ./configure --target=h8300-elf --disable-nls --disable-werror
RUN make
RUN make install

# gcc-3.4.6
# download
WORKDIR /root/src/
RUN curl -O http://core.ring.gr.jp/pub/GNU/gcc/gcc-3.4.6/gcc-3.4.6.tar.bz2
RUN tar -xf gcc-3.4.6.tar.bz2

# patch
WORKDIR /root/src/gcc-3.4.6/gcc/
RUN sed -i -e "s/(redir, O_WRONLY | O_TRUNC | O_CREAT)/(redir, O_WRONLY | O_TRUNC | O_CREAT, 0755)/" collect2.c

# patch
RUN curl -O https://gcc.gnu.org/legacy-ml/gcc-patches/2006-10/msg00337.html
RUN sed -n 94,126p msg00337.html > gcc-3-4-6-h8300.patch && rm msg00337.html
RUN patch /root/src/gcc-3.4.6/gcc/config/h8300/h8300.c < gcc-3-4-6-h8300.patch

## install gcc-3.4.6
WORKDIR /root/src/gcc-3.4.6/
RUN ./configure --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-werror
RUN make
RUN make install


WORKDIR /root/
