import time 
from PIL import Image
from PIL import ImageFilter 
from pathlib import Path as P
from multiprocessing import Pool
imputFolder ="imageDir"
outputFolder = "processed"

P(outputFolder).mkdir(exist_ok=True)
P(imputFolder).mkdir(exist_ok=True)

def imageConverting(imagePath):
    img = Image.open(imagePath)
    img = img.rotate(-90, expand=True)
    img = img.resize((800, 600), Image.LANCZOS)
    img =img.convert("L")
    outPath = P(outputFolder)/f"out_{P(imagePath).name}"
    img.save(outPath)

def lineConverting(imageDir):
    start = time.perf_counter()
    for i in imageDir:
        imageConverting(i)
    end = time.perf_counter()
    print(F"Последовательная обработка завершина: {end - start:.2f} cекунд")

def poolConverting(imageDir):
    start = time.perf_counter()

    with Pool() as pool:
        pool.map(imageConverting, imageDir)

    end = time.perf_counter()
    print(F"Паралельная обработка завершина: {end - start:.2f} cекунд")
if __name__ == "__main__":
    imageDir = list(P(imputFolder).glob("*.jpg"))
    lineConverting(imageDir)
    poolConverting(imageDir)
    print(imageDir)


