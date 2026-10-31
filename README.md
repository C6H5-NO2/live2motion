# live2motion

`live2motion` is a Python console utility that converts [Live Photos](https://developer.apple.com/documentation/photokit/displaying-live-photos) into [Motion Photos](https://developer.android.com/media/platform/motion-photo-format).


## Usage

```
usage: python -m live2motion [-h] -i IMAGE -v VIDEO -o OUTPUT [-x EXIFTOOL]

options:
  -h, --help            show this help message and exit
  -i, --image IMAGE     path to a still photo
  -v, --video VIDEO     path to a video
  -o, --output OUTPUT   path to the output motion photo
  -x, --exiftool EXIFTOOL
                        path to ExifTool executable
```
