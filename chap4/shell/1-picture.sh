#!/usr/bin/env bash

# 默认参数
QUALITY=85
WIDTH=""
HEIGHT=""
WATERMARK=""
WATERMARK_COLOR="white"
WATERMARK_SIZE=20
WATERMARK_POSITION="southeast"
OUTPUT_DIR="output"
CONVERT_TO_JPG=false
RENAME_PATTERN="image_%03d"
EXTENSIONS=("jpg" "jpeg" "png" "svg")

# 显示帮助信息
show_help() {
    echo "图片批处理脚本 "
    echo "用法: $0 [选项] <输入目录>"
    echo
    echo "选项:"
    echo "  -h, --help            显示此帮助信息"
    echo "  -q, --quality <1-100> 设置JPEG质量 (默认: 85)"
    echo "  -w, --width <像素>    设置缩放宽度 (保持比例)"
    echo "  --height <像素>       设置缩放高度 (保持比例)"
    echo "  -m, --watermark <文本> 添加文字水印"
    echo "  --wc, --watermark-color <颜色> 水印颜色 (默认: white)"
    echo "  --ws, --watermark-size <大小> 水印字体大小 (默认: 20)"
    echo "  --wp, --watermark-position <位置> 水印位置 (north, south, east, west, center等, 默认: southeast)"
    echo "  -o, --output <目录>   指定输出目录 (默认: ./output)"
    echo "  -c, --convert-to-jpg   将PNG/SVG转换为JPG格式"
    echo "  -r, --rename <模式>    重命名文件 (使用printf模式, 如: image_%03d)"
    echo "  -e, --ext <扩展名>     指定处理文件扩展名 (默认: jpg jpeg png svg)"
    echo
    echo "示例:"
    echo "  $0 -q 90 -w 1024 ~/images"
    echo "  $0 -m \"Confidential\" --wc red --ws 24 ~/photos"
    echo "  $0 -c -r \"vacation_%02d\" ~/pictures"
    exit 0
}


# 检查依赖
check_dependencies() {
    if ! command -v convert &> /dev/null; then
        echo "错误: ImageMagick未安装，请先安装ImageMagick"
        echo "在Ubuntu/Debian上可以使用: sudo apt install imagemagick"
        exit 1
    fi
}

# 处理图片
process_image() {
    local input_file="$1"
    local output_file="$2"
    local filename=$(basename -- "$input_file")
    local extension="${filename##*.}"
    local name="${filename%.*}"

    # 确定输出文件名
    if [ "$CONVERT_TO_JPG" = true ] && [[ "$extension" =~ ^(png|svg)$ ]]; then
        output_file="${output_file%.*}.jpg"
    fi

    echo "正在处理: $input_file"

    # 构建ImageMagick命令
    local cmd="convert \"$input_file\""

    # 添加质量参数 (仅对JPEG有效)
    if [[ "$output_file" =~ \.(jpg|jpeg)$ ]]; then
        cmd+=" -quality $QUALITY"
    fi

    # 添加缩放参数
    if [ -n "$WIDTH" ] || [ -n "$HEIGHT" ]; then
        if [ -n "$WIDTH" ] && [ -n "$HEIGHT" ]; then
            cmd+=" -resize ${WIDTH}x${HEIGHT}"
        elif [ -n "$WIDTH" ]; then
            cmd+=" -resize $WIDTH"
        else
            cmd+=" -resize x$HEIGHT"
        fi
    fi

    # 添加水印参数
    if [ -n "$WATERMARK" ]; then
        cmd+=" -fill \"$WATERMARK_COLOR\" -pointsize $WATERMARK_SIZE"
        cmd+=" -gravity $WATERMARK_POSITION"
        cmd+=" -draw \"text 10,10 '$WATERMARK'\""
    fi

    cmd+=" \"$output_file\""

    # 执行命令
    if ! eval "$cmd"; then
        echo "错误: 处理文件失败 $input_file"
        return 1
    fi

    return 0
}

# 主函数
main() {
    check_dependencies

    # 解析参数
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                ;;
            -q|--quality)
                QUALITY="$2"
                if ! [[ "$QUALITY" =~ ^[0-9]+$ ]] || [ "$QUALITY" -lt 1 ] || [ "$QUALITY" -gt 100 ]; then
                    echo "错误: 质量参数必须是1-100之间的整数"
                    exit 1
                fi
                shift
                ;;
            -w|--width)
                WIDTH="$2"
                if ! [[ "$WIDTH" =~ ^[0-9]+$ ]]; then
                    echo "错误: 宽度必须是正整数"
                    exit 1
                fi
                shift
                ;;
            --height)
                HEIGHT="$2"
                if ! [[ "$HEIGHT" =~ ^[0-9]+$ ]]; then
                    echo "错误: 高度必须是正整数"
                    exit 1
                fi
                shift
                ;;
            -m|--watermark)
                WATERMARK="$2"
                shift
                ;;
            --wc|--watermark-color)
                WATERMARK_COLOR="$2"
                shift
                ;;
            --ws|--watermark-size)
                WATERMARK_SIZE="$2"
                if ! [[ "$WATERMARK_SIZE" =~ ^[0-9]+$ ]]; then
                    echo "错误: 水印大小必须是正整数"
                    exit 1
                fi
                shift
                ;;
            --wp|--watermark-position)
                WATERMARK_POSITION="$2"
                shift
                ;;
            -o|--output)
                OUTPUT_DIR="$2"
                shift
                ;;
            -c|--convert-to-jpg)
                CONVERT_TO_JPG=true
                ;;
            -r|--rename)
                RENAME_PATTERN="$2"
                shift
                ;;
            -e|--ext)
                shift
                EXTENSIONS=()
                while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                    EXTENSIONS+=("$1")
                    shift
                done
                continue
                ;;
            *)
                INPUT_DIR="$1"
                ;;
        esac
        shift
    done

    # 验证输入目录
    if [ -z "$INPUT_DIR" ]; then
        echo "错误: 必须指定输入目录"
        show_help
        exit 1
    fi

    if [ ! -d "$INPUT_DIR" ]; then
        echo "错误: 输入目录不存在 [$INPUT_DIR]"
        exit 1
    fi

    # 创建输出目录
    mkdir -p "$OUTPUT_DIR"

    # 处理计数器
    local count=0
    local total=0

    # 先统计总文件数
    for ext in "${EXTENSIONS[@]}"; do
        while IFS= read -r -d $'\0' file; do
            ((total++))
        done < <(find "$INPUT_DIR" -type f -iname "*.$ext" -print0)
    done

    # 处理文件
    for ext in "${EXTENSIONS[@]}"; do
        while IFS= read -r -d $'\0' file; do
            # 生成输出文件名
            if [ "$RENAME_PATTERN" != "" ]; then
                output_file="$OUTPUT_DIR/$(printf "$RENAME_PATTERN.$ext" $((count + 1)))"
            else
                output_file="$OUTPUT_DIR/$(basename "$file")"
            fi

            if process_image "$file" "$output_file"; then
                ((count++))
                echo "进度: $count/$total"
            fi
        done < <(find "$INPUT_DIR" -type f -iname "*.$ext" -print0)
    done

    echo
    echo "处理完成! 共成功处理 $count 张图片"
    echo "输出目录: $OUTPUT_DIR"
}

# 运行主函数
main "$@"
