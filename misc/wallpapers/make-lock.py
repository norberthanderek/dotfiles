#!/usr/bin/env python3
"""Build the dimmed, blurred -lock.png swaylock uses. Usage: ./make-lock.py [source.jpg]"""
import sys
from pathlib import Path

from PIL import Image, ImageChops, ImageEnhance, ImageFilter

BRIGHTNESS = 0.30
GRAIN = 2.0
STORE_W = 1280
BLUR_DIV = 8
BLUR = 2


def build(src_path: Path) -> Image.Image:
    src = Image.open(src_path).convert("RGB")
    w = min(src.width, STORE_W)
    h = round(src.height * w / src.width)
    # blur via downscale so it interpolates in float, PIL's 8-bit GaussianBlur bands on its own
    small = src.resize((w // BLUR_DIV, h // BLUR_DIV), Image.Resampling.LANCZOS)
    small = small.filter(ImageFilter.GaussianBlur(BLUR))
    small = ImageEnhance.Brightness(small).enhance(BRIGHTNESS)
    out = small.resize((w, h), Image.Resampling.BICUBIC)
    # dither or the dimmed gradient bands. keep PNG, JPEG turns this into block artifacts
    return Image.merge(
        "RGB",
        [ImageChops.add(c, Image.effect_noise((w, h), GRAIN), 1.0, -128) for c in out.split()],
    )


def main() -> None:
    here = Path(__file__).resolve().parent
    src = Path(sys.argv[1]) if len(sys.argv) > 1 else here / "robot-stalenhag.jpg"
    dst = src.with_name(f"{src.stem}-lock.png")
    build(src).save(dst, optimize=True)
    print(f"{dst.name}  {dst.stat().st_size // 1024} KB")


if __name__ == "__main__":
    main()
