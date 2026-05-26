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

## Security Notice

Do not commit real invoices, screenshots, OCR source images, Excel outputs, or generated ZIP packages. The repository `.gitignore` intentionally excludes those files.

OCR rows are marked with `OCR识别，请人工复核` and should be reviewed manually before reimbursement decisions.

## Codex Skill

This repository includes `skills/chinese-invoice-extractor`, a Codex skill that documents the maintenance workflow, known invoice layout patterns, and update packaging rules.
