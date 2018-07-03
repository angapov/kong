FROM  kong:0.13.1-centos
RUN yum install -y unzip openssl-devel gcc git
ADD kong-oidc kong-oidc
RUN sed -i '/v1.1.0/d' kong-oidc/kong-oidc-1.1.0-0.rockspec
RUN cd kong-oidc; luarocks build kong-oidc-1.1.0-0.rockspec
RUN yum remove -y unzip openssl-devel gcc git
COPY nginx_kong.lua /usr/local/share/lua/5.1/kong/templates/nginx_kong.lua
