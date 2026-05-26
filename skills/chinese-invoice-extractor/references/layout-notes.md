# Known Layout Notes

Keep this file focused on non-obvious patterns encountered in real samples.

## Chinese E-Invoice Layouts

- Standard digital invoice text often uses `购 名称... 销 名称...` or `买 名 称 ... 售 名 称 ...`; spaces and colons may be missing or moved to the next line.
- Some PDFs put `发票号码：` and `开票日期：` as empty labels, then place the actual 20-digit invoice number and date later near the tax seal. Fall back to standalone 20-digit numbers and standalone dates.
- Sales/purchase names may appear as two company names on the line before two tax IDs.
- Names may use store suffixes: `食铺`, `饭店`, `餐饮店`, `小吃店`, `制作部`, `服务部`, `超市`, `花店`.
- OCR sometimes reads `普通发票` as `曾通发票` or `普发票`.
- OCR sometimes splits `增值税专用发票` into `增值税...用发票`; treat this as `增值税专用发票` if no ordinary invoice marker is present.

## JD / Platform Invoices

- `名 称` may contain spaces and may have no inline colon.
- `统一社会信用代码 纳税人识别号` may omit `/`.
- Total amount may be written with unusual symbols such as `´59.56`.
- Pure numeric tax IDs can appear and must not be discarded.

## OCR Image Patterns

- OCR text may list blocks as:
  - `购买方信息`
  - `名称：...`
  - `销售方信息`
  - `名称：...`
- If OCR puts `名称：` on one line and the actual company name later, search nearby following lines for a valid company/store name.
- OCR may insert spaces into numbers like `1. 23` or `￥21. 70`; normalize these before parsing.
- For multipage image-only PDFs, parse each rendered page independently to avoid mixing two invoices into one row.
- If OCR confuses tax amount and total amount, calculate tax as `价税合计 - 金额` or total as `金额 + 税额` when needed.

## Validation Checklist

After changing parsing rules:

1. `py -3 -m py_compile extract_invoices.py`
2. Parse the failing sample directly.
3. Run `py -3 extract_invoices.py` in the project.
4. Inspect failing rows: `处理状态 != 成功`.
5. If update is for finance, create update-only ZIP and mention whether `install_dependencies.bat` is required.
