# Claude Instructions

This project is a Chinese invoice extraction tool. Follow `AGENTS.md` for the full workflow, field contract, test commands, and safety rules.

Most common actions:

```powershell
py -3 -m pip install -r requirements.txt
py -3 -m py_compile extract_invoices.py
py -3 extract_invoices.py
```

After pip installation from GitHub:

```powershell
py -3 -m extract_invoices
```

Important: never commit real invoices, OCR images, Excel outputs, or generated zip files.

