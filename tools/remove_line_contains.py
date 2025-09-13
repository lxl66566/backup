# -*- coding: utf-8 -*-


def remove_lines_with_keywords(input_file, output_file, keywords):
    """
    从输入文件中移除包含任何指定关键字的行，并将结果写入输出文件。

    参数:
    input_file (str): 输入文件的路径。
    output_file (str): 输出文件的路径。
    keywords (list): 要匹配的关键字字符串列表。
    """
    try:
        with (
            open(input_file, "r", encoding="utf-8") as infile,
            open(output_file, "w", encoding="utf-8") as outfile,
        ):
            for line in infile:
                # 检查该行是否包含任何一个关键字
                # any() 函数如果可迭代对象中有一个元素为真，则返回 True
                if not any(keyword in line for keyword in keywords):
                    outfile.write(line)

        print(f"处理完成。已将结果写入 {output_file}")

    except FileNotFoundError:
        print(f"错误：找不到输入文件 {input_file}")
    except Exception as e:
        print(f"发生错误：{e}")


# --- 使用示例 ---

# 1. 定义您的关键字列表
# 任何包含以下列表中一个或多个词的行都将被删除
unwanted_keywords = []

# 2. 定义输入和输出文件名
input_file = "Browser/htu_backup/htu_backup_20250913_100805.tsv"
output_filename = "Browser/htu_backup/htu_backup_20250913_100805_processed.tsv"

# 3. 调用函数
remove_lines_with_keywords(input_file, output_filename, unwanted_keywords)
