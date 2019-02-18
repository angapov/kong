FROM  kong:1.0-centos
ENV PACKAGES="unzip openssl-devel gcc git"
RUN yum update -y && yum install -y $PACKAGES
ADD kong-oidc kong-oidc
RUN cd kong-oidc \
    && luarocks build kong-oidc-1.1.0-0.rockspec \
    && chown -R kong:kong /usr/local/kong \
    && setcap 'cap_net_bind_service=+ep' /usr/local/bin/kong \
    && setcap 'cap_net_bind_service=+ep' /usr/local/openresty/nginx/sbin/nginx
RUN yum remove -y $PACKAGES \
    && yum autoremove -y \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -fr *.rock*
ADD nginx_kong.lua /usr/local/share/lua/5.1/kong/templates/
ADD kong_defaults.lua /usr/local/share/lua/5.1/kong/templates/
