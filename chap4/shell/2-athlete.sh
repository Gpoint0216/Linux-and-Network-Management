#!/bin/bash

# 帮助信息函数
show_help() {
    echo "用法: $0 [选项] <运动员数据.tsv>"
    echo
    echo "选项:"
    echo "  -h, --help    显示此帮助信息"
    echo
    echo "功能说明:"
    echo "  1. 统计不同年龄区间球员数量及百分比"
    echo "  2. 统计不同场上位置的球员数量及百分比"
    echo "  3. 找出名字最长和最短的球员"
    echo "  4. 找出年龄最大和最小的球员"
    echo
    echo "输出文件:"
    echo "  生成统计报告文件，格式为'运动员统计报告.txt'"
    exit 0
}

# 参数处理
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        *)
            input_file="$1"
            shift
            ;;
    esac
    shift
done

# 检查输入文件
if [ $# -ne 1 ]; then
    echo "用法: $0 <运动员数据.tsv>"
    exit 1
fi

input_file="$1"
if [ ! -f "$input_file" ]; then
    echo "错误: 文件 $input_file 不存在"
    exit 1
fi

# 定义输出文件
output_file="运动员统计报告.txt"

# 主处理函数
process_data() {
    local file="$1"
    
    # 1. 年龄分布统计
    echo "1. 年龄分布统计"
    echo "----------------"
    awk -F'\t' '
    NR>1 {
        if ($6 < 20) under20++
        else if ($6 <= 30) between20_30++
        else over30++
        total++
    }
    END {
        printf "20岁以下: %d人 (%.1f%%)\n", under20, under20/total*100
        printf "20-30岁: %d人 (%.1f%%)\n", between20_30, between20_30/total*100
        printf "30岁以上: %d人 (%.1f%%)\n", over30, over30/total*100
        printf "总球员数: %d\n", total
    }' "$file"
    echo

    # 2. 场上位置统计
    echo "2. 场上位置统计"
    echo "----------------"
    awk -F'\t' '
    NR>1 {
        pos[$5]++
        total++
    }
    END {
        for (p in pos) {
            printf "%s: %d人 (%.1f%%)\n", p, pos[p], pos[p]/total*100
        }
    }' "$file" | sort -nr -k2
    echo

    # 3. 名字长度统计
    echo "3. 球员名字长度统计"
    echo "-------------------"
    awk -F'\t' '
    BEGIN {
        max_len = 0
        min_len = 100
    }
    NR>1 {
        len = length($9)
        name = $9
        
        # 处理最长名字
        if (len > max_len) {
            max_len = len
            longest = name
            longest_count = 1
        } else if (len == max_len) {
            longest = longest ", " name
            longest_count++
        }
        
        # 处理最短名字
        if (len < min_len) {
            min_len = len
            shortest = name
            shortest_count = 1
        } else if (len == min_len) {
            shortest = shortest ", " name
            shortest_count++
        }
    }
    END {
        printf "最长名字(%d字符): %s (共%d人)\n", max_len, longest, longest_count
        printf "最短名字(%d字符): %s (共%d人)\n", min_len, shortest, shortest_count
    }' "$file"
    echo

    # 4. 年龄极值统计
    echo "4. 年龄极值统计"
    echo "---------------"
    awk -F'\t' '
    BEGIN {
        max_age = 0
        min_age = 100
    }
    NR>1 {
        age = $6
        name = $9
        
        # 处理最大年龄
        if (age > max_age) {
            max_age = age
            oldest = name
            oldest_count = 1
        } else if (age == max_age) {
            oldest = oldest ", " name
            oldest_count++
        }
        
        # 处理最小年龄
        if (age < min_age) {
            min_age = age
            youngest = name
            youngest_count = 1
        } else if (age == min_age) {
            youngest = youngest ", " name
            youngest_count++
        }
    }
    END {
        printf "年龄最大(%d岁): %s (共%d人)\n", max_age, oldest, oldest_count
        printf "年龄最小(%d岁): %s (共%d人)\n", min_age, youngest, youngest_count
    }' "$file"
}

# 生成报告
{
    echo "===== 运动员数据统计分析报告 ====="
    echo "数据文件: $input_file"
    echo "=================================="
    echo
    
    process_data "$input_file"
} > "$output_file"

echo "统计分析完成！结果已保存到: $output_file"
