# 电子发票 PDF 汇总工具使用说明

## 第一次使用

1. 确认电脑已安装 Python 3.11 或更高版本。
2. 如果没有安装 Python，请到 https://www.python.org/downloads/ 下载并安装。
3. 安装 Python 时勾选 `Add python.exe to PATH`。
4. 双击 `install_dependencies.bat` 安装依赖。

## 日常使用

1. 把电子发票 PDF、图片或图片型 PDF 放入 `invoices` 文件夹。
2. 双击 `run.bat`。
3. 查看 `output\invoice_summary.xlsx`。

如果双击后没有正常生成表格，请把工具文件夹里的 `run_log.txt` 发回来。  
如果安装依赖失败，请把 `install_log.txt` 发回来。

如果 Excel 备注里出现“缺少OCR依赖”，请双击 `install_ocr_dependencies.bat`，装完后再双击 `run.bat`。

如果安装 OCR 依赖时出现 `DLL load failed` 或 `onnxruntime_pybind11_state`，请先双击 `install_windows_runtime.bat`，安装完成后再双击 `install_ocr_dependencies.bat`。

如果已经装完依赖但 Excel 里还是旧提示，请先关闭 Excel，再双击 `run.bat` 重新生成。程序会自动保留旧表里的录入日期。

## 汇总字段

表格会包含：

录入日期、文件名、发票号码、开票日期、发票类型、金额、税额、价税合计、项目名称、销售方名称、销售方纳税人识别号、购买方名称、购买方纳税人识别号、处理状态、备注。

结果会按录入日期升序排序；重复发票号码会在“发票号码”单元格标黄。

## 注意事项

- 当前版本优先处理税务平台下载的标准电子发票 PDF。
- 扫描件、图片型 PDF、JPG、PNG 等图片会自动尝试 OCR 图片识别。
- 如果处理状态不是“成功”，请查看“备注”列并人工复核。
