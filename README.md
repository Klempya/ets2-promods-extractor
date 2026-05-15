# ProMods Automatic Extractor

A simple Windows batch script that automatically extracts **ProMods** multi-volume 7-Zip archives (`.7z.001`, `.7z.002`, …) with a single double-click — no command-line knowledge required.

---

## Table of Contents

- [What does it do?](#what-does-it-do)
- [Requirements](#requirements)
- [How to use](#how-to-use)
- [Customising the output folder](#customising-the-output-folder)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)

---

## What does it do?

ProMods is distributed as a split archive — many files named `.7z.001`, `.7z.002`, `.7z.003`, etc. that must all be present before extraction can begin. This script:

1. Automatically finds **7-Zip** on your computer.
2. Detects the first volume (`.7z.001`) in the same folder.
3. Extracts **all volumes at once** into the folder of your choice.
4. Reports any errors clearly so you know exactly what went wrong.

---

## Requirements

| Requirement | Details |
|---|---|
| **Operating system** | Windows 10 or Windows 11 |
| **7-Zip** | Free — download from [7-zip.org](https://www.7-zip.org) |
| **Archive files** | All volumes must be present (`.7z.001` through the last part) |
| **Disk space** | Enough free space for the extracted files (~3–4 GB for a full ProMods install) |

> **Note:** The script automatically searches for 7-Zip in the standard installation folders (`Program Files` and `Program Files (x86)`), as well as anywhere on your system `PATH`. As long as you installed 7-Zip normally, no configuration is needed.

---

## How to use

### Step 1 — Install 7-Zip

If you don't have 7-Zip yet:

1. Go to [https://www.7-zip.org](https://www.7-zip.org)
2. Download the installer that matches your system (usually **64-bit Windows**)
3. Run the installer and follow the prompts

### Step 2 — Download all archive volumes

Make sure you have **every** part of the ProMods archive in the same folder:

```
📁 Downloads\ProMods\
    ProMods_2.xx.7z.001
    ProMods_2.xx.7z.002
    ProMods_2.xx.7z.003
    ...
    ProMods_2.xx.7z.013
    extract_promods.bat   ← place the script here too
```

> ⚠️ If even one volume is missing or corrupted, extraction will fail. Make sure all downloads completed successfully.

### Step 3 — Place the script

Copy `extract_promods.bat` into the **same folder** as all your `.7z.00x` files.

### Step 4 — Run the script

**Double-click** `extract_promods.bat`.

A console window will open. You will see:

- ✅ Confirmation that 7-Zip was found
- ✅ Confirmation of the detected archive
- 📊 A live progress bar during extraction
- ✅ A success message when everything is done

Press any key to close the window once extraction is complete.

---

## Customising the output folder

By default, files are extracted **into the same folder as the script**. If you want to extract directly into your ETS2 mod folder (or any other location), open `extract_promods.bat` in Notepad and find this line near the bottom:

```batch
set "OUTPUT_DIR=%SCRIPT_DIR%"
```

Replace it with your desired path, for example:

```batch
set "OUTPUT_DIR=C:\Users\YourName\Documents\Euro Truck Simulator 2\mod"
```

Save the file and run it again.

---

## Troubleshooting

### `[ERROR] 7-Zip was not found`

7-Zip is either not installed or was installed in an unusual location.

- **Fix:** Download and install 7-Zip from [7-zip.org](https://www.7-zip.org), using the default installation path. Run the script again.

---

### `[ERROR] No .7z.001 file was found in this folder`

The script cannot find the first volume of the archive.

- **Fix:** Make sure `extract_promods.bat` is in the **same folder** as your `.7z.001` file.

---

### `[ERROR] Extraction failed (exit code: X)`

Something went wrong during extraction. Common causes:

| Cause | Solution |
|---|---|
| A volume file is missing | Re-download the missing part |
| A volume file is corrupted | Re-download that specific file |
| Not enough disk space | Free up space and try again |
| Antivirus blocked extraction | Temporarily disable real-time protection and retry |

---

### The console window opens and closes immediately

This usually means the script ran into an error before it could pause. Try running it differently:

1. Open **File Explorer** and navigate to the folder
2. Click the address bar and type `cmd`, then press Enter
3. In the command prompt, type `extract_promods.bat` and press Enter

You will now see the full error message without the window closing.

---

## FAQ

**Can I delete the `.7z.00x` files after extraction?**  
Yes. Once extraction is confirmed successful, the archive volumes are no longer needed. You can delete them to free up disk space.

**Where do I put the extracted `.scs` files?**  
Place all `.scs` files (and the contents of the `.zip` file) into your ETS2 mod folder, typically located at:  
`Documents\Euro Truck Simulator 2\mod\`

**Does this work with other games or archives?**  
The script works with any split 7-Zip archive (`.7z.001`, `.7z.002`, …), not just ProMods. Simply adjust the output folder if needed.

**Will it overwrite my existing files?**  
Yes — the `-aoa` flag tells 7-Zip to overwrite without asking. Back up your mod folder first if needed.

---

## License

This script is released under the [MIT License](LICENSE). Feel free to use, modify, and share it.
