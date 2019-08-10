FROM centos:7
# 换源
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
    && sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo \
    && yum clean all; yum makecache

RUN yum -y  install gcc automake autoconf libtool make java-1.8.0-openjdk wget gcc-c++ zlib* \
    openssh-clients passwd chkconfig lsof vim iproute
# 安装openssh-server
RUN yum -y install openssh-server

RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key

# 指定root密码
RUN /bin/echo 'root:root'|chpasswd
RUN /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd

# python环境依赖包
RUN yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel

# 安装python
RUN wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz \
    && tar xJf Python-3.6.8.tar.xz \
    && /Python-3.6.8/configure --prefix=/usr/local/python3 \
    && make && make install \
    && ln -s /usr/local/python3/bin/python3 /usr/bin/python3 && ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3

# pip换源
RUN mkdir ~/.pip && \
    echo -e "[global]" \
            "\ntimeout = 6000" \
            "\nindex-url = https://mirrors.aliyun.com/pypi/simple/" \
            "\ntrusted-host = pypi.tuna.tsinghua.edu.cn" > ~/.pip/pip.conf



#下载Jenkins
RUN wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war -P ~


# 系统编码设置utf8
RUN sed -i '$a export LANG=en_US.utf8' /etc/profile
ENV LANG en_US.utf8
EXPOSE 22
CMD /usr/sbin/sshd -D
