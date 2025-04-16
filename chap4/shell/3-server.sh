#!/usr/bin/env bash

# 显示帮助信息
show_help() {
    echo "Usage: $0 [OPTIONS] <access_log_file>"
    echo
    echo "This script analyzes web server access logs in TSV format and generates various statistics."
    echo "Log format should be: host\tlogname\ttime\tmethod\turl\tresponse\tbytes\treferer\tuseragent"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message and exit"
    echo
    echo "Output:"
    echo "  The script creates a directory with timestamp and saves all analysis results there."
    echo
    echo "Analysis includes:"
    echo "  1. Top 100 hosts by access count"
    echo "  2. Top 100 IP addresses by access count"
    echo "  3. Top 100 most frequently accessed URLs"
    echo "  4. Response code statistics with percentages"
    echo "  5. Top 10 URLs for each 4XX response code"
    echo "  6. Top 100 hosts for a user-specified URL (interactive)"
    echo
    echo "Example:"
    echo "  $0 access.log"
    echo "  $0 -h"
}

# 检查帮助参数
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

# 检查输入参数
if [ $# -ne 1 ]; then
    echo "Error: Missing log file argument"
    echo
    show_help
    exit 1
fi

log_file=$1

# 检查文件是否存在
if [ ! -f "$log_file" ]; then
    echo "Error: File '$log_file' not found!"
    echo
    show_help
    exit 1
fi

# 创建输出目录
output_dir="log_analysis_results_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$output_dir"

# 1. 统计访问来源主机TOP 100和分别对应出现的总次数
echo "统计访问来源主机TOP 100..."
awk -F'\t' '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 100 > "$output_dir/top_100_hosts.txt"

# 2. 统计访问来源主机TOP 100 IP和分别对应出现的总次数
echo "统计访问来源主机TOP 100 IP..."
awk -F'\t' '$1 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 100 > "$output_dir/top_100_ips.txt"

# 3. 统计最频繁访问的URL TOP 100
echo "统计最频繁访问的URL TOP 100..."
awk -F'\t' '{print $5}' "$log_file" | sort | uniq -c | sort -nr | head -n 100 > "$output_dir/top_100_urls.txt"

# 4. 统计不同响应码的出现次数和百分比
echo "统计不同响应码的出现次数和百分比..."
total=$(wc -l < "$log_file")
awk -F'\t' '{print $6}' "$log_file" | sort | uniq -c | sort -nr | awk -v total="$total" '{printf "%s\t%d\t%.2f%%\n", $2, $1, ($1/total)*100}' > "$output_dir/response_codes.txt"

# 5. 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
echo "统计不同4XX状态码对应的TOP 10 URL..."
awk -F'\t' '$6 ~ /^4[0-9][0-9]$/ {print $6, $5}' "$log_file" | sort | uniq -c | sort -nr | 
awk '{
    if ($2 != prev_code) {
        if (prev_code != "") {
            close(outfile)
        }
        prev_code = $2
        count = 0
        outfile = "'"$output_dir"'/4xx_" $2 "_top_urls.txt"
    }
    if (count < 10) {
        print $3 "\t" $1 > outfile
        count++
    }
}'

# 6. 给定URL输出TOP 100访问来源主机
echo -n "请输入要分析的URL: "
read url
if [ -n "$url" ]; then
    echo "统计URL '$url'的TOP 100访问来源主机..."
    awk -F'\t' -v url="$url" '$5 == url {print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 100 > "$output_dir/top_100_hosts_for_url.txt"
else
    echo "未输入URL，跳过此统计项"
fi

echo "分析完成！结果保存在目录: $output_dir"