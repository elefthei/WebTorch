FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
    cmake \
    git \
    make \
    gcc \
    g++ \
    sudo \
    wget \
    ca-certificates

RUN git clone https://github.com/torch/distro.git /usr/src/torch --recursive && \
    cd /usr/src/torch && \
    bash install-deps && \
    ./install.sh

ARG PCRE_VERSION="8.41"
ARG NGINX_VERSION="1.13.4"

RUN git clone https://github.com/simpl/ngx_devel_kit.git /usr/src/ngx-dev-kit && \
    git clone https://github.com/openresty/lua-nginx-module.git /usr/src/lua-nginx-module && \
    cd /usr/src && \
    wget https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VERSION}.tar.gz && \
    tar -xzf pcre-${PCRE_VERSION}.tar.gz && \
    wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -xzf nginx-${NGINX_VERSION}.tar.gz && \
    rm nginx-${NGINX_VERSION}.tar.gz && \
    rm pcre-${PCRE_VERSION}.tar.gz

# SYMlink to linluajit-5.1.so
RUN ln -sf /usr/src/torch/install/lib/libluajit.so /usr/src/torch/install/lib/libluajit-5.1.so.2.1 && \
    ln -sf /usr/src/torch/install/lib/libluajit.so /usr/src/torch/install/lib/libluajit-5.1.so.2 && \
    ln -sf /usr/src/torch/install/lib/libluajit.so /usr/src/torch/install/lib/libluajit-5.1.so

# Export environment variables manually
ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/usr/src/torch/install/share/lua/5.1/?.lua;/usr/src/torch/install/share/lua/5.1/?/init.lua;./?.lua;/usr/src/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/usr/src/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/usr/src/torch/install/bin:/opt/nginx/sbin:$PATH
ENV LD_LIBRARY_PATH=/usr/src/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/usr/src/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/usr/src/torch/install/lib/?.so;'$LUA_CPATH
ENV LUAJIT_LIB='/usr/src/torch/install/lib/'
ENV LUAJIT_INC='/usr/src/torch/install/include/'

RUN mkdir /src && \
    cd /usr/src/nginx-${NGINX_VERSION} && \
    ./configure --prefix=/opt/nginx \
         --with-ld-opt="-Wl,-rpath,$LUAJIT_LIB" \
         --with-cc-opt="-I$LUAJIT_INC" \
         --with-pcre=/usr/src/pcre-${PCRE_VERSION} \
         --with-pcre-jit \
         --add-module=/usr/src/ngx-dev-kit \
         --add-module=/usr/src/lua-nginx-module && \
    make -j2 && \
    make install

ADD . /src/
RUN cd /src && \
    make && \
    cp -r lib /opt/nginx/ && \
    cp nginx/conf/nginx.conf /opt/nginx/conf/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
