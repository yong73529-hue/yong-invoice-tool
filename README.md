# Chinese Invoice Extractor

Batch extract fields from Chinese electronic invoices in PDF or image form and export an Excel summary for reimbursement review.

## Features

- Extracts invoice number, issue date, invoice type, amounts, item names, seller and buyer details.
- Supports text-based PDF invoices first for accuracy and speed.
- Falls back to OCR for image-only PDFs and image files (`jpg`, `png`, `bmp`, `tif`).
- Splits image-only multipage PDFs into one Excel row per page.
- Sorts by file entry date and highlights duplicate invoice numbers.

## Quick Start

1. Install Python 3.11 or newer.
2. Run `install_dependencies.bat` once.
3. Put invoice files into an `invoices` folder next to the scripts.
4. Double-click `run.bat`.
5. Review `output/invoice_summary.xlsx`.

## Install With Pip

You can also install the tool directly from GitHub:

```powershell
py -3 -m pip install git+https://github.com/yong73529-hue/yong-invoice-tool.git
```

Then run it in the folder where you want to keep invoice files:

```powershell
mkdir invoices
py -3 -m extract_invoices
```

The command reads `invoices` under the current folder and writes `output\invoice_summary.xlsx`.
If your Python Scripts folder is already in `PATH`, you can also run `yong-invoice-tool`.

To force another working folder, set `YONG_INVOICE_BASE_DIR` before running:

```powershell
$env:YONG_INVOICE_BASE_DIR = "D:\project2"
py -3 -m extract_invoices
```

## Security Notice

Do not commit real invoices, screenshots, OCR source images, Excel outputs, or generated ZIP packages. The repository `.gitignore` intentionally excludes those files.

OCR rows are marked with `OCR识别，请人工复核` and should be reviewed manually before reimbursement decisions.

## Codex Skill

This repository includes `skills/chinese-invoice-extractor`, a Codex skill that documents the maintenance workflow, known invoice layout patterns, and update packaging rules.

To use the skill in another Codex environment, copy the folder:

```text
skills/chinese-invoice-extractor
```

into:

```text
C:\Users\<你的用户名>\.codex\skills\chinese-invoice-extractor
```

After restarting Codex, ask Codex to use `chinese-invoice-extractor` for invoice extraction or troubleshooting tasks. The skill teaches Codex how to maintain and extend the workflow; it is separate from the `pip` command-line installer.

## Other Agents

Other coding agents do not need the Codex skill system. They can use this repository in two ways:

- Run the Python tool with `py -3 -m extract_invoices` after installing from GitHub with pip.
- Read `AGENTS.md` for the maintenance workflow, parsing rules, test commands, and data-safety rules.

Claude Code can also read `CLAUDE.md`, which points it to the same shared agent instructions.
