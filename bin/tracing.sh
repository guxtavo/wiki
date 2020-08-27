#!/bin/bash
TOT_TIME=15

echo create temp script at ./capture_tracing
echo "
echo enabling tracing
echo 1 > /sys/kernel/debug/tracing/tracing_on
echo enabling events/net/net_if_receive_skb
echo 1 > /sys/kernel/debug/tracing/events/net/netif_receive_skb/enable
echo adding stacktrace to trace_options
echo stacktrace > /sys/kernel/debug/tracing/trace_options
echo piping the trace to ./tracing_netif_receive_skb
cat /sys/kernel/debug/tracing/trace_pipe > ./tracing_netif_receive_skb
" > ./capture_tracing
chmod +x ./capture_tracing

echo start capturing the trace for ${TOT_TIME}s
timeout ${TOT_TIME}s ./capture_tracing

echo disabling tracing
echo 0 > /sys/kernel/debug/tracing/tracing_on

echo deleting temp script at ./capture_tracing
rm ./capture_tracing

echo please collect ./tracing_netif_receive_skb
echo exiting
