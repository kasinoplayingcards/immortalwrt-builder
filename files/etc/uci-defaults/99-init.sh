#!/bin/sh

# ================= IP 固定 =================
uci set network.lan.ipaddr='192.168.11.1'
uci set network.lan.netmask='255.255.255.0'

# ================= LAN 全口桥接 =================
uci set network.lan.type='bridge'
uci -q delete network.lan.device
uci add_list network.lan.device='eth0'
uci add_list network.lan.device='eth1'
uci add_list network.lan.device='eth2'
uci add_list network.lan.device='eth3'

# ================= IPv6 关闭 =================
uci delete network.wan6 2>/dev/null
uci set dhcp.lan.dhcpv6='disabled'
uci set dhcp.lan.ra='disabled'

# ================= DNS =================
uci set dhcp.@dnsmasq[0].noresolv='1'
uci -q delete dhcp.@dnsmasq[0].server
uci add_list dhcp.@dnsmasq[0].server='1.1.1.1'
uci add_list dhcp.@dnsmasq[0].server='8.8.8.8'

# ================= Samba 默认 =================
uci set samba4.@samba[0].charset='UTF-8'

# ================= 应用 =================
uci commit network
uci commit dhcp
uci commit samba4

/etc/init.d/network restart
/etc/init.d/dnsmasq restart

# ================= 自动删除 =================
rm -f /etc/uci-defaults/99-init.sh

exit 0
