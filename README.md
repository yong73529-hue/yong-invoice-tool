# 电子发票汇总工具

这个工具用来批量整理电子发票。把 PDF 或图片发票放进 `invoices` 文件夹，运行后会在 `output` 文件夹生成一份 Excel 汇总表。

## 功能

- 提取发票号码、开票日期、发票类型、金额、税额、价税合计、项目名称、销售方和购买方信息。
- 优先读取标准电子发票 PDF 里的文字，速度快，准确率也更高。
- 如果是扫描件或图片发票，会自动尝试 OCR 识别。
- 支持 PDF、JPG、JPEG、PNG、BMP、TIF、TIFF 文件。
- 多页图片型 PDF 会按页拆成多条记录。
- 汇总结果按录入日期排序，重复发票号码会标黄。

## 直接使用

1. 安装 Python 3.11 或更新版本。
2. 第一次使用时双击 `install_dependencies.bat`。
3. 把发票文件放到 `invoices` 文件夹。
4. 双击 `run.bat`。
5. 查看 `output\invoice_summary.xlsx`。

## pip 安装

也可以直接从 GitHub 安装：

```powershell
py -3 -m pip install git+https://github.com/yong73529-hue/yong-invoice-tool.git
```

进入你准备用来放发票的文件夹后运行：

```powershell
mkdir invoices
py -3 -m extract_invoices
```

程序会读取当前文件夹下的 `invoices`，并生成 `output\invoice_summary.xlsx`。

如果要指定固定目录，可以先设置 `YONG_INVOICE_BASE_DIR`：

```powershell
$env:YONG_INVOICE_BASE_DIR = "D:\project2"
py -3 -m extract_invoices
```

## 注意

- 不要把真实发票、截图、图片、Excel 输出或压缩包提交到 GitHub。
- OCR 识别的结果会在备注里标记“OCR识别，请人工复核”，报销前建议人工看一遍。
- 如果遇到新的发票样式识别不准，通常需要在 `extract_invoices.py` 里补一条解析规则。

## 给维护者

`AGENTS.md` 里写了排查步骤、字段顺序和提交前检查项，后面维护时可以先看那份文件。
