#!/bin/bash

tmp_img="/tmp/ocr_region_$(date +%s).png"
tmp_txt="/tmp/ocr_text_$(date +%s).txt"

region=$(slurp)
if [[ -z "$region" ]]; then
  echo "❌ No region selected."
  exit 1
fi

grim -g "$region" "$tmp_img"

tesseract "$tmp_img" "${tmp_txt%.*}" -l jpn --dpi 300 &>/dev/null

if [[ -f "$tmp_txt" ]]; then
  wl-copy < "$tmp_txt"
  notify-send "🈶 OCR complete" "Text copied to clipboard."
  echo "✅ OCR complete! Text copied to clipboard:"
  echo "----------------------------------------"
  cat "$tmp_txt"
  echo "----------------------------------------"
else
  echo "❌ OCR failed!"
fi

# 🧹 Clean up
rm -f "$tmp_img" "$tmp_txt"
