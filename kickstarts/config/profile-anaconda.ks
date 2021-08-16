%post
touch /etc/anaconda/product.d/anaconda.conf
cat << EOF >>/etc/anaconda/product.d/anaconda.conf
# Anaconda configuration file for Fedora Workstation Live.


[Product]
product_name = Ultramarine Linux
product_id = anaconda
[Base Product]
product_name = Ultramarine Linux
[Profile Detection]
# Match os-release values.
os_id = ultramarine
EOF
%end