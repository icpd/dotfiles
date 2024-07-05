#!/bin/bash

# 检查是否提供了网卡名参数
if [ -z "$1" ]; then
    echo "Usage: $0 <network_interface>"
    exit 1
fi

# 获取网卡名参数
nic="$1"

# 获取全部网卡队列的中断号
interrupts_file="/proc/interrupts"
interrupt_numbers=$(awk -v nic="$nic" '$0 ~ nic {print $1}' "$interrupts_file" | sed 's/://')

# 检查是否找到中断号
if [ -z "$interrupt_numbers" ]; then
    echo "未找到网卡 $nic 的中断号"
    exit 1
fi

# 查看所有中断号的CPU亲和性配置
for irq in $interrupt_numbers; do
    smp_affinity_file="/proc/irq/$irq/smp_affinity_list"
    if [ -f "$smp_affinity_file" ]; then
        smp_affinity=$(cat "$smp_affinity_file")
        echo "irq: $irq, CPU: $smp_affinity"
    else
        echo "irq: $irq, CPU亲和性配置文件不存在"
    fi
done
