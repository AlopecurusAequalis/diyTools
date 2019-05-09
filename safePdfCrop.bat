@echo off
for %%A in (*.pdf) do (
  call pdfcrop %%A %%A
)