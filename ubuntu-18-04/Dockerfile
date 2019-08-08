FROM ubuntu:18.04

RUN apt-get update && apt-get install -y python3.6 python3-pip
# Install any needed packages specified in requirements.txt
RUN echo "root:root"|chpasswd \
    && sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g"  /etc/ssh/sshd_config \
    && sed -i "s/#PermitRootLogin yes/PermitRootLogin yes/g"  /etc/ssh/sshd_config \
    && ssh-keygen -t RSA -N '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# python环境依赖包
# RUN apt-get -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel \
#    mysql-devel gcc gcc-devel python-devel
# 安装python
# pip换源
RUN mkdir ~/.pip && \
    echo -e "[global]" \
            "\ntimeout = 6000" \
            "\nindex-url = https://mirrors.aliyun.com/pypi/simple/" \
            "\ntrusted-host = pypi.tuna.tsinghua.edu.cn" > ~/.pip/pip.conf


# 系统编码设置utf8

#RUN export LC_ALL=en_US.utf8 && export LANG=en_US.utf8
RUN sed -i '$a export LANG=en_US.utf8' /etc/profile
ENV LANG en_US.utf8


#
CMD ["/usr/sbin/init"]
#CMD ["mkdir", "aabb"]