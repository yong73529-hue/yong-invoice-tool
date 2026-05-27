---
name: chinese-invoice-extractor
description: Maintain, extend, and use the Chinese electronic invoice extraction workflow for finance reimbursement. Use when Codex needs to extract invoice fields from Chinese PDF/JPG/PNG invoices, troubleshoot missing fields, add parsing/OCR rules for new invoice layouts, generate Excel summaries, package update-only ZIPs, or preserve invoice input folders and entry dates while updating the tool.
---

# Chinese Invoice Extractor

Use this skill for this repository and for similar Chinese electronic invoice extraction tasks.

## Core Workflow

1. Inspect the current project before editing:
   - Main tool: `extract_invoices.py`
   - Input folder: `invoices`
   - Output folder: `output`
   - Entry scripts: `run.bat`, `install_dependencies.bat`, `install_ocr_dependencies.bat`
   - Dependencies: `requirements.txt`
2. For new failing samples, first print extracted text/OCR text and parse result for the specific file.
3. Patch the smallest parsing rule that covers the observed layout.
4. Run syntax check and representative extraction tests.
5. Regenerate the Excel summary.
6. If the user needs to send an update to finance, create a “只更新程序文件” ZIP unless a full fresh tool package is explicitly requested.

## Current Field Contract

The Excel output must contain these columns in this order:

`录入日期, 文件名, 发票号码, 开票日期, 发票类型, 金额, 税额, 价税合计, 项目名称, 销售方名称, 销售方纳税人识别号, 购买方名称, 购买方纳税人识别号, 处理状态, 备注`

Rules:
- `录入日期` uses the file creation date on the current machine.
- Sort by `录入日期` ascending, then filename ascending.
- Duplicate invoice numbers: mark every duplicated `发票号码` cell yellow and append `发票号码重复` to remarks.
- OCR rows must append `OCR识别，请人工复核` to remarks even if successful.
- If the default Excel file is open, write a timestamped `invoice_summary_YYYYMMDD_HHMMSS.xlsx` instead of failing.

## OCR Expectations

The tool supports:
- Text-based PDF extraction first.
- OCR fallback for image-only PDFs.
- Direct image inputs: `.jpg`, `.jpeg`, `.png`, `.bmp`, `.tif`, `.tiff`.
- Image-only multipage PDFs: output one row per page, using filenames like `原文件.pdf 第1页`.

OCR dependencies are Python packages only: `rapidocr_onnxruntime`, `pypdfium2`, `Pillow`, `numpy`, plus the existing spreadsheet/PDF packages.

## Typical Troubleshooting Commands

Use PowerShell with UTF-8 Python output:

```powershell
$env:PYTHONIOENCODING='utf-8'; py -3 -c "from pathlib import Path; from extract_invoices import parse_invoice; p=Path(r'PATH_TO_FILE'); print(parse_invoice(p))"
```

For OCR text:

```powershell
$env:PYTHONIOENCODING='utf-8'; py -3 -c "from pathlib import Path; from extract_invoices import read_document_text; p=Path(r'PATH_TO_FILE'); text, used=read_document_text(p); print('OCR', used); print(text[:5000])"
```

For image-only multipage PDF rows:

```powershell
$env:PYTHONIOENCODING='utf-8'; py -3 -c "from pathlib import Path; from extract_invoices import parse_invoice_rows; rows=parse_invoice_rows(Path(r'PATH_TO_FILE')); print(len(rows)); [print(r) for r in rows]"
```

## Packaging Rules

Prefer update-only packages to avoid changing `录入日期`:

- Include: `extract_invoices.py`, `requirements.txt`, `run.bat`, `install_dependencies.bat`, `FINANCE_README.md`, `VERSION.txt`.
- Do not include `invoices` or existing invoice files.
- Tell finance to copy/overwrite program files only and not move invoice PDFs.
- If OCR dependencies changed, tell finance to run `install_dependencies.bat` once.
- If only OCR dependencies are missing, tell finance to run `install_ocr_dependencies.bat`.

Use names like:

`电子发票工具_只更新程序文件_<简短修复说明>.zip`

Create full packages only when the user asks for a clean handoff package.

## Bundled Resources

- `scripts/extract_invoices.py`: current production script template.
- `scripts/requirements.txt`: dependency list.
- `scripts/run.bat`, `scripts/install_dependencies.bat`, and `scripts/install_ocr_dependencies.bat`: Windows entrypoints.
- `references/layout-notes.md`: known invoice layout patterns and fixes.
