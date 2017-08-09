#!/usr/bin/awk -f

# 掩码分类函数
function classify_mask(arr_mask)
{
    if(arr_mask[1] == 255) {
        if(arr_mask[2] != 255) {
            return "A"
        } else {
            if(arr_mask[3] != 255) {
                return "B"
            } else {
                return "C"
            }
        }
    } else {
        return "N"
    }
}

# 数组打印函数
function print_array(arr)
{
    for (i in arr) {
        print i, arr[i]
    }
}

BEGIN {
    FS=","
}

{
    # 提取 IP 字段
    split($1, arr1, /=/);
    split($2, arr2, /=/);
    # 剔除引号
    gsub(/"/, "", arr1[2])
    gsub(/"/, "", arr2[2])
    # 将点分十进制转为数组
    split(arr1[2], arr_src_mask, /\./)
    split(arr2[2], arr_dest_mask, /\./)
    # 分类并计数
    src_type = classify_mask(arr_src_mask)
    src_count[src_type] += 1
    dest_type = classify_mask(arr_dest_mask)
    dest_count[dest_type] += 1
    # 打印结果
    print NR, src_type, dest_type, $0
}

END {
    # 打印统计结果
    print "---- SRC ----"
    print_array(src_count)
    print "---- DEST ----"
    print_array(dest_count)
    
}
