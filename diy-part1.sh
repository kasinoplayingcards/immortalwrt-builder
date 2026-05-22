#!/bin/bash

# 清理可能冲突组件
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/v2ray-core
rm -rf feeds/packages/net/sing-box
rm -rf feeds/luci/applications/luci-app-passwall

# 关闭 IPv6
sed -i 's/CONFIG_IPV6=y/CONFIG_IPV6=n/g' .config || true

# 修改默认 IP
sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate

echo "stable build mode enabled"
