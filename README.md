# Image Optimizer

`imageOptimizer` is a script designed to monitor a specific directory for image files. It automatically processes newly added images by converting certain formats to JPEG and resizing them to ensure they don't exceed Full HD resolution (1920x1080) while preserving their aspect ratio.

## Features

- **Automatic Image Conversion**: Converts `.webp` and `.avif` files to JPEG format.
- **Image Resizing**: Resizes images larger than Full HD resolution to fit within a 1920x1080 frame while maintaining aspect ratio.
- **Directory Monitoring**: Continuously watches a specified directory for new image files.

## Dependencies

To use the `imageOptimizer` script, you'll need the following tools installed on your system:

1. **[fswatch](https://github.com/emcrisostomo/fswatch)**:
   - A file change monitor that triggers the script when new files are added to the directory.
   - Installation (using Homebrew):
     ```bash
     brew install fswatch
     ```

2. **[ImageMagick](https://imagemagick.org/index.php)**:
   - A software suite to create, edit, compose, or convert bitmap images.
   - Includes the `magick` command used for image conversion and resizing.
   - Installation (using Homebrew):
     ```bash
     brew install imagemagick
     ```

## Installation

1. **Clone the Repository**:
   git clone https://github.com/yourusername/imageOptimizer.git
   cd imageOptimizer

2.	Make the Script Executable:
   chmod +x imageOptimizer.sh
