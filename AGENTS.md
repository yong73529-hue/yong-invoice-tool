# Agent Instructions

This repository contains a Chinese invoice extraction tool for reimbursement workflows.
These instructions are for coding agents such as Codex, Claude Code, OpenClaw/OpenCode-style agents, Cursor agents, and other shell-capable assistants.

## What This Tool Does

The tool reads Chinese invoice PDF/image files from `invoices/` and writes an Excel summary to `output/invoice_summary.xlsx`.

Supported inputs:
- Text-based PDF invoices.
- Image-only PDF invoices through OCR.
- Image files: `.jpg`, `.jpeg`, `.png`, `.bmp`, `.tif`, `.tiff`.

Main script:
- `extract_invoices.py`

Windows finance entrypoints:
- `run.bat`
- `install_dependencies.bat`

Python packaging entrypoint:
- `py -3 -m extract_invoices`
- `yong-invoice-tool` if the Python Scripts directory is on `PATH`.

## Field Contract

The Excel output must keep these columns in this order:

`录入日期, 文件名, 发票号码, 开票日期, 发票类型, 金额, 税额, 价税合计, 项目名称, 销售方名称, 销售方纳税人识别号, 购买方名称, 购买方纳税人识别号, 处理状态, 备注`

Rules:
- `录入日期` uses the input file creation date on the current machine.
- Sort by `录入日期` ascending, then filename ascending.
- Mark all duplicated `发票号码` cells yellow.
- Append `发票号码重复` to remarks for duplicate invoice numbers.
- OCR rows must append `OCR识别，请人工复核`.
- If `output/invoice_summary.xlsx` is open or locked, write a timestamped Excel file instead of failing.

## How Agents Should Run It

Install dependencies:

```powershell
py -3 -m pip install -r requirements.txt
```

Run in this repository:

```powershell
py -3 extract_invoices.py
```

Run after pip installation from any working folder:

```powershell
py -3 -m extract_invoices
```

Force a specific base folder:

```powershell
$env:YONG_INVOICE_BASE_DIR = "C:\invoice-tool"
py -3 -m extract_invoices
```

## Troubleshooting Workflow

When a sample invoice fails:

1. Inspect extracted text/OCR text for that exact file.
2. Inspect the parsed fields for that exact file.
3. Patch the smallest parsing rule that covers the observed layout.
4. Run syntax checks and targeted parsing tests.
5. Regenerate the Excel summary if the user expects output.

Useful PowerShell commands:

```powershell
$env:PYTHONIOENCODING='utf-8'; py -3 -c "from pathlib import Path; from extract_invoices import read_document_text; p=Path(r'PATH_TO_FILE'); text, used=read_document_text(p); print('OCR', used); print(text[:5000])"
```

```powershell
$env:PYTHONIOENCODING='utf-8'; py -3 -c "from pathlib import Path; from extract_invoices import parse_invoice_rows; rows=parse_invoice_rows(Path(r'PATH_TO_FILE')); print(len(rows)); [print(r) for r in rows]"
```

Syntax check:

```powershell
py -3 -m py_compile extract_invoices.py
```

## Safety Rules

Never commit or publish real invoice data.

Do not add these to Git:
- `invoices/`
- `output/`
- PDF/image invoice files.
- Excel output files.
- Generated zip packages.
- OCR screenshots or source photos.

Before committing, check:

```powershell
git status --short
git ls-files | Select-String -Pattern '\.(pdf|jpg|jpeg|png|bmp|tif|tiff|xlsx|xls|csv|zip)$|^invoices/|^output/'
```

The second command should print nothing.

## Packaging For Finance

Prefer update-only packages when finance already has the tool, because replacing the whole folder can change `录入日期`.

Include only:
- `extract_invoices.py`
- `requirements.txt`
- `run.bat`
- `install_dependencies.bat`
- `FINANCE_README.md`
- `VERSION.txt`

Do not include `invoices/`, `output/`, real invoices, images, Excel files, or old zip files.

If OCR dependencies changed, tell finance to run `install_dependencies.bat` once.
